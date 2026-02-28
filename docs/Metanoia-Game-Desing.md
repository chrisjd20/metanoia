# METANOIA — MVP Game Design Document

> *"Put on the whole armor of God, that you may be able to stand against the schemes of the devil."* — Ephesians 6:11

> *"For our wrestling is not against flesh and blood; but against principalities and power, against the rulers of the world of this darkness, against the spirits of wickedness in the high places."* — Ephesians 6:12

---

## I. Vision Statement

**Metanoia** (Greek: μετάνοια — "a transformative change of heart") is a **Top-Down 2D Action-RPG with Metroidvania Progression**, designed for mobile (iOS/Android) and WebGL browser play, built in Godot.

The game blends the addictive, screen-clearing horde combat of *Vampire Survivors* and *Diablo* with the interconnected world, boss encounters, and gated exploration of *Hollow Knight* — all wrapped in an unapologetically Catholic theological framework. The player experiences the invisible spiritual war described in Ephesians 6:12 made visible, tangible, and playable.

The core fantasy: **You are a newly baptized soul who can now see the demonic infestation rotting a modern city from the inside out. Armed with the Sacraments, the Virtues, and the Armor of God, you fight to liberate its people one soul at a time — not by killing, but by shattering the chains of deception.**

---

## II. Pillars of Design

These are the non-negotiable principles that every feature must serve:

1. **Authentic Catholic Theology, Not Window Dressing.** Every mechanic maps to a real theological concept. Grace is not "reskinned HP" — it behaves like Grace. The Virtues are not "reskinned stats" — they interact the way the Church teaches virtues interact with sin. The game should be playable as catechesis.

2. **Addictive Moment-to-Moment Combat.** Sessions as short as 3–5 minutes must feel complete and satisfying. The dopamine loop of clearing hordes, freeing souls, and watching XP cascade must rival the best in the genre.

3. **A World Worth Exploring.** The interconnected city map must reward curiosity. Locked doors, hidden relics, environmental storytelling, and Sacrament-gated areas create long-term goals that pull the player forward.

4. **No Man Is an Island.** The game constantly reinforces that sanctification is communal. The Parish grows, the Prayer Chain strengthens, freed souls become allies. You cannot beat the endgame alone — you need the Mystical Body of Christ.

5. **Liberation, Not Destruction.** You never kill a human. Every encounter with a possessed or deceived person ends in their liberation. The enemy is always the demon, never the person.

---

## III. Art Direction & Aesthetic

### Style

**Gothic Catholic** — heavy ink lines, deep shadows, stained-glass color palettes, and architectural motifs drawn from medieval cathedrals, illuminated manuscripts, and Baroque religious art. Think *Darkest Dungeon* meets stained glass windows.

### The Two Layers of Reality

The single most striking visual feature of Metanoia is **The Veil** — the game's rendering of two overlapping realities:

**The Mundane Layer (Prologue Only):**
- Desaturated, almost grayscale palette with muted earth tones.
- The city looks like any slightly depressed modern metropolis. No visible enemies. NPCs look tired and blank.
- The player character moves sluggishly. Controls feel slightly unresponsive — you are spiritually asleep.

**The Spiritual Layer (Post-Baptism / The Game Proper):**
- The Gothic palette explodes into life. Deep crimsons, golds, midnight blues, sickly greens for corruption, and radiant whites for sanctified areas.
- Demonic webs stretch between buildings. Shadowy chains drag people down. Demons swarm the streets.
- Freed/sanctified areas glow with warm candlelight tones, stained-glass refractions, and faint choral ambience.
- The UI becomes ornate — the Grace bar is a golden chalice, the Fervor meter is a glowing censer, and ability icons are illuminated manuscript illustrations.

> **MVP Scope Note:** The Mundane Layer only needs to exist for the short Baptism prologue sequence. The Spiritual Layer is the actual game. Visual progression (areas healing as you cleanse them) can be a simple palette/overlay shift per district rather than full environmental remodeling.

---

## IV. Narrative & Story Structure

### Premise

The Pilgrim is an ordinary person living in **Caelum Falls**, a modern metropolis under the dominion of seven Archdemons corresponding to the Seven Deadly Sins. These Archdemons have divided the city into territories, each warping the culture and people of their district to feed their respective sin.

Through a providential encounter with **Father Elias** in a crumbling church on the outskirts, the Pilgrim receives Baptism. The Veil is torn. The spiritual war becomes visible.

Father Elias explains: Caelum Falls was once protected by a network of seven parishes, each housing a sacred relic. The Archdemons corrupted the parishes one by one. Only by reclaiming the city district by district — defeating each Archdemon and restoring each parish — can the spiritual balance be restored.

### Story Arc (Three Acts)

**Act I — The Awakening (Tutorial + First Two Districts)**

The Pilgrim receives Baptism (the Veil lifts), learns combat, and begins liberating the two districts closest to the ruined starting Parish. These are the domains of **Sloth** and **Gluttony** — the "entry-level" sins. The Pilgrim meets their Guardian Angel, encounters the Tempter Demon, and rescues the first NPCs who begin rebuilding the Parish.

Key beats:
- The Pilgrim receives **Confirmation** after defeating the first Archdemon, granting fortitude to push deeper.
- After both Archdemons fall, Father Elias celebrates the **First Mass** in the restored Parish. The Pilgrim receives the **Eucharist** — the Sacraments of Initiation are now complete. Grace restoration becomes sustainable for the trials ahead.

**Act II — The Descent (Four Districts)**

The Pilgrim pushes into the more dangerous inner districts: **Lust**, **Envy**, **Wrath**, and **Greed**. Each is progressively more corrupted and complex. The tone darkens. The Tempter Demon's dialogue becomes more personal and insidious. The Pilgrim encounters **Fallen Faithful** — NPCs who were once part of the original parishes but broke under demonic pressure and now serve the Archdemons.

Key beats:
- The Prayer Chain mechanic becomes essential — the community's intercession is the only thing keeping the Pilgrim alive.
- The Pilgrim liberates the **Central Cathedral** from Greed, restoring the sacred heart of the city and completing the Armor of God.
- Father Elias reveals that **Pride** is not merely occupying a district — it sits at the top of the city, coordinating all the others. The other six feed it.

**Act III — The Ascent (The Citadel + Pride)**

The Pilgrim has freed six districts and assembled all six pieces of the Armor of God. The **Citadel** — the gleaming heart of Caelum Falls — looks like the most "normal" part of the city. In the Spiritual Layer, it is an abomination — a tower of Babel wrapped in mirrors.

Pride is the final boss. Unlike the others, Pride has convinced its subjects they don't need God at all. The Citadel's inhabitants are not chained or tormented. They smile. They are polite. They simply do not see.

Defeating Pride triggers the **Restoration** — the Veil dissolves over Caelum Falls. The Mundane and Spiritual layers merge into one healed reality. The city is not utopia — but it is free.

---

## V. The Gameplay Loop

### Session Structure (3–10 minutes per run)

1. **Depart the Parish.** The Pilgrim leaves the hub, fully equipped. The player chooses which district to enter.
2. **Combat Traversal.** Move through the district, fighting swarms of demons, freeing captive humans, collecting Spiritual Graces (XP/currency). Combat is fast, fluid, and constant. Fervor builds with every righteous strike.
3. **Discover & Unlock.** Find hidden paths, Sacred Relics, Sacramental caches, Scripture Drops, and gated barriers that tease future areas.
4. **Reach a Priest Checkpoint.** Hidden priests act as save/respawn points. Activating one triggers absolution and fully restores Grace.
5. **Boss Encounter or Retreat.** Push into a boss arena or return to the Parish to spend resources and upgrade.
6. **Parish Growth.** Freed NPCs populate the hub. New vendors, lore, buffs, and visual improvements appear.

### Combat Mechanics

**Controls (Mobile-First):**
- **Left Thumb:** Virtual joystick for movement.
- **Right Thumb:** Virtual joystick for aiming the Sword of the Spirit. Tap for quick slash; hold and drag for directional thrust.
- **Ability Buttons:** Two ability slots along the bottom-right.
- **Auto-Cast Auras:** Passive abilities trigger automatically when enemies enter range, similar to *Vampire Survivors* (e.g., waves of holy light, consecration zones that damage demons on contact).

**The "Freeing, Not Killing" System:**

Every enemy falls into one of three categories:

1. **Pure Demons (Lesser & Greater).** Shadow creatures with no human host. Standard health bar (dark aura you disperse). Drop Spiritual Graces on defeat.

2. **Captive Humans.** Humans bound by chains or demonic parasites. They do not attack. Defeat the attached demon or destroy the chain to free them. Freed humans drop Spiritual Graces and flee toward safety, eventually appearing in your Parish.

3. **Embracers (Possessed Humans).** Humans who have allowed demonic possession. Visually mutated, aggressive — with different visuals for each type of deadly sin. They have a **Deception Meter** instead of a health bar — your attacks deplete Deception, not health. When emptied, the demonic influence shatters and the human is freed.

**Damage & Defense:**
- Enemies fire **Fiery Darts** and also attack physically (Ephesians 6:16) — projectiles, lunges, AoE zones, and environmental hazards.
- The Pilgrim takes damage to their **State of Grace** meter.
- Dodging is responsive (short invincibility-frame dash). Positioning matters.

---

## VI. Core Systems

### A. The State of Grace (Health System)

The Grace bar is depicted as a golden **chalice** in the top-left of the screen. When full, it glows warmly. As it depletes, the glow dims and the chalice cracks.

**Restoring Grace:**
- **Eucharist Nodes** — Fixed locations in the world (altars, shrines, tabernacles with a monstrance). Restore Grace when activated. These are inert until the Pilgrim receives the Eucharist after Act I, at which point they become the primary healing resource throughout the world.
- **Eucharist Drops** — Rare drops from freed Captive Humans and Embracers in a Pyx. Available from the start but uncommon; frequency increases after receiving the Eucharist.
- **Prayer Chain Passive** — Community intercession buff provides slow passive Grace regeneration scaling with freed souls. The Pilgrim's primary sustain in Act I before the Eucharist is received.

**Grace Depletion (Death):**

When Grace empties, the Pilgrim enters **Mortal Sin**. The screen desaturates. The Guardian Angel dims. Fervor resets to zero. The Tempter Demon surges forward with a mocking line. Fade to black.

Respawn at the last Priest Checkpoint. Absolution animation restores Grace. Spiritual Graces collected since the checkpoint are lost — but freed souls remain freed.

### B. Fervor (Combat Resource)

Fervor is the Pilgrim's burning spiritual zeal — the fire of righteous action made manifest. It is depicted as a golden **censer** (thurible) beside the Grace chalice. As Fervor builds, the censer glows brighter and holy smoke rises. When full, it blazes with golden fire.

Theologically, Fervor represents the soul's active engagement in spiritual combat. It builds through holy action and fades in complacency. The Pilgrim must stay in the fight — there is no zeal without action.

**Generating Fervor:**
- **Sword Strikes:** Small Fervor per hit. Consecutive hits without taking damage generate a combo multiplier.
- **Freeing Captive Humans:** Large Fervor burst.
- **Shattering an Embracer's Deception:** Large Fervor burst.
- **Defeating Pure Demons:** Moderate Fervor.
- **Intensity Scaling:** Fervor generates faster when more enemies are present — the fiercer the battle, the brighter the zeal burns.

**Fervor Decay:**
- Fervor passively decays when out of combat. Stand still and your zeal cools.
- Taking damage drains a small amount of Fervor — getting hit breaks momentum.
- Entering Mortal Sin (death) resets Fervor to zero.

**Spending Fervor:**

Certain powerful abilities require Fervor to activate (see Section VI.D). This creates a core strategic tension: spending Fervor keeps you alive and powerful in the moment, but prevents you from reaching the Ultimate. Hoarding Fervor means forgoing those abilities, playing dangerously, and betting on the biggest payoff.

**Fervor Overflow (The Angelic Invocation):**

When Fervor reaches maximum and the Pilgrim continues fighting without spending it, the meter enters **Overflow** — the censer erupts with golden fire and the screen pulses with holy light. During Overflow, the **Angelic Invocation** (the St. Michael Ultimate) becomes available. Activating it consumes all Fervor.

If the Pilgrim stops fighting or takes heavy damage during Overflow, Fervor drops back to maximum and the opportunity passes — not wasted, but the window closes.

Reaching Overflow demands sustained aggression and the discipline to save your Fervor rather than spend it. It is the mechanical expression of zeal so fierce that heaven itself responds.

**Fervor and Gospel Fonts:** Activating any Gospel Font instantly fills Fervor to maximum (but not Overflow — the Pilgrim must earn that through continued combat during the Font's effect). This makes Font + horde encounters the prime opportunity for triggering the Ultimate.

### C. The Virtue System (Character Progression)

Virtues replace traditional RPG stats. Leveled using Spiritual Graces collected from combat and exploration.

#### The Four Cardinal Virtues (Core Stats)

| Virtue | Gameplay Effect | Theological Basis |
|---|---|---|
| **Prudence** | Increases critical hit chance. Reveals hidden secrets and pathways. At high levels, grants a brief foresight indicator before boss attacks. | *"The prudent man looks where he is going."* — Proverbs 14:15 |
| **Justice** | Increases Spiritual Graces dropped by freed humans and defeated demons. Increases Prayer Chain effectiveness. Unlocks NPC side-quests. | *"Render to each what is due."* Justice amplifies the fruits of righteous action. |
| **Fortitude** | Increases total Grace (max HP). Reduces knockback. Increases poise during ability channeling. At high levels, grants brief damage resistance when Grace drops below 25%. | *"Be strong and courageous."* — Joshua 1:9 |
| **Temperance** | Reduces cooldown times for abilities. Increases resistance to debuffs (poison, slow, confusion). Unlocks additional Sacramental Slots at high levels. | *"Every athlete exercises self-control in all things."* — 1 Cor 9:25 |

#### The Three Theological Virtues (Damage Types & Resistances)

| Virtue | Offensive | Defensive | Strong Against |
|---|---|---|---|
| **Faith** | Increases light-based and truth-revealing attack damage. Powers Shield of Faith. | Resists deception, illusion, and fear. | Pride, Lust (illusion enemies). |
| **Hope** | Increases piercing attacks that bypass shields. Powers healing multiplier on Eucharist. | Resists despair, paralysis, and drain effects. | Sloth, Envy (drain enemies). |
| **Charity** | Increases AoE radius. Dramatically increases the rate at which humans are freed. Boosts Fervor generation from freeing souls. | Resists wrath, hatred, and isolation effects. | Wrath, Gluttony, Greed. |

#### Vocation Presets (Character Creation)

At the start of the game (after the Baptism prologue), the player selects a **Vocation Preset** that determines their starting Virtue distribution. Each preset is inspired by one of the great intellectual Saints of the Church — Doctors, philosophers, and mystics whose lives embodied a particular path to holiness. These are not classes — every player has access to every Virtue and ability. The presets provide a starting lean and a patron.

| Preset | Patron | Starting Lean | Flavor Text | Playstyle |
|---|---|---|---|---|
| **School of Aquinas** | St. Thomas Aquinas | High Prudence, High Faith | *"Wonder is the desire for knowledge."* | Precision and revelation. Excels at finding secrets, landing critical hits, and seeing through illusions. Glass cannon early, but scales powerfully. |
| **School of Siena** | St. Catherine of Siena | High Justice, High Charity | *"Be who God meant you to be and you will set the world on fire."* | Community and liberation. Frees humans faster, builds the Prayer Chain quicker, and has wider AoE prayers. Relies on the Parish for survival. |
| **School of Augustine** | St. Augustine of Hippo | High Fortitude, High Hope | *"Our hearts are restless until they rest in You, O Lord."* | Endurance and resilience. Massive Grace pool, shrugs off debuffs, and heals more from Eucharist. A tank who walks through fire. |
| **School of Ávila** | St. Teresa of Ávila | High Temperance, High Faith | *"Prayer is nothing else than being on terms of friendship with God."* | Ability-focused. Shortest cooldowns, most active ability uptime, and strongest prayer effects. A "caster" archetype built on spiritual discipline. |
| **School of Newman** | St. John Henry Newman | Balanced across all Virtues | *"To live is to change, and to be perfect is to have changed often."* | Jack of all trades. No major weakness, no spike strength. For players who want to experiment and respec freely. |

### D. Abilities — The Gifts of the Spirit

Active abilities are slotted into 2 ability buttons. They have cooldowns reduced by Temperance. Some abilities additionally require Fervor to activate, gating the most powerful prayers behind active combat engagement. The Pilgrim may equip any combination.

#### Core Abilities

| Ability | Type | Effect | Unlock | Basis |
|---|---|---|---|---|
| **Praise & Worship** | AoE Burst | Radiant shockwave pushes back enemies, deals moderate damage. Freed humans in range get a speed boost to escape. Cooldown only. | Starting ability. | *"Let everything that has breath praise the Lord."* — Psalm 150:6 |
| **Proclamation** | Cone Attack | A cone of piercing light. High damage, staggers enemies. Against Embracers, rapidly shreds the Deception Meter. Scales with Faith and Charity. Cooldown only. | Starting alternate. Player picks one at Baptism; the other unlocks after freeing 10 souls. | *"The word of God is living and active, sharper than any two-edged sword."* — Hebrews 4:12 |
| **Shield of Faith** | Directional Barrier | Raise a golden shield that absorbs all projectiles for 3–4 seconds. Stored energy erupts outward as a counter-blast when the shield drops. Scales with Faith. Cooldown only. | After defeating Sloth (with Confirmation). | *"The shield of faith, wherewith ye shall be able to quench all the fiery darts of the wicked."* — Ephesians 6:16 |
| **The Holy Rosary** | Sustained Orbit | **Requires Fervor.** Glowing rosary beads orbit the Pilgrim for 20 seconds, striking enemies on contact. Every ten hits triggers a **Mystery** — a random powerful effect: burst of healing (Joyful), AoE stun (Luminous), bonus damage surge (Sorrowful), or brief invincibility (Glorious). Scales with Charity. The Rosary manifests only when the Pilgrim's zeal is kindled. | After freeing 50 souls. | *"The Rosary is the weapon for these times."* — St. Padre Pio |
| **Repentance** | Self-Heal | **Requires Fervor.** Kneel in contrition, channeling Fervor inward as an act of penance. Consumes Fervor to instantly restore Grace and cleanse all active debuffs. A lifeline that costs combat momentum — genuine repentance demands the sacrifice of self-will, not gold. | After first Confession (first Priest Checkpoint). | *"Rend your hearts and not your garments."* — Joel 2:13 |

**Strategic tension:** Players who slot both Fervor abilities (Holy Rosary + Repentance) have sustained power and survivability but will rarely reach Overflow. Players who slot no Fervor abilities rush toward the Ultimate but lack those tools. One of each is the balanced path. Every combination is viable.

#### Ultimate Ability

| Ability | Type | Effect | Unlock |
|---|---|---|---|
| **Angelic Invocation (St. Michael)** | Screen Clear | Unleashed when Fervor overflows. The Pilgrim's zeal reaches such intensity that heaven responds — St. Michael the Archangel descends in full armor, sweeping his flaming sword across the screen. Pure demons obliterated; Embracers' Deception shattered; Captive Humans freed. Extremely powerful, earned only through sustained righteous fury. | Fervor Overflow. Unlocks after Act I. |

### E. The Sword of the Spirit & Scripture Drops

The Pilgrim's primary weapon is the **Sword of the Spirit** — the Word of God manifest as a blade of light and the first piece of the Armor of God, received at Baptism. It starts as a dim, flickering short sword.

**Scripture Drops** found throughout the world permanently upgrade the Sword:
- **Early drops:** The blade grows brighter and longer. Base damage increases.
- **Mid-game drops:** Holy fire trails, wider slash arc, richer sound on impact. Fervor generation per strike increases.
- **Late-game drops:** Ranged slashes of light, cuts through demonic shields, bonus damage based on highest Theological Virtue.

The Sword cannot be replaced or unequipped. It is the Word of God, and it grows as the Pilgrim grows. Its final transformation — the **Awakened** form — is granted upon defeating the Archdemon of Greed, completing the Armor of God before the final battle against Pride.

### F. Gospel Fonts (Temporary Power-Ups)

Scattered throughout every district are **Gospel Fonts** — ornate stone basins and open-Bible lecterns that radiate golden light, filled not with water but with living Scripture. They function like shrines in *Diablo* — the Pilgrim activates one and receives a **powerful temporary buff lasting 15–20 seconds**. During the effect, the Pilgrim's aura blazes, a verse flashes on screen, and combat becomes a glorious rampage.

Gospel Fonts are single-use per run (they recharge between runs) and placed at deliberate moments — often just before a dense horde encounter or a particularly dangerous corridor. Finding one should feel like opening a treasure chest: a burst of anticipation followed by a rush of power.

**Activating any Gospel Font instantly fills Fervor to maximum.** Combined with the horde encounters that typically follow, Fonts are the prime opportunity for triggering Fervor Overflow and unleashing the Angelic Invocation. The sequence — Font activation, Fervor blazing, horde engagement, Overflow, St. Michael descends — is designed to be one of the peak moments in any run.

| Font | Effect | Verse |
|---|---|---|
| **Font of Psalms** | Massive damage boost. The Sword blazes with holy fire, every strike sends shockwaves through nearby enemies, and attack speed doubles. Pure hack-and-slash euphoria. | *"The Lord is my strength and my shield."* — Psalm 28:7 |
| **Font of Wisdom** | All ability cooldowns reset instantly and tick at 5x speed for the duration. The Pilgrim can chain abilities back-to-back in a devastating prayer barrage. Fervor abilities can be used freely without draining the meter. | *"If any of you lacks wisdom, let him ask of God, who gives generously."* — James 1:5 |
| **Font of Exodus** | The Pilgrim becomes invincible and gains a massive speed boost. Running through enemies shatters lesser demons on contact and breaks chains on Captive Humans automatically. | *"The Lord will fight for you; you need only be still."* — Exodus 14:14 |
| **Font of Revelation** | A radiant aura expands from the Pilgrim, dealing continuous damage to all enemies on screen. Embracers' Deception Meters drain rapidly. The screen floods with golden light. | *"Then I saw a new heaven and a new earth."* — Revelation 21:1 |

Gospel Fonts are visually distinct — they glow and hum with faint choral tones so the player spots them and feels the pull of anticipation. Activating one should be one of the most satisfying moments in any given run.

### G. The Sacramental System (Build Customization)

Sacramentals are blessed objects providing passive bonuses that alter playstyle. Found in the world, dropped by bosses, rewarded by NPCs, or purchased. The player has limited **Sacramental Slots** (starting at 2, increased by Temperance and story progression, capping at 4–5).

| Sacramental | Effect | Found |
|---|---|---|
| **St. Benedict Medal** | Nullifies the first debuff applied every 30 seconds. | Dropped by a Fallen Faithful mini-boss. |
| **Brown Scapular** | One free resurrection per district run — restored to 50% Grace on the spot instead of respawning. Consumed on use. | Rare drop / Parish vendor (expensive). |
| **Holy Water Vial** | Dodge-dash leaves a trail of holy water that damages demons for 3 seconds. | Found in the Sloth District. |
| **Blessed Salt** | Creates a protective line behind the Pilgrim while walking. Demons cannot cross the salt line for 2 seconds. Prevents flanking and creates safe retreat paths. | Parish vendor (mid-game). |
| **Blessed Candle** | Increases passive light radius by 50% and reveals hidden items within the light. Guardian Angel's Dart Block recharges 20% faster. | Reward from the candlemaker NPC after freeing 15 souls. |
| **Miraculous Medal** | When Grace drops below 15%, become briefly invisible (5 seconds, 60-second cooldown). | Hidden in a district, behind a secret wall. |
| **Crucifix of San Damiano** | +25% AoE radius on prayer abilities. Slow passive Grace regeneration. | Reward for liberating the Cathedral (Greed). |
| **St. Michael Chaplet** | +15% damage against Greater Demons and Archdemons. Fervor generates 25% faster against Greater Demons and bosses. Guardian Angel flares as early warning when a Greater Demon is near. | Dropped by a Greater Demon in the Foundry. |

### H. Sacred Relics (Treasures of the Faith)

Scattered throughout Caelum Falls are **Sacred Relics** — seven treasures of the Church hidden by the faithful before the Archdemons' dominion consumed the city. One lies in each district, its presence a silent counter-testimony to the sin that rules there. These are the most revered objects in Christendom, and finding one is a momentous event.

**When a Sacred Relic is discovered:**

1. A brief cinematic plays — light floods the area with a choral swell.
2. A **generous burst of Spiritual Graces** is awarded (equivalent to freeing dozens of souls).
3. A **permanent passive blessing** is unlocked — a modest but meaningful grace that stacks with other relics and cannot be lost. These are not power-ups; they are the grace of God flowing through sacred objects.
4. The relic is **enshrined in the Parish Reliquary** — a growing display in the rebuilt church that visually transforms as relics are added. NPCs gather around and pray before the relics.

Finding all seven relics completes the **Reliquary of the Faith** and unlocks a powerful Prayer Chain bonus: the community's intercession becomes so fervent that the Pilgrim gains a permanent, substantial Grace regeneration aura in the field.

| Sacred Relic | District | Description | Permanent Blessing |
|---|---|---|---|
| **The Crown of Thorns** | The Outskirts (Sloth) | A circlet of twisted iron thorns, hidden in the stagnant marshes where nothing stirs. Christ's suffering rebukes spiritual apathy — the thorns that drew blood demand a response. The first relic most players will discover. | Taking damage has a 15% chance to release a burst of holy thorns, damaging nearby enemies. +10% Fortitude scaling. |
| **The Sudarium of Oviedo** | The Market (Gluttony) | The bloodstained burial cloth from Christ's Passion, hidden in a locked cold-storage chapel beneath endless food courts and hoarded luxury goods. The cloth testifies that love is self-gift, not consumption. | When Eucharist effects (Nodes or Drops) restore Grace, also cleanse one active debuff. Fervor generation from freeing souls increased by 15%. |
| **The Tilma of Our Lady of Guadalupe** | The Neon Quarter (Lust) | The miraculous cloth bearing Our Lady's image — undimmed by centuries, immune to decay and every illusion. Hidden beneath the district of false beauty, the Mother of God reveals what is real. | Permanent resistance to illusion and deception effects. Hidden enemies, traps, and secrets shimmer faintly at all times. |
| **The Bones of St. Peter** | The Residences (Envy) | The relics of the Rock upon which the Church is built, sealed in a forgotten crypt beneath a neighborhood consumed by suspicion and isolation. Peter, who denied Christ three times but was restored through love, testifies against the bitterness of Envy. | Prayer Chain effectiveness increased by 20%. Freed souls in the Pilgrim's current district contribute to the Prayer Chain immediately rather than upon returning to the Parish. |
| **The Holy Nails** | The Foundry (Wrath) | Three iron nails, buried in a cold anvil at the heart of the burning factories. The instruments of the Passion, resting silent amid purposeless destruction. | +5% critical hit chance. Critical hits release a burst of piercing light that damages nearby enemies. |
| **The Spear of Longinus** | The Financial Cathedral (Greed) | The lance that pierced Christ's side, drawing forth blood and water. Hidden in a sealed vault amid mountains of hoarded gold — the weapon that opened the Sacred Heart, locked away as treasure. | +5% damage on all attacks. The Sword of the Spirit's strikes pierce through the first enemy hit, striking one additional target behind them. |
| **The Shroud of Turin** | The Citadel (Pride) | The burial cloth bearing the true image of Christ — His real face, hidden in the domain of false self-image and cold perfection. The Shroud does not flatter. It shows suffering, humility, and love. | When the Pilgrim enters Mortal Sin, a radiant imprint of light persists for 5 seconds, damaging all demons in the area — even in death, grace endures. +5% to all Theological Virtue scaling. |

---

## VII. The Armor of God (Metroidvania Key Items)

The **Armor of God** (Ephesians 6:10-18) consists of six pieces — permanent, irreversible upgrades that unlock new traversal abilities and open previously gated areas of the map. The Pilgrim receives the first piece — the **Sword of the Spirit** — at Baptism. Defeating each of the six lesser Archdemons grants or awakens an additional piece. By the time the Pilgrim faces Pride, they bear the full Armor of God. These are not equippable Sacramentals — they are the armaments of the soul.

| Armor Piece | Granted After | Traversal Unlock | Gates It Opens |
|---|---|---|---|
| **The Sword of the Spirit** | Baptism (Prologue) | Basic combat — the Word of God as a blade of light. Grows through Scripture Drops throughout the game. | N/A — enables all combat. |
| **The Belt of Truth** | Sloth (Acedia) | **Spiritual Sight Pulse:** Reveals hidden objects, secret passages, and invisible enemies for 10 seconds. Illusory walls shimmer permanently. | "Fog of lies" barriers — areas obscured by spiritual haze. |
| **The Breastplate of Righteousness** | Gluttony | **Righteous Aura:** Passive damage reduction. Immunity to environmental corruption zones (toxic sludge, pools of despair). | Corrupted waterways and toxic zones blocking inner districts. |
| **The Shoes of the Gospel of Peace** | Lust | **Holy Dash:** Long-range invincible dash that crosses gaps, spiritual chasms, and hazard zones. Leaves a trail of consecrated ground. | Spiritual chasms and broken bridges between outer and inner districts. |
| **The Shield of Faith** | Envy | **Perfect Parry:** Timed block reflects projectiles back at attackers for massive damage. Against bosses, stuns briefly. Passive: -15% Fiery Dart damage. | "Mirror gates" — barriers that reflect all attacks. Passed by parrying the gate's own energy back into it. |
| **The Helmet of Salvation** | Wrath | **Unshakeable Mind:** Immunity to fear, confusion, rage, and mind-control. Persistent minimap showing enemy and NPC positions. | "Madness corridors" — psychic assault zones that previously ejected the Pilgrim. |
| **The Sword of the Spirit (Awakened)** | Greed | **True Edge:** Final Sword transformation. Cuts any demonic barrier, shield, or lock. Ranged light-slashes become permanent. Damage scales with Scripture Drops. | All sealed vaults, demonic locks, and the final gate to the Citadel. |

Defeating Pride does not grant an armor piece — the Pilgrim is already fully equipped. Instead, the Pilgrim prays with the full Armor assembled, and the **Restoration** triggers: the Veil dissolves, and Caelum Falls is healed.

---

## VIII. The Seven Archdemons (Boss Encounters)

Each Archdemon is a multi-phase encounter fought at the heart of their district. They require understanding the sin represented and using the correct spiritual tools. Every boss fight teaches something about the sin and rewards the opposite virtue.

### 1. Acedia / Sloth — "The Devouring Fog"

**District:** The Outskirts — abandoned suburbs, overgrown parks, stagnant canals. Everything grey, still, and sinking.

**Arena:** A vast, flooded plaza surrounding a submerged church steeple. Knee-deep spiritual sludge slows the Pilgrim.

**Appearance:** A massive, amorphous fog-entity — a choking grey miasma with dozens of hollow, yawning faces drifting through it. Skeletal arms reach out to drag things under.

**Mechanics:**
- **Phase 1 — The Stupor:** The fog fills the arena and closes in. Standing in fog drains Grace and applies heavy slow. Find and ignite prayer-candle beacons to push fog back and reveal the pulsing dark heart at the center. Strike the core while exposed.
- **Phase 2 — The Despair:** The fog becomes aggressive. Phantom hands grab the Pilgrim, pulling toward the core. The Tempter whispers hopelessness. Use Praise & Worship to break free and keep striking.
- **Phase 3 — The Lie of Comfort:** The fog retreats. The arena becomes calm and warm. Grace regenerates. A voice says: "Rest. You've done enough." If the player stops attacking, the fog slams shut for massive damage. The comfort is the trap. Keep attacking.

**Theological Core:** Sloth is not laziness — it is the spiritual torpor that whispers "it doesn't matter." The fight rewards persistent action against the pull of giving up.

**Drops:** The Belt of Truth.

---

### 2. Gluttony — "The Consumer"

**District:** The Market District — a grotesque parody of a shopping mall. Neon signs with distorted advertisements. Streets littered with excess.

**Arena:** A massive circular arena resembling a gigantic mouth — fleshy floor, teeth-like pillars, a gaping throat-pit at center.

**Appearance:** A colossal, bloated entity fused into the back wall. Multiple grasping arms, distended torso, cavernous mouth always open. Smaller parasites cling to it and drop off to swarm the player.

**Mechanics:**
- **Phase 1 — The Feast:** The Consumer inhales, creating a vortex pulling everything toward its mouth. Dodge behind pillars. While it inhales, its belly is exposed — strike it. After inhaling, it vomits corrupted bile across the arena.
- **Phase 2 — The Binge:** It releases parasites in horde-swarms while trying to grab and devour captive NPCs to regenerate health. Protect the captives while managing the swarm.
- **Phase 3 — The Emptiness:** Desperate and frenzied. Faster but wilder attacks. Its body visibly shrinks and withers — revealing it is hollow and starving beneath the excess. It collapses inward on the final blow.

**Theological Core:** Gluttony is disordered consumption to fill a void only God can fill. Terrifying in its appetite, pathetic in its emptiness.

**Drops:** The Breastplate of Righteousness.

---

### 3. Lust — "The Illusionist"

**District:** The Neon Quarter — neon-drenched, maze-like streets of theaters, clubs, and funhouses. Mirrors everywhere. Nothing is what it appears.

**Arena:** A shifting, kaleidoscopic hall of mirrors. The floor tiles rearrange. Reflections move independently of the Pilgrim.

**Appearance:** The most "beautiful" of the Archdemons — a tall, androgynous figure in flowing robes that shimmer and shift. Its face is always partially obscured. It constantly creates illusory copies of itself.

**Mechanics:**
- **Phase 1 — The Dazzle:** The Illusionist creates 4–5 copies spread around the arena. All attack identically. Only one is real. The Pilgrim must use the Belt of Truth's Spiritual Sight Pulse (or high Faith) to identify the real one. Hitting a copy shatters it but triggers a disorienting flash.
- **Phase 2 — The Seduction:** The Illusionist disguises itself as friendly NPCs — familiar freed humans or the Guardian Angel. It offers "gifts" that look like Eucharist or Scripture Drops but are traps that drain Grace. Resist anything that seems too easy.
- **Phase 3 — The Unmasking:** Cornered, the Illusionist drops all pretense. Its true form is hideous — a hollow shell, all beauty stripped away. It attacks viciously but is now fragile. The mirrors shatter. The maze straightens. Truth wins.

**Theological Core:** Lust distorts perception and substitutes illusion for reality. The fight trains the player to see through deception and value truth over beauty-as-manipulation.

**Drops:** The Shoes of the Gospel of Peace.

---

### 4. Envy — "The Leech"

**District:** The Residences — once-comfortable homes now rotting with suspicion. Every house has curtains drawn. Neighbors spy on neighbors.

**Arena:** A darkened arena with a single spotlight on the Pilgrim. The Leech occupies the shadows at the edges.

**Appearance:** A gaunt, elongated shadow-creature with too-long fingers and hollow, covetous eyes. It has no light of its own — it reflects and steals the Pilgrim's.

**Mechanics:**
- **Phase 1 — The Copy:** The Leech mirrors the Pilgrim's abilities. Use Praise & Worship and it fires a dark version back. The Pilgrim must use communal abilities (Prayer Chain buffs, Intercessory zones) because the Leech is fundamentally isolated and cannot replicate community.
- **Phase 2 — The Drain:** The Leech attaches shadow-tendrils to the Pilgrim, draining Virtue stats and transferring them to itself. Sever the tendrils by dashing through light zones that periodically appear before the drain becomes fatal.
- **Phase 3 — The Offering:** Bloated with stolen power, the Leech becomes aggressive. But the stolen Virtues are unstable. Charity-based attacks cause the stolen energy to rebel, dealing massive internal damage. What is given freely cannot be stolen, and what is stolen cannot be kept.

**Theological Core:** Envy is grief at another's good. It can only take, never create. The fight is won through generosity and community — the things Envy can never possess.

**Drops:** The Shield of Faith.

---

### 5. Wrath — "The Berserker"

**District:** The Foundry — burning factories, molten rivers, collapsed infrastructure. Purposeless destruction. Everything on fire.

**Arena:** A circular forge-pit surrounded by molten slag. Persistent slow Grace-drain. Cooling pools of holy water appear periodically.

**Appearance:** A massive, armored war-demon — a furnace given humanoid shape. Cracked iron plates revealing lava, featureless helm with a burning slit eye, wielding a titanic jagged blade.

**Mechanics:**
- **Phase 1 — The Rage:** Relentless charges, slams, and cleaves covering huge areas. The fight demands perfect dodge timing and patience. Rushing in to trade blows is punished — the Berserker's output is overwhelming. Measured play is rewarded.
- **Phase 2 — The Provocation:** The Berserker taunts the Pilgrim. Destroys the visible Priest Checkpoint. Targets freed NPCs. It wants to make *you* angry. Button-mashing is parried and counterattacked. Controlled, deliberate strikes do more damage.
- **Phase 3 — The Quenching:** It overheats from its own rage. Armor cracks open, exposing the core. The arena floods with holy water. Standing in water heals Grace and damages the Berserker. Finish it with calm, measured strikes.

**Theological Core:** Wrath is self-consuming anger that wants you to become it. Won through patience, restraint, and peace.

**Drops:** The Helmet of Salvation.

---

### 6. Greed — "The Hoarder"

**District:** The Financial District / Central Cathedral — gleaming skyscrapers and the once-sacred Cathedral, converted into a vault. Everything gilded but hollow.

**Arena:** The nave of the corrupted Cathedral, filled with mountains of gold and stolen relics. The altar replaced with an enormous safe.

**Appearance:** A dragon-like entity coiled around the hoard, made of contracts, chains, and ledgers. Golden coin eyes. It speaks in transactions: "What will you give me? What is your price?"

**Mechanics:**
- **Phase 1 — The Bargain:** The Hoarder offers "deals" — actual in-game prompts for powerful buffs in exchange for Virtue points or Sacramentals. Accepting empowers the Hoarder. Refusing all deals enrages it and triggers combat.
- **Phase 2 — The Chains:** Golden chains restrict movement. Treasures hurled as projectiles. Cut chains with the Sword while dodging. Each chain cut frees a section of the Cathedral — stained glass reappears, the altar begins to glow.
- **Phase 3 — The Sacrifice:** Losing its hoard, the Hoarder tries to consume remaining treasure to become a golden abomination. Destroy treasure piles before it absorbs them. The final blow turns gold to ash, revealing the bare, beautiful Cathedral.

**Theological Core:** Greed clutches everything and possesses nothing. The fight asks the player to refuse temptation and value the sacred over the material.

**Drops:** The Sword of the Spirit (Awakened).

---

### 7. Pride — "The Mirror Knight"

**District:** The Citadel — the seat of power. Clean, modern, beautiful, and utterly godless. No visible corruption. No chains. Just cold, perfect order.

**Arena:** The top floor — a pristine white room with floor-to-ceiling mirrors and a single throne.

**Appearance:** The most human-looking Archdemon — a flawless, idealized version of the Pilgrim in blinding silver-white. Same build, same gear, same Sword. It sits on the throne and does not rise until the Pilgrim enters.

**Mechanics:**
- **Phase 1 — The Reflection:** The Mirror Knight perfectly mirrors every attack. You cannot out-damage yourself. Use the Guardian Angel's light to illuminate mirrors and create blind spots — the only angles where strikes deal real damage.
- **Phase 2 — The Exaltation:** The Mirror Knight reveals its true power — the Pilgrim's abilities, amplified. Faster, stronger, flashier. It taunts with praise: "You are magnificent. You don't need anyone else." High Charity weakens its shield — love of others is kryptonite to Pride.
- **Phase 3 — The Shattering:** The Pilgrim cannot defeat Pride alone. The **Prayer Chain activates** — every freed soul begins to pray. Their prayers manifest as cracks in the mirrors. As each mirror shatters, the Knight weakens, its perfect form distorts, revealing the terrified thing beneath. The final blow is struck accompanied by a chorus of the faithful.

**Theological Core:** Pride is the root of all sin and cannot be defeated by individual strength — that would itself be Pride. It falls to humility, community, and the recognition that all gifts come from God.

**Drops:** The Restoration triggers. The Veil dissolves. Caelum Falls is healed.

---

## IX. The Two Companions

### The Guardian Angel

A luminous, semi-transparent figure hovering near the Pilgrim's shoulder. Byzantine iconography — large eyes, flowing robes, wings folded close.

**Gameplay Functions:**
- **Passive Light:** Illuminates dark areas. Radius increases with Faith.
- **Dart Block:** Automatically intercepts a set number of Fiery Darts before recharging (time-based, sped up by Eucharist). A secondary shield layer. Scales with Fortitude.
- **Hints:** Brief text prompts near secrets, boss weakness phases, or idle moments. ("There is something hidden here." "Its shield falters when struck from behind.")
- **Boss Utility:** Unique interactions in the Pride fight (illuminating blind spots) and Lust fight (revealing the real Illusionist).
- **Emotional Anchor:** Encouraging but never saccharine. Low Grace: "Hold fast. Grace is near." Freed soul: "Well done. One more lamb returned."

### The Tempter Demon

A small, shadowy imp lurking at the screen edge — always peripheral, always whispering.

**Gameplay Functions:**
- **Ambient Temptation:** Periodic mocking or manipulative text bubbles. Purely narrative/atmospheric. ("They don't want to be saved." "Why bother? You'll just die again.")
- **Death Response:** When the Pilgrim dies, the Tempter surges forward with a triumphant line before fade-to-black. The player learns to hate this imp.
- **Escalation:** Early game: petty insults. Mid game: appeals to pride. Late game: theological half-truths. ("God helps those who help themselves, you know.")
- **The Silent Treatment:** In sacred moments — receiving a Sacrament, the Restoration — the Tempter goes silent. These silences are powerful because of how constant its presence has been.

---

## X. The Parish Hub & Community Systems

### The Parish

The starting hub is a **ruined parish church** on the outskirts of Caelum Falls.

**Three Growth Stages:**
- **Stage 1 (Start):** Father Elias alone. Makeshift altar. Basic respawn, Virtue leveling, Sacramental equipping.
- **Stage 2 (After Act I):** Roof patched, pews restored, first freed NPCs arrive. A vendor (consumables), a scholar (lore). Stained glass reforms. Bell tower repaired. The Reliquary alcove appears where Sacred Relics are enshrined.
- **Stage 3 (After defeating Pride):** The Parish becomes a cathedral. Full stained-glass windows depicting victories. Choir sings. The community gathers. The Restoration cutscene plays here.

### The Prayer Chain (Community Buff System)

Every freed soul contributes to the **Prayer Chain** — a persistent, scaling buff representing the intercession of the faithful.

- **Passive Grace Regeneration:** Slowly ticks in the field. Rate increases with freed souls.
- **Resistance Buff:** At high levels, passive resistance to debuffs.
- **Boss Phase Aid:** During Archdemon final phases, the Prayer Chain manifests as glowing threads of light connecting the Pilgrim to the community, providing a temporary stat boost.
- **The Pride Fight:** Mechanically essential. Without a sufficient Prayer Chain, the Mirror Knight's Phase 3 cannot trigger. The game will not let you beat Pride alone.

### Parish NPCs

- **Vendor:** Buy consumables (Holy Water Vials, Scapulars, temporary buffs) with Spiritual Graces.
- **Sacristan:** Bless and upgrade Sacramentals to higher tiers.
- **Spiritual Director:** Redistribute (respec) Virtue points for a cost.
- **Quest Givers:** Occasional personal quests from freed NPCs ("My sister is still trapped in the Wrath District"). Rewards and narrative depth.

---

## XI. The World Map — Caelum Falls

Caelum Falls is an interconnected 2D map divided into **seven districts plus the Citadel**, with the Parish on the outskirts. Areas are visible but inaccessible until the correct Armor piece unlocks passage.

| District | Sin | Visual Theme | Key Hazard | Armor That Opens It |
|---|---|---|---|---|
| **The Outskirts (Marshes)** | Sloth / Acedia | Stagnant water, grey fog, abandoned suburbs | Slowing sludge, draining fog | Starting area |
| **The Market** | Gluttony | Neon-lit markets, grotesque food courts | Corrosive bile pools, swarming parasites | Belt of Truth (fog-gated) |
| **The Neon Quarter** | Lust | Mirrors, shifting maze-streets, kaleidoscopic lights | Illusion traps, disorienting flashes | Breastplate of Righteousness (toxic zones) |
| **The Residences** | Envy | Darkened neighborhoods, spying eyes, chain-link fences | Shadow tendrils, stat-drain zones | Shoes of the Gospel (chasm crossings) |
| **The Foundry** | Wrath | Burning factories, molten rivers, collapsed infrastructure | Fire hazards, persistent Grace drain | Shield of Faith (mirror gates) |
| **The Financial Cathedral** | Greed | Gleaming towers, gilded streets, corrupted cathedral | Golden chains restricting movement | Helmet of Salvation (madness corridors) |
| **The Citadel** | Pride | Clean, sterile, modern perfection — no visible corruption | Psychic attacks, mirror-reflection damage | Sword of the Spirit Awakened (sealed gate) |

**Between districts:** Transition zones with optional exploration, Sacred Relics, Sacramental caches, Scripture Drops, and Captive Humans. Multiple entry/exit points and gated teasers for future areas.

---

## XII. Sacraments as Progression Keys

| Sacrament | When Received | Gameplay Effect |
|---|---|---|
| **Baptism** | Prologue | Lifts the Veil. Enables combat. Grants the **Sword of the Spirit** — the first piece of the Armor of God — and the Grace bar. Fervor generation begins. |
| **Confirmation** | After defeating Sloth | Grants the Belt of Truth. Unlocks the Gifts of the Spirit ability system. Fervor Overflow becomes possible. |
| **Eucharist** | After completing Act I (Sloth + Gluttony defeated) | Father Elias celebrates the First Mass in the restored Parish — the Sacraments of Initiation are complete. Eucharist Nodes throughout the world activate as healing sources. Eucharist Drops become more frequent. The chalice on the HUD gains a radiant glow. |
| **Confession** | Ongoing (Priest Checkpoints) | The death/respawn mechanic. Each Priest visit is a miniature Confession. Deeper confessional dialogue weakens the Tempter's effectiveness over time. |

---

## XIII. Audio Design Direction

- **Exploration:** Ambient, contemplative — Gregorian chant elements with atmospheric synths. Each district has a distinct identity that brightens as areas are cleansed.
- **Combat:** Driving, rhythmic percussion with choral swells. Boss fights get unique tracks that build across phases.
- **Parish:** Warm, acoustic, soft choir, church bells. Complexity grows as NPCs arrive.
- **Fervor:** As Fervor builds, a subtle percussive heartbeat intensifies beneath the combat music. At maximum, sustained choir tones enter the mix. During Overflow, the audio swells dramatically — signaling that something extraordinary is imminent.
- **Key Sounds:** Sword strikes ring bell-like (richer with Scripture Drops). Freeing a soul: chain-shatter + clear bell tone (one of the most satisfying sounds in the game). Death: silence except the Tempter's laugh. Absolution: water, whispered prayer, dissonance resolving to harmony. Angelic Invocation: a thunderclap of angelic trumpets and the rush of mighty wings.

---

## XIV. Summary — Why Metanoia Works

Metanoia succeeds because every system reinforces both its gameplay and its message:

- **The combat loop is addictive** because clearing hordes, freeing souls, and watching your power grow is inherently satisfying — and maps to the Christian call to spiritual warfare.
- **The dual-resource system creates constant tension** because Grace (survival) and Fervor (power) demand opposite responses — taking damage costs both, but playing aggressively builds Fervor while risking Grace. Every moment of combat is a decision.
- **The Metroidvania structure creates long-term engagement** because gated areas and interconnected districts reward mastery — and map to progressive sanctification through the Sacraments.
- **The Virtue system creates meaningful build variety** because the Virtues interact with enemy types and boss mechanics in ways that force genuine strategic choices — and map to the Catholic moral framework.
- **The Parish and Prayer Chain create emotional investment** because watching a ruined church become a thriving community is deeply rewarding — and maps to the Ecclesiology of the Mystical Body of Christ.
- **The two companions create narrative richness** because the Guardian Angel and Tempter Demon provide constant, contrasting commentary — and map to the Catholic understanding of spiritual accompaniment.

The game's title is its thesis: **Metanoia** — a complete transformation of mind and heart. The player journeys from spiritual blindness to sight, from isolation to communion, from a ruined parish to a restored city. Every mechanic preaches without ever being preachy, because the theology *is* the gameplay.

> *"Put on the whole armor of God, that you may be able to stand against the schemes of the devil."* — Ephesians 6:11

---
