/**
 * Sprite Sheet Editor
 * Upload a sprite sheet, configure grid, select frames, preview animation, export optimized sheet.
 */
(function () {
    'use strict';

    // ===== State =====
    const state = {
        image: null,           // HTMLImageElement
        fileName: '',          // Original file name (without extension)
        fileExt: '',           // Original file extension
        cols: 1,
        rows: 1,
        frameWidth: 0,
        frameHeight: 0,
        totalFrames: 0,
        selectedFrames: new Set(),
        animMode: 'loop',      // 'loop' | 'noloop' | 'yoyo'
        fps: 12,
        downloadCount: 1,
        phaserGame: null,
        phaserScene: null,
    };

    // ===== DOM References =====
    const dom = {
        dropZone: document.getElementById('drop-zone'),
        fileInput: document.getElementById('file-input'),
        fileInfo: document.getElementById('file-info'),
        controlsPanel: document.getElementById('controls-panel'),
        colsInput: document.getElementById('cols-input'),
        rowsInput: document.getElementById('rows-input'),
        frameDimensions: document.getElementById('frame-dimensions'),
        modeLoop: document.getElementById('mode-loop'),
        modeNoloop: document.getElementById('mode-noloop'),
        modeYoyo: document.getElementById('mode-yoyo'),
        fpsSlider: document.getElementById('fps-slider'),
        fpsValue: document.getElementById('fps-value'),
        playBtn: document.getElementById('play-btn'),
        pauseBtn: document.getElementById('pause-btn'),
        stopBtn: document.getElementById('stop-btn'),
        selectAll: document.getElementById('select-all'),
        deselectAll: document.getElementById('deselect-all'),
        frameRangeInput: document.getElementById('frame-range-input'),
        selectionCount: document.getElementById('selection-count'),
        downloadBtn: document.getElementById('download-btn'),
        emptyState: document.getElementById('empty-state'),
        gridWarning: document.getElementById('grid-warning'),
        editorView: document.getElementById('editor-view'),
        phaserContainer: document.getElementById('phaser-container'),
        rangeSliderContainer: document.getElementById('range-slider-container'),
        rangeMin: document.getElementById('range-slider-min'),
        rangeMax: document.getElementById('range-slider-max'),
        rangeValMin: document.getElementById('range-val-min'),
        rangeValMax: document.getElementById('range-val-max'),
        rangeTrack: document.getElementById('range-slider-track'),
        playheadTracker: document.getElementById('playhead-tracker'),
        playheadLabel: document.getElementById('playhead-label'),
        frameGrid: document.getElementById('frame-grid'),
        frameCountBadge: document.getElementById('frame-count-badge'),
    };

    // ===== File Upload =====
    dom.dropZone.addEventListener('click', () => dom.fileInput.click());

    dom.dropZone.addEventListener('dragover', (e) => {
        e.preventDefault();
        dom.dropZone.classList.add('drag-over');
    });

    dom.dropZone.addEventListener('dragleave', () => {
        dom.dropZone.classList.remove('drag-over');
    });

    dom.dropZone.addEventListener('drop', (e) => {
        e.preventDefault();
        dom.dropZone.classList.remove('drag-over');
        const file = e.dataTransfer.files[0];
        if (file && file.type.startsWith('image/')) {
            loadImage(file);
        }
    });

    dom.fileInput.addEventListener('change', (e) => {
        const file = e.target.files[0];
        if (file) loadImage(file);
    });

    function loadImage(file) {
        const reader = new FileReader();
        reader.onload = (e) => {
            const img = new Image();
            img.onload = () => {
                // Parse filename
                const dotIdx = file.name.lastIndexOf('.');
                state.fileName = dotIdx > 0 ? file.name.substring(0, dotIdx) : file.name;
                state.fileExt = dotIdx > 0 ? file.name.substring(dotIdx) : '.png';
                state.image = img;
                state.downloadCount = 1;

                // Auto-guess grid from filename (e.g., "sprite-25.png" -> 5x5)
                const framesMatch = state.fileName.match(/-(\d+)$/);
                if (framesMatch) {
                    const totalGuessed = parseInt(framesMatch[1], 10);
                    if (totalGuessed > 1 && totalGuessed <= 1000) {
                        const guessCols = Math.ceil(Math.sqrt(totalGuessed));
                        const guessRows = Math.ceil(totalGuessed / guessCols);
                        state.cols = guessCols;
                        state.rows = guessRows;
                        dom.colsInput.value = state.cols;
                        dom.rowsInput.value = state.rows;
                    }
                } else {
                    // Reset to 1x1 if no guess
                    state.cols = 1;
                    state.rows = 1;
                    dom.colsInput.value = 1;
                    dom.rowsInput.value = 1;
                }

                dom.fileInfo.textContent = `${file.name} — ${img.width} × ${img.height}px`;
                dom.fileInfo.classList.remove('hidden');
                dom.controlsPanel.classList.remove('hidden');
                dom.emptyState.classList.add('hidden');
                dom.editorView.classList.remove('hidden');

                updateGrid();
            };
            img.src = e.target.result;
        };
        reader.readAsDataURL(file);
    }

    // ===== Grid Configuration =====
    dom.colsInput.addEventListener('input', () => {
        state.cols = Math.max(1, parseInt(dom.colsInput.value) || 1);
        updateGrid();
    });

    dom.rowsInput.addEventListener('input', () => {
        state.rows = Math.max(1, parseInt(dom.rowsInput.value) || 1);
        updateGrid();
    });

    function updateGrid() {
        if (!state.image) return;

        state.frameWidth = Math.floor(state.image.width / state.cols);
        state.frameHeight = Math.floor(state.image.height / state.rows);
        state.totalFrames = state.cols * state.rows;

        dom.frameDimensions.textContent = `Frame size: ${state.frameWidth} × ${state.frameHeight}px`;

        if (state.cols === 1 && state.rows === 1) {
            dom.gridWarning.classList.remove('hidden');
            dom.rangeSliderContainer.classList.add('hidden');
        } else {
            dom.gridWarning.classList.add('hidden');
            dom.rangeSliderContainer.classList.remove('hidden');
        }

        // Setup Range Slider
        const lastFrame = Math.max(0, state.totalFrames - 1);
        dom.rangeMin.max = lastFrame;
        dom.rangeMax.max = lastFrame;
        dom.rangeMin.value = 0;
        dom.rangeMax.value = lastFrame;
        updateSliderVisuals();

        // Select all frames by default
        state.selectedFrames.clear();
        for (let i = 0; i < state.totalFrames; i++) {
            state.selectedFrames.add(i);
        }

        renderFrameGrid();
        updateSelectionCount();
        updateRangeInputFromSet();
        updatePhaserPreview();
    }

    // ===== Frame Grid Rendering =====
    function renderFrameGrid() {
        dom.frameGrid.innerHTML = '';
        dom.frameCountBadge.textContent = state.totalFrames;

        for (let i = 0; i < state.totalFrames; i++) {
            const cell = document.createElement('div');
            cell.className = 'frame-cell ' + (state.selectedFrames.has(i) ? 'selected' : 'deselected');
            cell.dataset.frame = i;

            // Frame thumbnail canvas
            const canvas = document.createElement('canvas');
            canvas.width = state.frameWidth;
            canvas.height = state.frameHeight;
            const ctx = canvas.getContext('2d');

            const col = i % state.cols;
            const row = Math.floor(i / state.cols);
            ctx.drawImage(
                state.image,
                col * state.frameWidth, row * state.frameHeight,
                state.frameWidth, state.frameHeight,
                0, 0,
                state.frameWidth, state.frameHeight
            );

            // Index label
            const indexLabel = document.createElement('span');
            indexLabel.className = 'frame-index';
            indexLabel.textContent = i;

            // Check indicator
            const check = document.createElement('span');
            check.className = 'frame-check';
            check.textContent = state.selectedFrames.has(i) ? '✓' : '';

            cell.appendChild(canvas);
            cell.appendChild(indexLabel);
            cell.appendChild(check);

            cell.addEventListener('click', () => toggleFrame(i, cell, check));

            dom.frameGrid.appendChild(cell);
        }
    }

    function toggleFrame(index, cell, check) {
        if (state.selectedFrames.has(index)) {
            state.selectedFrames.delete(index);
            cell.classList.remove('selected');
            cell.classList.add('deselected');
            check.textContent = '';
        } else {
            state.selectedFrames.add(index);
            cell.classList.add('selected');
            cell.classList.remove('deselected');
            check.textContent = '✓';
        }
        updateSelectionCount();
        updateRangeInputFromSet();
        updatePhaserPreview();
    }

    function updateSelectionCount() {
        const count = state.selectedFrames.size;
        dom.selectionCount.textContent = `${count} / ${state.totalFrames} frames selected`;
        dom.downloadBtn.disabled = count === 0;
    }

    // ===== Select / Deselect All =====
    dom.selectAll.addEventListener('click', () => {
        state.selectedFrames.clear();
        for (let i = 0; i < state.totalFrames; i++) {
            state.selectedFrames.add(i);
        }
        renderFrameGrid();
        updateSelectionCount();
        updateRangeInputFromSet();
        updatePhaserPreview();
    });

    dom.deselectAll.addEventListener('click', () => {
        state.selectedFrames.clear();
        renderFrameGrid();
        updateSelectionCount();
        updateRangeInputFromSet();
        updatePhaserPreview();
    });

    // ===== Range Input Parsing =====
    let _rangeDebounce = null;
    dom.frameRangeInput.addEventListener('input', () => {
        if (_rangeDebounce) clearTimeout(_rangeDebounce);
        _rangeDebounce = setTimeout(() => {
            parseRangeInput(dom.frameRangeInput.value);
        }, 500); // Wait 500ms after user stops typing to parse
    });

    // ===== Dual Slider Parsing =====
    function updateSliderVisuals() {
        let minVal = parseInt(dom.rangeMin.value, 10);
        let maxVal = parseInt(dom.rangeMax.value, 10);

        if (minVal > maxVal) {
            let tmp = minVal;
            minVal = maxVal;
            maxVal = tmp;
        }

        dom.rangeValMin.textContent = minVal;
        dom.rangeValMin.style.left = `calc(${minVal / dom.rangeMin.max * 100}% - 10px)`;

        dom.rangeValMax.textContent = maxVal;
        dom.rangeValMax.style.right = `calc(${100 - (maxVal / dom.rangeMax.max * 100)}% - 10px)`;

        const percent1 = (minVal / dom.rangeMin.max) * 100;
        const percent2 = (maxVal / dom.rangeMax.max) * 100;
        dom.rangeTrack.style.background = `linear-gradient(to right, var(--bg-tertiary) ${percent1}%, var(--accent) ${percent1}%, var(--accent) ${percent2}%, var(--bg-tertiary) ${percent2}%)`;
    }

    function handleSliderInput(e) {
        let minVal = parseInt(dom.rangeMin.value, 10);
        let maxVal = parseInt(dom.rangeMax.value, 10);

        if (e.target === dom.rangeMin && minVal > maxVal) dom.rangeMin.value = maxVal;
        if (e.target === dom.rangeMax && maxVal < minVal) dom.rangeMax.value = minVal;

        updateSliderVisuals();

        const actualMin = Math.min(parseInt(dom.rangeMin.value, 10), parseInt(dom.rangeMax.value, 10));
        const actualMax = Math.max(parseInt(dom.rangeMin.value, 10), parseInt(dom.rangeMax.value, 10));

        // Pass to parse
        parseRangeInput(`${actualMin}-${actualMax}`);
    }

    dom.rangeMin.addEventListener('input', handleSliderInput);
    dom.rangeMax.addEventListener('input', handleSliderInput);

    function parseRangeInput(inputStr) {
        const newSelection = new Set();
        const parts = inputStr.split(',').map(p => p.trim()).filter(p => p.length > 0);

        for (const part of parts) {
            // Handle ranges e.g., '1-5'
            if (part.includes('-')) {
                const [startStr, endStr] = part.split('-');
                const start = parseInt(startStr, 10);
                const end = parseInt(endStr, 10);

                if (!isNaN(start) && !isNaN(end)) {
                    const min = Math.max(0, Math.min(start, end));
                    const max = Math.min(state.totalFrames - 1, Math.max(start, end));
                    for (let i = min; i <= max; i++) {
                        newSelection.add(i);
                    }
                }
            } else {
                // Handle single numbers
                const num = parseInt(part, 10);
                if (!isNaN(num) && num >= 0 && num < state.totalFrames) {
                    newSelection.add(num);
                }
            }
        }

        state.selectedFrames = newSelection;
        renderFrameGrid();
        updateSelectionCount();

        // Re-format the input to show the parsed version (cleans up any bad text)
        updateRangeInputFromSet();
        updatePhaserPreview();
    }

    function updateRangeInputFromSet() {
        if (state.totalFrames === 0) {
            dom.frameRangeInput.value = '';
            return;
        }

        const sorted = Array.from(state.selectedFrames).sort((a, b) => a - b);
        if (sorted.length === 0) {
            dom.frameRangeInput.value = '';
            return;
        }

        const ranges = [];
        let rangeStart = sorted[0];
        let current = sorted[0];

        for (let i = 1; i < sorted.length; i++) {
            if (sorted[i] === current + 1) {
                // Number is contiguous
                current = sorted[i];
            } else {
                // Break in sequence
                if (rangeStart === current) {
                    ranges.push(`${rangeStart}`);
                } else {
                    ranges.push(`${rangeStart}-${current}`);
                }
                rangeStart = sorted[i];
                current = sorted[i];
            }
        }

        // Add the final range/number
        if (rangeStart === current) {
            ranges.push(`${rangeStart}`);
        } else {
            ranges.push(`${rangeStart}-${current}`);
        }

        dom.frameRangeInput.value = ranges.join(', ');
    }

    // ===== Animation Mode =====
    const modeButtons = [dom.modeLoop, dom.modeNoloop, dom.modeYoyo];
    modeButtons.forEach((btn) => {
        btn.addEventListener('click', () => {
            modeButtons.forEach((b) => b.classList.remove('active'));
            btn.classList.add('active');
            state.animMode = btn.dataset.mode;
            updatePhaserPreview();
        });
    });

    // ===== FPS =====
    dom.fpsSlider.addEventListener('input', () => {
        state.fps = parseInt(dom.fpsSlider.value);
        dom.fpsValue.textContent = `${state.fps} FPS`;
        updatePhaserPreview();
    });

    // ===== Play / Pause / Stop =====
    dom.playBtn.addEventListener('click', () => {
        if (state.phaserScene) {
            state.phaserScene.playAnimation();
        }
    });

    dom.pauseBtn.addEventListener('click', () => {
        if (state.phaserScene) {
            state.phaserScene.pauseAnimation();
        }
    });

    dom.stopBtn.addEventListener('click', () => {
        if (state.phaserScene) {
            state.phaserScene.stopAnimation();
        }
    });

    // ===== Phaser Preview =====
    let _phaserDebounce = null;

    function updatePhaserPreview() {
        if (!state.image) return;

        // Debounce rapid updates to avoid Phaser destroy/create race conditions
        if (_phaserDebounce) clearTimeout(_phaserDebounce);

        _phaserDebounce = setTimeout(() => {
            _phaserDebounce = null;

            const selectedArr = Array.from(state.selectedFrames).sort((a, b) => a - b);
            if (selectedArr.length === 0) {
                destroyPhaser();
                return;
            }

            destroyPhaser();

            // Small delay after destroy to let Phaser clean up
            requestAnimationFrame(() => {
                createPhaser(selectedArr);
            });
        }, 100);
    }

    function destroyPhaser() {
        if (state.phaserGame) {
            state.phaserGame.destroy(true);
            state.phaserGame = null;
            state.phaserScene = null;
            dom.phaserContainer.innerHTML = '';
        }
    }

    function createPhaser(selectedFrames) {
        // Fixed preview canvas size — scale the sprite to fit inside it
        const containerWidth = dom.phaserContainer.clientWidth || 600;
        const maxGameWidth = Math.min(containerWidth, 600);
        const maxGameHeight = 400;

        // Compute how to scale the sprite to fit
        const scaleX = maxGameWidth / state.frameWidth;
        const scaleY = maxGameHeight / state.frameHeight;
        let displayScale = Math.min(scaleX, scaleY);

        // For small pixel art, snap to integer multiples for crisp rendering
        if (state.frameWidth <= 128 && state.frameHeight <= 128) {
            displayScale = Math.max(1, Math.floor(displayScale));
        }

        // Ensure scale is at least large enough to see
        displayScale = Math.max(0.1, displayScale);

        const gameWidth = Math.max(64, Math.ceil(state.frameWidth * displayScale));
        const gameHeight = Math.max(64, Math.ceil(state.frameHeight * displayScale));

        // Use a unique texture key per creation to avoid stale cache
        const textureKey = 'sheet_' + Date.now();

        const sceneConfig = {
            key: 'SpritePreview',
            preload: function () {
                this.textures.addSpriteSheet(textureKey, state.image, {
                    frameWidth: state.frameWidth,
                    frameHeight: state.frameHeight,
                });
            },
            create: function () {
                const scene = this;
                state.phaserScene = scene;

                // Build animation frames from selected frames
                const animFrames = selectedFrames.map((f) => ({
                    key: textureKey,
                    frame: f,
                }));

                // Remove old animation if exists
                if (this.anims.exists('preview')) {
                    this.anims.remove('preview');
                }

                const isYoyo = state.animMode === 'yoyo';
                const isLoop = state.animMode === 'loop' || isYoyo;

                this.anims.create({
                    key: 'preview',
                    frames: animFrames,
                    frameRate: state.fps,
                    repeat: isLoop ? -1 : 0,
                    yoyo: isYoyo,
                });

                const sprite = this.add.sprite(gameWidth / 2, gameHeight / 2, textureKey, selectedFrames[0]);
                sprite.setScale(displayScale);
                scene._sprite = sprite;

                // Auto-play for loop and yoyo modes
                if (state.animMode !== 'noloop') {
                    sprite.play('preview');
                    dom.playheadTracker.classList.remove('hidden');
                } else {
                    dom.playheadTracker.classList.add('hidden');
                }

                scene.playAnimation = function () {
                    if (sprite && sprite.active) {
                        sprite.play('preview');
                        dom.playheadTracker.classList.remove('hidden');
                    }
                };

                scene.pauseAnimation = function () {
                    if (sprite && sprite.active) {
                        sprite.anims.pause();
                    }
                };

                scene.stopAnimation = function () {
                    if (sprite && sprite.active) {
                        sprite.stop();
                        sprite.setFrame(selectedFrames[0]);
                        dom.playheadTracker.classList.add('hidden');
                        updatePlayhead(selectedFrames[0]);
                    }
                };
            },
            update: function () {
                // Update tracker every frame
                if (this._sprite && this._sprite.anims && this._sprite.anims.isPlaying) {
                    const currentFrameObj = this._sprite.anims.currentFrame;
                    if (currentFrameObj) {
                        const rawFrameIndex = parseInt(currentFrameObj.textureFrame, 10);
                        if (!isNaN(rawFrameIndex)) {
                            updatePlayhead(rawFrameIndex);
                        }
                    }
                }
            }
        };

        state.phaserGame = new Phaser.Game({
            type: Phaser.CANVAS,
            width: gameWidth,
            height: gameHeight,
            parent: dom.phaserContainer,
            backgroundColor: 'rgba(0,0,0,0)',
            pixelArt: true,
            scene: sceneConfig,
            audio: { noAudio: true },
            banner: false,
            scale: {
                mode: Phaser.Scale.NONE,
                autoCenter: Phaser.Scale.CENTER_BOTH,
            },
        });
    }

    // ===== Playhead Tracker Update function =====
    function updatePlayhead(frameIndex) {
        if (state.totalFrames <= 1) return;
        const percent = (frameIndex / (state.totalFrames - 1)) * 100;
        dom.playheadTracker.style.left = `${percent}%`;
        if (dom.playheadLabel) {
            dom.playheadLabel.textContent = frameIndex;
        }
    }

    // ===== Export / Download =====
    dom.downloadBtn.addEventListener('click', exportSpriteSheet);

    function computeOptimalGrid(numFrames) {
        // Find the most square-like grid (cols x rows) that fits numFrames with minimum empty cells
        if (numFrames <= 0) return { cols: 1, rows: 1 };
        if (numFrames === 1) return { cols: 1, rows: 1 };

        let bestCols = numFrames;
        let bestRows = 1;
        let bestWaste = 0; // numFrames in a single row has 0 waste

        const sqrtN = Math.ceil(Math.sqrt(numFrames));

        for (let c = 1; c <= numFrames; c++) {
            const r = Math.ceil(numFrames / c);
            const waste = c * r - numFrames;

            // Prefer more square-like layouts (smaller difference between cols and rows)
            const squareness = Math.abs(c - r);
            const bestSquareness = Math.abs(bestCols - bestRows);

            if (waste < bestWaste || (waste === bestWaste && squareness < bestSquareness)) {
                bestCols = c;
                bestRows = r;
                bestWaste = waste;
            }
        }

        return { cols: bestCols, rows: bestRows };
    }

    function exportSpriteSheet() {
        const selectedArr = Array.from(state.selectedFrames).sort((a, b) => a - b);
        if (selectedArr.length === 0) return;

        const numFrames = selectedArr.length;
        const { cols: outCols, rows: outRows } = computeOptimalGrid(numFrames);

        const canvas = document.createElement('canvas');
        canvas.width = outCols * state.frameWidth;
        canvas.height = outRows * state.frameHeight;
        const ctx = canvas.getContext('2d');

        selectedArr.forEach((frameIdx, i) => {
            const srcCol = frameIdx % state.cols;
            const srcRow = Math.floor(frameIdx / state.cols);

            const dstCol = i % outCols;
            const dstRow = Math.floor(i / outCols);

            ctx.drawImage(
                state.image,
                srcCol * state.frameWidth, srcRow * state.frameHeight,
                state.frameWidth, state.frameHeight,
                dstCol * state.frameWidth, dstRow * state.frameHeight,
                state.frameWidth, state.frameHeight
            );
        });

        // Download
        state.downloadCount++;
        const version = `v${state.downloadCount}`;
        const filename = `${state.fileName}_${version}${state.fileExt}`;

        canvas.toBlob((blob) => {
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = filename;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);
        }, 'image/png');
    }
})();
