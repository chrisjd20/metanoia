# METANOIA — Implementation Plan (Godot 4)

> Exhaustive, phase-ordered game development plan derived from the Metanoia Game Design Document.
> Each phase builds on the previous. Do not skip ahead.

---

## Phase 0 — Project Setup & Tooling

### 0.1 Godot Project Initialization
- [ ] Create Godot 4.x project (`project.godot`)
- [ ] Configure project settings:
  - Display: target resolution (portrait-first for mobile, e.g. 1080x1920 with landscape fallback)
  - Rendering: Compatibility renderer (for mobile/WebGL support)
  - Input: configure touch input, virtual joystick support
  - Physics: 2D physics layer naming (Player, Enemies, Projectiles, Environment, Interactables, Triggers)
- [ ] Set up export presets: Android, iOS, WebGL
- [ ] Configure `.gitignore` for Godot (`.godot/`, `*.import`, export builds)

### 0.2 Folder Structure
```
res://
├── addons/                  # Third-party plugins (virtual joystick, etc.)
├── assets/
│   ├── art/
│   │   ├── characters/      # Pilgrim, NPCs, enemies
│   │   ├── environment/     # Tilesets, district art
│   │   ├── effects/         # Particles, VFX
│   │   ├── ui/              # HUD elements, menus, icons
│   │   └── portraits/       # NPC dialogue portraits
│   ├── audio/
│   │   ├── music/           # Exploration, combat, boss, parish tracks
│   │   ├── sfx/             # Sword strikes, chains, bells, UI sounds
│   │   └── ambience/        # District-specific ambient loops
│   └── fonts/               # Gothic/medieval themed fonts
├── scenes/
│   ├── main/                # Main scene, scene manager
│   ├── menus/               # Title screen, pause, settings, game over
│   ├── gameplay/            # Core gameplay scene container
│   ├── player/              # Pilgrim scene + scripts
│   ├── enemies/             # Enemy scenes by type
│   ├── npcs/                # Friendly NPCs, freed humans
│   ├── bosses/              # Archdemon boss scenes
│   ├── world/               # District scenes, tilesets, transitions
│   ├── hud/                 # In-game UI overlay
│   ├── effects/             # Visual effect scenes
│   └── cutscenes/           # Baptism prologue, Restoration, etc.
├── scripts/
│   ├── autoload/            # Singletons (GameManager, SaveManager, AudioManager, etc.)
│   ├── components/          # Reusable node components (Hurtbox, Hitbox, StateMachine, etc.)
│   ├── resources/           # Custom Resource types (EnemyData, AbilityData, etc.)
│   └── systems/             # Core game systems (combat, virtue, fervor, grace, etc.)
├── data/
│   ├── enemies/             # Enemy stat definitions (.tres files)
│   ├── abilities/           # Ability definitions
│   ├── sacramentals/        # Sacramental item definitions
│   ├── scripture_drops/     # Scripture Drop upgrade definitions
│   ├── relics/              # Sacred Relic definitions
│   └── dialogue/            # Dialogue data files
└── shaders/                 # Custom shaders (Veil effect, corruption, holy glow, etc.)
```

### 0.3 Autoload Singletons
- [ ] `GameManager` — game state, scene transitions, pause/unpause
- [ ] `SaveManager` — save/load persistent data (freed souls, virtues, inventory, progress)
- [ ] `AudioManager` — music/SFX bus management, crossfading between tracks
- [ ] `EventBus` — signal-based event system for decoupled communication
- [ ] `InputManager` — abstraction over touch/keyboard/gamepad input

### 0.4 Placeholder Assets
- [ ] Create colored rectangles/simple shapes for all entities (player, enemies, NPCs)
- [ ] Create placeholder tilesets (floor, wall, obstacle, hazard)
- [ ] Source or create placeholder fonts
- [ ] Create silence/beep placeholder SFX

---

## Phase 1 — Title Screen & Main Menu (Landing Page)

> The first thing the player sees. Must be functional before gameplay development begins.

### 1.1 Title Screen Scene
- [x] **Background**: Animated scene — the silhouette of Caelum Falls skyline, dark and foreboding. Faint demonic shapes drift across buildings. A single church steeple glows faintly on the outskirts (the Parish). Slow pan or parallax layers.
- [x] **Title Treatment**: "METANOIA" in Gothic letterform, gold on dark. Subtle glow/shimmer animation. Tagline beneath: *"Put on the whole armor of God."*
- [x] **Ambient Audio**: Low, ominous choral drone transitioning to a faint Gregorian chant melody. Sets tone immediately.
- [x] **Menu Options** (appear after brief title animation):
  - **New Game** — transitions to Character Selection Screen
  - **Continue** — loads last save (greyed out if no save exists)
  - **Settings** — opens settings submenu
  - **Credits** — scrolling credits
  - **Quit** — exit game (hidden on mobile/WebGL)
- [x] Touch/click/key input to dismiss any intro animation and go straight to menu

### 1.2 Settings Menu
- [x] **Audio**: Master volume, Music volume, SFX volume (sliders)
- [x] **Display**: Fullscreen toggle (desktop/WebGL), screen shake intensity
- [x] **Controls**: Virtual joystick size/opacity (mobile), keybind display (desktop)
- [x] **Language**: Placeholder for future localization
- [x] **Back** button returns to title screen
- [x] Settings persist via `SaveManager`

### 1.3 Pause Menu (In-Game)
- [x] **Resume**
- [x] **Settings** (same submenu)
- [x] **Return to Title** (with confirmation prompt — "Progress since last checkpoint will be lost.")
- [x] Triggered by pause button / ESC / back gesture
- [x] Dims/blurs gameplay behind it

### 1.4 Game Over / Death Screen
- [x] Screen desaturates per design doc (Mortal Sin)
- [x] Tempter Demon mocking line displayed
- [x] Fade to black
- [x] "Absolution" prompt — tap/click to respawn at last Priest Checkpoint
- [x] Brief absolution animation on respawn

### 1.5 Character Selection Screen
- [x] Triggered when selecting "New Game".
- [x] Simple UI offering two choices: Male Pilgrim or Female Pilgrim.
- [x] Saves the choice to `GameManager` or `SaveManager` for use in spawning the correct player prefab.
- [x] "Confirm" button to begin the Baptism prologue.
- [x] "Back" button to return to the Title Screen.

### 1.6 Scene Transition System
- [x] Fade-to-black / fade-from-black transitions
- [x] Loading screen for district transitions (simple progress bar + scripture quote)
- [x] `GameManager` handles scene stacking (gameplay + HUD + pause overlay)

---

## Phase 2 — Core Movement & Input

> Get the Pilgrim moving on screen with responsive controls before anything else.

### 2.1 Player Scene Structure
- [ ] `CharacterBody2D` root node
- [ ] `AnimatedSprite2D` or `Sprite2D` with animation player
- [ ] `CollisionShape2D` — body collision
- [ ] `Hurtbox` (Area2D) — receives damage
- [ ] `Hitbox` (Area2D) — deals damage (attached to weapon swing)
- [ ] State machine component (Idle, Move, Attack, Dash, Hurt, Dead, Channel)

### 2.2 Movement System
- [ ] 8-directional movement with analog speed (virtual joystick input)
- [ ] Base movement speed stat (affected by environment hazards like slowing sludge)
- [ ] Smooth acceleration/deceleration
- [ ] Sprite flip/rotation based on movement direction

### 2.3 Dodge / Dash
- [ ] Short invincibility-frame dash on input
- [ ] Cooldown between dashes
- [ ] Dash direction follows movement input (or facing direction if stationary)
- [ ] Visual trail effect during dash

### 2.4 Virtual Joystick (Mobile)
- [ ] Left joystick: movement
- [ ] Right joystick: aim direction for Sword of the Spirit (tap = quick slash, hold+drag = directional thrust)
- [ ] Configurable size and opacity
- [ ] Joysticks appear where thumb touches (floating) or fixed position (setting)

### 2.5 Keyboard/Gamepad Fallback (Desktop/WebGL)
- [ ] WASD / left stick for movement
- [ ] Mouse aim / right stick for sword direction
- [ ] Spacebar / button for dash
- [ ] Ability keys / bumpers for abilities

### 2.6 Camera System
- [ ] `Camera2D` following player with smoothing
- [ ] Look-ahead in movement direction
- [ ] Screen shake system (configurable intensity)
- [ ] Camera limits per room/area

---

## Phase 3 — Core Combat System

> The moment-to-moment gameplay loop. Must feel good with placeholder art.

### 3.1 Sword of the Spirit (Primary Weapon)
- [ ] Basic slash attack (tap right joystick / click)
- [ ] Directional thrust (hold + direction)
- [ ] Attack combo system (sequential swings with timing windows)
- [ ] Hitbox activation tied to animation frames
- [ ] Hit feedback: screen shake, hit pause (brief freeze frame), knockback on enemy
- [ ] Sword visual grows with Scripture Drop upgrades (Phase 10)

### 3.2 Damage System
- [ ] `Hitbox` + `Hurtbox` component pattern
- [ ] Damage types: Faith, Hope, Charity (maps to Theological Virtues)
- [ ] Damage calculation: base damage * virtue scaling * enemy resistance
- [ ] Knockback vector on hit
- [ ] Invincibility frames after taking damage
- [ ] Damage numbers popup (optional, can be toggled)

### 3.3 Enemy Base Class
- [ ] `CharacterBody2D` with AI state machine (Idle, Patrol, Chase, Attack, Hurt, Dead/Freed)
- [ ] Aggro detection radius (`Area2D`)
- [ ] Navigation: simple pathfinding toward player or patrol points
- [ ] Health bar display (above enemy)
- [ ] Drop table on defeat (Spiritual Graces, rare drops)

### 3.4 Enemy Types — Framework
- [ ] **Pure Demon (Lesser)**: Standard dark aura HP bar. Swarm behavior. Drops Spiritual Graces.
- [ ] **Pure Demon (Greater)**: More HP, more complex attack patterns. Mini-boss tier.
- [ ] **Captive Human**: No attack. Attached demon/chain has HP. Freed on demon defeat. Flees to safety.
- [ ] **Embracer (Possessed Human)**: Deception Meter instead of HP. Aggressive. Freed when Deception emptied.

### 3.5 Enemy Attack Patterns
- [ ] Melee lunge
- [ ] Fiery Dart projectile (Ephesians 6:16)
- [ ] AoE zone (telegraph + damage zone)
- [ ] Horde spawning logic (wave-based density control)

### 3.6 Combat Feel & Juice
- [ ] Hit stop (brief freeze on contact)
- [ ] Screen shake on heavy hits
- [ ] Particle effects: slash trails, impact sparks, enemy dissolve
- [ ] Sound: bell-like sword ring, chain shatter on freed souls, demon dissolve hiss
- [ ] XP/Grace cascade visual when picking up drops

---

## Phase 4 — State of Grace (Health) & Fervor (Combat Resource)

### 4.1 State of Grace System
- [ ] Grace bar — golden chalice HUD element (top-left)
- [ ] Max Grace scales with Fortitude
- [ ] Grace depletion triggers Mortal Sin (death sequence)
- [ ] Grace restoration sources:
  - Eucharist Nodes (world objects — inert until Act I completion)
  - Eucharist Drops (rare drops from freed humans)
  - Prayer Chain passive regen (scales with freed souls)
- [ ] Visual: chalice glows when full, dims and cracks as depleted
- [ ] Audio: heartbeat intensifies at low Grace

### 4.2 Fervor System
- [ ] Fervor bar — golden censer HUD element (beside Grace)
- [ ] Fervor generation:
  - Sword strikes (small per hit, combo multiplier for consecutive hits without damage)
  - Freeing Captive Humans (large burst)
  - Shattering Embracer Deception (large burst)
  - Defeating Pure Demons (moderate)
  - Intensity scaling (more enemies = faster generation)
- [ ] Fervor decay: passive decay out of combat, small drain on damage taken, reset on death
- [ ] Fervor spending: certain abilities consume Fervor
- [ ] Fervor Overflow:
  - When at max and still generating, enter Overflow state
  - Visual: censer erupts, screen pulses gold
  - Angelic Invocation becomes available
  - Drops back to max if combat stops or heavy damage taken
- [ ] Gospel Font interaction: instantly fills Fervor to max (not Overflow)

### 4.3 HUD Layout
- [ ] Grace chalice (top-left)
- [ ] Fervor censer (beside Grace)
- [ ] Ability buttons (bottom-right, 2 slots)
- [ ] Minimap (unlocked with Helmet of Salvation — placeholder frame)
- [ ] Soul counter / Spiritual Graces collected
- [ ] Pause button (top-right)
- [ ] Guardian Angel hint text area
- [ ] Tempter Demon whisper text area

---

## Phase 5 — Ability System

### 5.1 Ability Framework
- [ ] `AbilityData` custom Resource: name, icon, description, cooldown, fervor_cost, effect_scene, scaling_virtues
- [ ] Ability slot system (2 equippable slots)
- [ ] Cooldown timer per ability (reduced by Temperance)
- [ ] Fervor cost check before activation
- [ ] Ability button UI with cooldown overlay and Fervor cost indicator
- [ ] Ability equip/swap in Parish menu

### 5.2 Core Abilities
- [ ] **Praise & Worship** (Starting) — AoE radiant shockwave, pushback, moderate damage, speed boost to freed humans in range. Cooldown only.
- [ ] **Proclamation** (Starting alternate) — Cone of piercing light, high damage, staggers, shreds Embracer Deception. Cooldown only.
- [ ] **Shield of Faith** (Post-Sloth) — Directional barrier absorbing projectiles for 3-4 seconds, counter-blast on drop. Cooldown only.
- [ ] **The Holy Rosary** (50 freed souls) — Fervor-cost. Orbiting rosary beads for 20 seconds. Every 10 hits triggers random Mystery effect (heal / AoE stun / damage surge / invincibility).
- [ ] **Repentance** (First Confession) — Fervor-cost. Channel: consume Fervor to restore Grace and cleanse debuffs.

### 5.3 Ultimate — Angelic Invocation (St. Michael)
- [ ] Triggered during Fervor Overflow
- [ ] Full-screen attack: St. Michael descends, flaming sword sweep
- [ ] Pure Demons obliterated, Embracer Deception shattered, Captive Humans freed
- [ ] Consumes all Fervor
- [ ] Cinematic camera zoom / slow-mo
- [ ] Unlocked after Act I

### 5.4 Auto-Cast Auras (Passive Abilities)
- [ ] Framework for passive abilities that trigger when enemies enter range
- [ ] Examples: waves of holy light, consecration zones
- [ ] Tied to Virtue scaling and Sacramental bonuses

---

## Phase 6 — Virtue System (Character Progression)

### 6.1 Virtue Data Model
- [ ] Four Cardinal Virtues: Prudence, Justice, Fortitude, Temperance
- [ ] Three Theological Virtues: Faith, Hope, Charity
- [ ] Each virtue has a level (integer) increased by spending Spiritual Graces
- [ ] Virtue effects calculated dynamically and applied to relevant systems

### 6.2 Cardinal Virtue Effects
- [ ] **Prudence**: crit chance, secret reveal radius, boss attack foresight indicator at high levels
- [ ] **Justice**: Spiritual Grace drop multiplier, Prayer Chain effectiveness, NPC quest unlock thresholds
- [ ] **Fortitude**: max Grace (HP), knockback resistance, poise during channeling, damage resistance below 25% Grace at high levels
- [ ] **Temperance**: cooldown reduction on abilities, debuff resistance, additional Sacramental Slots at thresholds

### 6.3 Theological Virtue Effects
- [ ] **Faith**: light/truth attack damage, Shield of Faith power, resists deception/illusion/fear. Strong vs Pride, Lust.
- [ ] **Hope**: piercing attack damage, Eucharist healing multiplier, resists despair/paralysis/drain. Strong vs Sloth, Envy.
- [ ] **Charity**: AoE radius, human freeing rate, Fervor gen from freeing. Resists wrath/hatred/isolation. Strong vs Wrath, Gluttony, Greed.

### 6.4 Vocation Presets (Character Creation)
- [ ] Selection screen after Baptism prologue
- [ ] 5 presets with starting Virtue distributions:
  - School of Aquinas (Prudence + Faith)
  - School of Siena (Justice + Charity)
  - School of Augustine (Fortitude + Hope)
  - School of Avila (Temperance + Faith)
  - School of Newman (Balanced)
- [ ] Patron Saint icon + flavor text + playstyle description
- [ ] Preview of starting stats before confirmation

### 6.5 Virtue Leveling UI
- [ ] Accessible from Parish hub
- [ ] Spend Spiritual Graces to level individual Virtues
- [ ] Display current effects and next-level preview
- [ ] Respec via Spiritual Director NPC (for a cost)

---

## Phase 7 — Inventory & Equipment Systems

### 7.1 Sacramental System (Passive Items)
- [ ] `SacramentalData` custom Resource: name, icon, description, effect, tier, found_location
- [ ] Sacramental Slot system (2 starting, up to 4-5 via Temperance/progression)
- [ ] Equip/unequip in Parish menu
- [ ] Effects applied as modifiers to player stats/behaviors
- [ ] Implement all 8 Sacramentals from design doc:
  - St. Benedict Medal, Brown Scapular, Holy Water Vial, Blessed Salt, Blessed Candle, Miraculous Medal, Crucifix of San Damiano, St. Michael Chaplet

### 7.2 Sacred Relics (Permanent Collectibles)
- [ ] 7 relics, one per district
- [ ] Discovery triggers: cinematic, Grace burst, permanent blessing unlock
- [ ] Reliquary display in Parish (visual progression)
- [ ] All 7 collected = Reliquary of the Faith bonus (permanent Grace regen aura)
- [ ] Implement all 7 permanent blessings from design doc

### 7.3 Scripture Drops (Sword Upgrades)
- [ ] Collectible items found throughout the world
- [ ] Each drop permanently upgrades Sword of the Spirit:
  - Early: brighter blade, longer reach, base damage increase
  - Mid: fire trails, wider arc, richer sound, Fervor gen increase
  - Late: ranged slashes, demonic shield piercing, Theological Virtue scaling
- [ ] Final form: Awakened (post-Greed Archdemon)

### 7.4 Gospel Fonts (Temporary Power-Ups)
- [ ] World-placed interactive objects (stone basins / open-Bible lecterns)
- [ ] Single-use per run, recharge between runs
- [ ] Activation fills Fervor to max
- [ ] 4 Font types with distinct 15-20 second buffs:
  - Font of Psalms (damage boost + attack speed double)
  - Font of Wisdom (cooldown reset + 5x cooldown speed + free Fervor abilities)
  - Font of Exodus (invincibility + speed boost + contact damage)
  - Font of Revelation (radiant aura, continuous screen damage, rapid Deception drain)
- [ ] Distinct visual + choral audio for identification

### 7.5 Spiritual Graces (Currency/XP)
- [ ] Dropped by defeated enemies and freed humans
- [ ] Magnetic pickup toward player
- [ ] Cascade visual effect on collection
- [ ] Lost on death (since last checkpoint), freed souls persist
- [ ] Spent at Parish to level Virtues and buy items

---

## Phase 8 — World Building & Level Design

### 8.1 Tilemap & Environment System
- [ ] `TileMap` layers: ground, walls, decorations, hazards, overlay
- [ ] Collision layer setup matching physics layers from Phase 0
- [ ] Environmental hazard tiles: slowing sludge, toxic zones, fire, chasm edges
- [ ] Destructible environment objects where appropriate
- [ ] Light/shadow system: `PointLight2D` / `DirectionalLight2D` for atmosphere

### 8.2 Room/Area Structure
- [ ] Each district divided into interconnected rooms/screens
- [ ] Room transition triggers (Area2D at exits)
- [ ] Camera limits per room
- [ ] Enemy spawn points per room (wave definitions)
- [ ] Loot placement (Scripture Drops, Sacramentals, Spiritual Graces)
- [ ] Secret room detection (illusory walls revealed by Belt of Truth)

### 8.3 District Implementation Order
Build districts in story order:

1. **The Parish Hub** (Phase 9 — dedicated section)
2. **The Outskirts / Marshes (Sloth)** — starting area, tutorial integration
3. **The Market (Gluttony)** — fog-gated, unlocked by Belt of Truth
4. **The Neon Quarter (Lust)** — toxic-zone gated, unlocked by Breastplate
5. **The Residences (Envy)** — chasm-gated, unlocked by Shoes of the Gospel
6. **The Foundry (Wrath)** — mirror-gate gated, unlocked by Shield of Faith
7. **The Financial Cathedral (Greed)** — madness-corridor gated, unlocked by Helmet
8. **The Citadel (Pride)** — sealed gate, unlocked by Awakened Sword

### 8.4 Transition Zones
- [ ] Areas between districts with optional exploration
- [ ] Sacred Relic hiding spots
- [ ] Sacramental caches
- [ ] Captive Humans to free
- [ ] Multiple entry/exit points
- [ ] Gated teasers for future areas (visible but inaccessible)

### 8.5 Priest Checkpoints
- [ ] Placed strategically within districts
- [ ] Activation: absolution animation, full Grace restore
- [ ] Save point (persist progress)
- [ ] Confession mechanic: brief dialogue, weakens Tempter effectiveness over time
- [ ] Visual: a hidden priest with candles and a makeshift confessional

### 8.6 Eucharist Nodes
- [ ] Altars, shrines, tabernacles with monstrance placed throughout world
- [ ] Inert during Act I (visual but non-functional)
- [ ] Activate after Eucharist received (Act I completion)
- [ ] Full Grace restore on interaction
- [ ] Distinct golden glow + choral hum for identification

---

## Phase 9 — The Parish Hub

### 9.1 Parish Scene
- [ ] Safe zone (no enemies)
- [ ] Three visual stages reflecting progression:
  - Stage 1: Ruined — Father Elias alone, makeshift altar
  - Stage 2: Restored — roof patched, pews, first NPCs, bell tower, Reliquary alcove
  - Stage 3: Cathedral — full stained glass, choir, community gathered
- [ ] Player can walk freely, interact with NPCs, access menus

### 9.2 Parish NPCs
- [ ] **Father Elias** — story dialogue, Sacrament giver, lore
- [ ] **Vendor** — buy consumables (Holy Water Vials, Scapulars, buffs) with Spiritual Graces
- [ ] **Sacristan** — bless/upgrade Sacramentals to higher tiers
- [ ] **Spiritual Director** — redistribute (respec) Virtue points for a cost
- [ ] **Quest Givers** — freed NPCs with personal quests ("My sister is in the Wrath District")
- [ ] **Freed Souls** — populate the Parish as the game progresses, ambient life

### 9.3 Parish Menus (Accessed from Hub)
- [ ] Virtue leveling screen
- [ ] Ability equip screen (swap 2 ability slots)
- [ ] Sacramental equip screen (manage passive item slots)
- [ ] Inventory / collection screen (Scripture Drops, Relics found, lore entries)
- [ ] District selection / world map overview

### 9.4 Reliquary
- [ ] Visual display area in Parish
- [ ] Empty frames/pedestals that fill as Sacred Relics are found
- [ ] NPCs gather and pray before collected relics
- [ ] Completion bonus indicator

### 9.5 Prayer Chain Visualization
- [ ] Visual counter or tapestry showing freed souls
- [ ] Current Prayer Chain buff level displayed
- [ ] Glowing threads connecting to distant soul icons

---

## Phase 10 — Armor of God (Metroidvania Progression)

### 10.1 Armor Piece Framework
- [ ] Permanent upgrades — cannot be unequipped
- [ ] Each piece grants a traversal ability + gates specific areas
- [ ] Visual change on Pilgrim sprite when acquired
- [ ] Acquisition cinematic per piece

### 10.2 Armor Pieces (Unlocked via Boss Defeats)
- [ ] **Sword of the Spirit** (Baptism) — basic combat, grows via Scripture Drops
- [ ] **Belt of Truth** (Post-Sloth) — Spiritual Sight Pulse: reveals hidden objects/passages/enemies for 10s. Opens "fog of lies" barriers.
- [ ] **Breastplate of Righteousness** (Post-Gluttony) — Righteous Aura: passive damage reduction, immunity to corruption zones. Opens toxic zones.
- [ ] **Shoes of the Gospel of Peace** (Post-Lust) — Holy Dash: long-range invincible dash crossing gaps/chasms, leaves consecrated ground. Opens spiritual chasms.
- [ ] **Shield of Faith** (Post-Envy) — Perfect Parry: timed block reflects projectiles, stuns bosses briefly, -15% Fiery Dart damage. Opens mirror gates.
- [ ] **Helmet of Salvation** (Post-Wrath) — Unshakeable Mind: immunity to fear/confusion/rage/mind-control, persistent minimap. Opens madness corridors.
- [ ] **Sword of the Spirit Awakened** (Post-Greed) — True Edge: cuts any demonic barrier/shield/lock, permanent ranged slashes. Opens sealed vaults and Citadel gate.

### 10.3 Gate Implementation
- [ ] Each gate type has a distinct visual (fog, toxic pool, chasm, mirror, madness, sealed door)
- [ ] Gates check for corresponding Armor piece in player inventory
- [ ] Interaction prompt when player has the right piece
- [ ] Unlocking animation per gate type
- [ ] Gates remain open permanently once unlocked

---

## Phase 11 — Companion Systems

### 11.1 Guardian Angel
- [ ] Semi-transparent luminous sprite hovering near Pilgrim's shoulder
- [ ] **Passive Light**: illuminates dark areas, radius scales with Faith
- [ ] **Dart Block**: automatically intercepts a set number of Fiery Darts, recharges over time (sped up by Eucharist). Scales with Fortitude.
- [ ] **Hints**: brief text prompts near secrets, boss weakness phases, idle moments
- [ ] **Dialogue**: encouraging lines at key moments (low Grace, freed soul, boss phase)
- [ ] **Boss Utility**: unique interactions in Pride fight (illuminating blind spots) and Lust fight (revealing real Illusionist)

### 11.2 Tempter Demon
- [ ] Small shadowy imp at screen edge, always peripheral
- [ ] **Ambient Temptation**: periodic mocking/manipulative text bubbles (narrative only)
- [ ] **Death Response**: surges forward with triumphant line on player death
- [ ] **Escalation**: early = petty insults, mid = appeals to pride, late = theological half-truths
- [ ] **Silent Treatment**: goes silent during sacred moments (Sacraments, Restoration)
- [ ] Dialogue pool per game stage, weighted random selection

### 11.3 Dialogue System
- [ ] Text popup system for both companions
- [ ] Queue system (don't overlap)
- [ ] Contextual trigger conditions (proximity, health thresholds, events)
- [ ] Typewriter text effect with skip option
- [ ] Distinct visual style per companion (golden for Angel, dark smoky for Tempter)

---

## Phase 12 — Prologue & Tutorial (Baptism Sequence)

### 12.1 The Mundane Layer (Prologue Only)
- [ ] Desaturated, grayscale palette with muted earth tones
- [ ] Player movement feels sluggish (reduced speed, slight input delay)
- [ ] No visible enemies, NPCs look tired and blank
- [ ] Short linear path through grey city to Father Elias in ruined church
- [ ] Environmental storytelling: something feels wrong but nothing visible

### 12.2 Baptism Event
- [ ] Cutscene: Father Elias performs Baptism
- [ ] The Veil lifts — dramatic visual transition:
  - Screen floods with color
  - Gothic palette explodes (crimsons, golds, midnight blues)
  - Demonic webs, chains, and demons become visible
  - UI transforms to ornate style (chalice, censer, illuminated icons)
- [ ] Player receives Sword of the Spirit
- [ ] Grace bar and Fervor bar appear
- [ ] Controls become responsive (speed increase, dash unlocked)

### 12.3 Tutorial Combat
- [ ] First encounters with Lesser Pure Demons (simple, low HP)
- [ ] Guided prompts teaching:
  - Movement and aiming
  - Basic slash attack
  - Dodge/dash
  - Ability use (Praise & Worship or Proclamation — player chooses one)
  - Freeing a Captive Human
  - Fighting an Embracer (Deception Meter)
  - Collecting Spiritual Graces
  - Grace loss and recovery
  - Fervor buildup
- [ ] Natural flow — combat encounters teach mechanics without explicit text walls

### 12.4 Vocation Selection
- [ ] After tutorial combat, return to Parish
- [ ] Father Elias dialogue introducing the Vocations
- [ ] Selection screen (Phase 6.4)
- [ ] Starting Virtue distribution applied
- [ ] Game proper begins — Outskirts district accessible

---

## Phase 13 — District 1: The Outskirts (Sloth)

### 13.1 Environment
- [ ] Stagnant water, grey fog, abandoned suburbs, overgrown parks
- [ ] Slowing sludge hazard tiles
- [ ] Draining fog zones (Grace decay while standing in fog)
- [ ] Muted color palette, progressively brighter as areas are cleansed

### 13.2 Enemy Roster (Sloth-Themed)
- [ ] Fog wraiths (Lesser Pure Demons — slow, ghostly, emerge from fog)
- [ ] Drowning hands (environmental — grab and slow player)
- [ ] Apathy shades (Embracers — sluggish but hit hard, Deception: "nothing matters")
- [ ] Captive Humans: trapped in spiritual sludge

### 13.3 Boss: Acedia — "The Devouring Fog"
- [ ] Arena: flooded plaza with submerged church steeple
- [ ] Phase 1 (The Stupor): fog closes in, find and light prayer-candle beacons, strike exposed core
- [ ] Phase 2 (The Despair): fog aggressive, phantom hands grab player, use Praise & Worship to break free
- [ ] Phase 3 (The Lie of Comfort): fog retreats, arena calm, "Rest" trap — stopping triggers massive damage
- [ ] Boss health bar UI
- [ ] Drop: Belt of Truth

### 13.4 Post-Boss
- [ ] Confirmation Sacrament cutscene
- [ ] Belt of Truth acquisition cinematic
- [ ] Ability system unlocks (Gifts of the Spirit)
- [ ] Fervor Overflow becomes possible
- [ ] Fog-gated barriers now openable (path to Market District)

---

## Phase 14 — District 2: The Market (Gluttony)

### 14.1 Environment
- [ ] Neon-lit markets, grotesque food courts, excess everywhere
- [ ] Corrosive bile pool hazards
- [ ] Swarming parasite spawners

### 14.2 Enemy Roster (Gluttony-Themed)
- [ ] Parasites (Lesser Pure Demons — small, fast, swarm in large numbers)
- [ ] Bloated devourers (Greater Pure Demons — large, slow, high HP, vomit attacks)
- [ ] Glutton Embracers (distended, grasping, Deception: "more, never enough")
- [ ] Captive Humans: being slowly consumed by parasites

### 14.3 Boss: The Consumer
- [ ] Arena: circular mouth-arena (fleshy floor, teeth pillars, throat-pit center)
- [ ] Phase 1 (The Feast): inhale vortex, dodge behind pillars, strike exposed belly
- [ ] Phase 2 (The Binge): parasite swarms + Consumer tries to devour captive NPCs to regen
- [ ] Phase 3 (The Emptiness): frenzied but withering, reveals hollow interior, collapses inward
- [ ] Drop: Breastplate of Righteousness

### 14.4 Post-Boss — Act I Completion
- [ ] Father Elias celebrates First Mass cutscene
- [ ] Eucharist received — Sacraments of Initiation complete
- [ ] Eucharist Nodes activate throughout the world
- [ ] Eucharist Drops frequency increases
- [ ] Chalice HUD gains radiant glow
- [ ] Angelic Invocation (St. Michael) unlocks
- [ ] Parish upgrades to Stage 2

---

## Phase 15 — Districts 3-6 (Act II)

### 15.1 The Neon Quarter (Lust) — "The Illusionist"
- [ ] Mirror maze environment, kaleidoscopic lights, illusion traps
- [ ] Boss: 3-phase fight (Dazzle / Seduction / Unmasking)
- [ ] Drops: Shoes of the Gospel of Peace

### 15.2 The Residences (Envy) — "The Leech"
- [ ] Darkened neighborhoods, spying eyes, shadow tendrils, stat-drain zones
- [ ] Boss: 3-phase fight (Copy / Drain / Offering)
- [ ] Drops: Shield of Faith

### 15.3 The Foundry (Wrath) — "The Berserker"
- [ ] Burning factories, molten rivers, fire hazards, persistent Grace drain
- [ ] Boss: 3-phase fight (Rage / Provocation / Quenching)
- [ ] Drops: Helmet of Salvation

### 15.4 The Financial Cathedral (Greed) — "The Hoarder"
- [ ] Gleaming towers, gilded streets, golden chain movement restriction
- [ ] Boss: 3-phase fight (Bargain / Chains / Sacrifice)
- [ ] Drops: Sword of the Spirit (Awakened)

### 15.5 Act II Narrative Beats
- [ ] Prayer Chain becomes essential for survival
- [ ] Tempter Demon dialogue becomes more personal and insidious
- [ ] Fallen Faithful encounters (former parish members serving Archdemons)
- [ ] Central Cathedral liberation from Greed completes Armor of God
- [ ] Father Elias reveals Pride's true nature

---

## Phase 16 — The Citadel (Act III — Pride)

### 16.1 Environment
- [ ] Clean, sterile, modern perfection — no visible corruption in Mundane sense
- [ ] Spiritual Layer: tower of Babel wrapped in mirrors
- [ ] Psychic attack hazards, mirror-reflection damage
- [ ] Inhabitants are polite, smiling, and utterly blind

### 16.2 Boss: The Mirror Knight (Pride)
- [ ] Arena: pristine white room, floor-to-ceiling mirrors, single throne
- [ ] Appearance: flawless idealized version of the Pilgrim
- [ ] Phase 1 (The Reflection): mirrors every attack, use Guardian Angel to find blind spots
- [ ] Phase 2 (The Exaltation): Pilgrim's abilities amplified, taunts with praise, Charity weakens shield
- [ ] Phase 3 (The Shattering): Prayer Chain activates, freed souls pray, mirrors crack, Knight distorts, communal final blow
- [ ] Cannot be defeated without sufficient Prayer Chain level

### 16.3 The Restoration
- [ ] Victory triggers Restoration cutscene
- [ ] Veil dissolves over Caelum Falls
- [ ] Mundane and Spiritual layers merge into healed reality
- [ ] Parish becomes Cathedral (Stage 3)
- [ ] Tempter Demon goes permanently silent
- [ ] Credits roll with parish community celebration
- [ ] Return to title screen with "Continue" leading to post-game Parish

---

## Phase 17 — Save System & Persistence

### 17.1 Save Data Structure
- [ ] Player state: Virtue levels, equipped abilities, equipped Sacramentals, Spiritual Graces
- [ ] Progression: Armor pieces acquired, Archdemons defeated, Act/stage
- [ ] World state: freed souls (list), Priest Checkpoints activated, Sacred Relics found, Scripture Drops collected, Gospel Fonts used this run
- [ ] Parish state: stage, NPCs present, quests active/completed
- [ ] Settings: audio, display, controls

### 17.2 Save/Load Triggers
- [ ] Auto-save at Priest Checkpoints
- [ ] Auto-save on Parish entry
- [ ] Auto-save on boss defeat
- [ ] Auto-save on Sacrament received
- [ ] Manual save from Parish menu
- [ ] Single save slot (mobile simplicity) or 3 slots (desktop)

### 17.3 Death & Respawn
- [ ] On Grace depletion: Mortal Sin sequence (Phase 1.4)
- [ ] Respawn at last Priest Checkpoint
- [ ] Spiritual Graces since checkpoint lost
- [ ] Freed souls persist (not lost on death)
- [ ] Fervor resets to zero
- [ ] Brown Scapular: one free resurrection per district run (if equipped)

---

## Phase 18 — Audio Implementation

### 18.1 Music System
- [ ] `AudioManager` singleton with crossfade between tracks
- [ ] Track layers: base + combat intensity + Fervor overlay
- [ ] Per-district exploration tracks (contemplative, Gregorian chant + ambient synths)
- [ ] Combat tracks (driving percussion + choral swells)
- [ ] Boss tracks (unique per Archdemon, build across phases)
- [ ] Parish track (warm acoustic, soft choir, bells — complexity grows with NPCs)
- [ ] Title screen track (ominous choral drone to Gregorian chant)

### 18.2 Sound Effects
- [ ] Sword strikes: bell-like ring (richer with Scripture Drops)
- [ ] Chain shatter + clear bell: freeing a soul (most satisfying sound in the game)
- [ ] Demon dissolve: hissing shadow dissipation
- [ ] Fiery Dart: whoosh + sizzle
- [ ] Dash: wind rush
- [ ] Grace loss: dull impact + crack
- [ ] Eucharist: warm choir swell
- [ ] Death: silence except Tempter laugh
- [ ] Absolution: water, whispered prayer, dissonance resolving to harmony
- [ ] Angelic Invocation: thunderclap of angelic trumpets + rush of wings
- [ ] UI: menu select, equip, level up chimes

### 18.3 Fervor Audio Layer
- [ ] Subtle percussive heartbeat intensifies as Fervor builds
- [ ] At max Fervor: sustained choir tones enter combat mix
- [ ] During Overflow: dramatic audio swell signaling imminent power

### 18.4 Ambient Audio
- [ ] Per-district ambient loops (dripping water, distant screams, factory clangs, etc.)
- [ ] Sanctified areas: faint choral ambience, stained-glass refractions
- [ ] Gospel Font hum (choral identification tone)
- [ ] Guardian Angel soft chime on hint
- [ ] Tempter Demon whisper hiss on temptation text

---

## Phase 19 — Visual Effects & Shaders

### 19.1 The Veil Effect
- [ ] Shader for Mundane Layer (desaturation, muted tones, slight blur over the modern city)
- [ ] Shader for Spiritual Layer (applies vibrant Gothic palette and heavy ink lines over modern structures without changing their fundamental modern shape)
- [ ] Transition shader (Baptism): dramatic color flood effect
- [ ] Sanctified area shader: warm candlelight tones, golden overlay

### 19.2 Corruption & Cleansing
- [ ] Per-district corruption overlay (sickly greens, dark tendrils)
- [ ] Cleansing effect: corruption recedes as areas are cleared, palette shifts warmer
- [ ] Demonic web/chain environmental decorations (animated, pulse with darkness)

### 19.3 Combat VFX
- [ ] Sword slash trail (light blade arc, color scales with upgrades)
- [ ] Hit impact particles (holy sparks)
- [ ] Enemy death/freeing particles (shadow dissolve for demons, chain shatter + light burst for freed humans)
- [ ] Ability VFX (radiant shockwave, light cone, golden shield, orbiting rosary beads)
- [ ] Angelic Invocation: full-screen golden flash, St. Michael sprite animation, flaming sword sweep
- [ ] Fervor visual: censer glow intensity, golden fire at Overflow
- [ ] Grace visual: chalice glow/crack states

### 19.4 Environmental Lighting
- [ ] `CanvasModulate` for district mood lighting
- [ ] `PointLight2D` for player (Guardian Angel glow), Eucharist Nodes, Gospel Fonts, candles
- [ ] Shadow casting from walls and environment objects
- [ ] District-specific light color temperatures

---

## Phase 20 — Art Asset Production

> Replace all placeholders with final art. This phase runs in parallel with later development phases once style is locked.

### 20.1 Character Art (Modern Setting, Gothic Style)
- [ ] Pilgrim Male (8-direction sprites or animation tree): idle, walk, dash, attack combo, hurt, death, channel, abilities
- [ ] Pilgrim Female (8-direction sprites or animation tree): idle, walk, dash, attack combo, hurt, death, channel, abilities
- [ ] Guardian Angel: hover idle, dart block, hint gesture, boss interactions
- [ ] Tempter Demon: lurk idle, surge forward (death), whisper gesture
- [ ] Father Elias: idle, dialogue poses (modern priest attire with Gothic stylization)
- [ ] Parish NPCs: vendor, sacristan, spiritual director, quest givers (idle + dialogue, modern clothing)
- [ ] Freed souls: generic civilian variants (modern citizens: suits, hoodies, workwear, etc., walk to safety, Parish ambient)

### 20.2 Enemy Art
- [ ] Per-district Lesser Pure Demon variants (7 districts)
- [ ] Per-district Greater Pure Demon variants
- [ ] Per-district Embracer variants (visually reflecting their deadly sin)
- [ ] Captive Human variants (chained, parasited, sludge-trapped)
- [ ] 7 Archdemon boss sprites with multi-phase visual changes

### 20.3 Environment Art (Modern Setting, Gothic Style)
- [ ] Tileset per district (7 + Parish + transition zones). Must clearly depict modern locations (suburbs, malls, skyscrapers, factories) using the stained-glass/heavy-ink style.
- [ ] Environmental decorations per district (modern cars, lampposts, neon signs, chain-link fences, overlaid with spiritual corruption)
- [ ] Gate visuals (fog, toxic, chasm, mirror, madness, sealed)
- [ ] Interactive objects: Priest Checkpoint, Eucharist Node, Gospel Font, Scripture Drop pickup, Sacred Relic shrine
- [ ] Parish 3-stage visual assets

### 20.4 UI Art
- [ ] Gothic-themed UI frame/panel art
- [ ] Grace chalice (full to cracked states)
- [ ] Fervor censer (dim to blazing states)
- [ ] Ability icons (illuminated manuscript style)
- [ ] Sacramental item icons
- [ ] Sacred Relic icons
- [ ] Armor of God piece icons
- [ ] Virtue icons
- [ ] Title screen logo treatment
- [ ] Menu buttons and selection indicators
- [ ] Minimap frame and icons

---

## Phase 21 — Polish, Balancing & QA

### 21.1 Game Balance
- [ ] Enemy HP/damage curves per district
- [ ] Virtue scaling balance (no dominant build)
- [ ] Spiritual Grace economy (earn rate vs spend rate)
- [ ] Ability cooldown/power balance
- [ ] Sacramental power balance
- [ ] Boss difficulty progression
- [ ] Prayer Chain scaling
- [ ] Session length verification (3-10 minute target runs)

### 21.2 Performance Optimization
- [ ] Mobile frame rate targets (60fps on mid-range devices)
- [ ] WebGL performance testing
- [ ] Object pooling for enemies, projectiles, particles
- [ ] Texture atlas packing
- [ ] Audio streaming for music, preload for SFX
- [ ] Memory profiling on target devices

### 21.3 Accessibility
- [ ] Colorblind-friendly indicators (not relying solely on color)
- [ ] Screen shake toggle/intensity slider
- [ ] Text size options for companion dialogue
- [ ] Auto-aim assist option for mobile

### 21.4 QA & Bug Testing
- [ ] Full playthrough testing (all 3 acts)
- [ ] Boss fight edge cases
- [ ] Save/load integrity testing
- [ ] Death/respawn state consistency
- [ ] Metroidvania gate progression (ensure no sequence breaking unless intentional)
- [ ] Mobile touch input reliability
- [ ] WebGL browser compatibility (Chrome, Firefox, Safari, Edge)

---

## Phase 22 — Export & Deployment

### 22.1 Mobile (Android)
- [ ] Export preset configuration
- [ ] APK/AAB signing
- [ ] Google Play Store listing (screenshots, description, rating)
- [ ] Touch control final tuning on physical devices

### 22.2 Mobile (iOS)
- [ ] Export preset configuration
- [ ] Xcode project generation
- [ ] App Store listing
- [ ] TestFlight beta distribution

### 22.3 WebGL
- [ ] Export preset configuration
- [ ] Hosting setup (itch.io, custom domain, etc.)
- [ ] Loading screen optimization
- [ ] Browser compatibility verification

### 22.4 Marketing Assets
- [ ] App icon (Sword of the Spirit / Pilgrim silhouette)
- [ ] Store screenshots (5+ per platform)
- [ ] Trailer / gameplay recording
- [ ] Press kit

---

## Appendix A — Phase Dependencies

```
Phase 0 (Setup)
  ├─> Phase 1 (Title/Menus)
  └─> Phase 2 (Movement)
        └─> Phase 3 (Combat)
              ├─> Phase 4 (Grace/Fervor)
              ├─> Phase 5 (Abilities)
              ├─> Phase 6 (Virtues)
              └─> Phase 7 (Items/Equipment)
                    ├─> Phase 8 (World/Levels)
                    ├─> Phase 9 (Parish Hub)
                    ├─> Phase 10 (Armor of God)
                    └─> Phase 11 (Companions)
                          └─> Phase 12 (Prologue/Tutorial)
                                └─> Phase 13 (District 1: Sloth)
                                └─> Phase 14 (District 2: Gluttony)
                                      └─> Phase 15 (Districts 3-6)
                                            └─> Phase 16 (Citadel/Pride)

Phase 17 (Save System)     — integrate alongside Phase 8+
Phase 18 (Audio)           — integrate alongside Phase 3+
Phase 19 (VFX/Shaders)     — integrate alongside Phase 3+
Phase 20 (Art Production)  — runs in parallel once style is locked (Phase 3+)
Phase 21 (Polish/Balance)  — after Phase 16 content complete
Phase 22 (Export/Deploy)   — after Phase 21
```

## Appendix B — MVP Scope Cuts (If Needed)

If time/resources require reducing scope, cut in this order (last = most expendable):

1. **Keep**: Phases 0-6, 8-9, 12-14 (core loop through Act I)
2. **Reduce**: Phase 15 — ship with 2 Act II districts instead of 4
3. **Defer**: Phase 16 — Pride fight becomes "coming soon" content update
4. **Simplify**: Phase 11 — Tempter Demon text only (no sprite), Guardian Angel as UI hints only
5. **Defer**: Phase 7.2 — Sacred Relics become post-launch content
6. **Simplify**: Phase 7.4 — 2 Gospel Font types instead of 4
7. **Defer**: Phase 22.2 — iOS launch after Android + WebGL

The absolute minimum viable product is: Title Screen + Prologue + Parish + Sloth District + Gluttony District + Act I completion. This delivers a complete arc with the core gameplay loop.
