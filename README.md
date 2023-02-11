# Grobo's Tactical Overhaul (GTO)

This is meant to be a massive megaoverhaul of XCOM 2’s both tactical and strategic layers, mosty focued on the depth and variety of tactical combat.

# Installing and playing the mod

Just Extract and paste One of the releases in your local mod folder.

How to play (after installing):
1. Go to Legacy tab
2. Select “Legacy Operations
3. Click create custom legacy operation
4. Click “Enable Grobo's Tactical Overhaul”
5. (Optional) Configure the op to your liking
6. Click Start

Goals:

Tactical Layer

1.  Significantly lower the reliance on alpha striking (more big 3-4+ turn firefights than 1-2 turn ones)
2. Eliminate the need to manage pod activations
3. Make each enemy far more distinct from one another
4. Repurpose stealth from an ambush and combat avoidance tool to a scouting and defensive one.

Strategy Layer
1. “Distill” and streamline the management aspect to allow for the bigger focus on tactical combat
2. Allow for an extremely wide variety of possible tools for the player (around 50 unique primary weapons, and 50 secondary weapons!) without making all of them available at all times, encouraging the player to adapt.
3. Shorten the campaign to lower the commitment needed and increase replayability.

# Features

##Strategy Layer
Instead of a normal strategy layer campaign, The mod is based around heavily modified Resistance operation overhaul, fighting a semi-randomized string of missions and upgrading your squad between them
The basic campaign length is 20 missions, starting at FL 1 and ending at FL 20.
There are 2 main resources the player gains on missions - Supplies and Research.
### Equipment
*All equipment now has Action economy perks assigned to them, which varies by weapon class and weapon tech.
For example all assault rifles have Light em up, most SMGs have rapid fire, LMG’s and cannons have suppression, etc
Beam Rifle plays completely different from laser rifle - In a way each weapon is its own ability set.

*Reworked the tier system
5 tiers in total, base damage of each Tier is 4/5/6/7/8
Conventional weapons are tier 1
Laser, magnetic and pulse weapons are tier 2 base
Coil, Beam and Plasma weapons are tier 3 base
Tier 2 and 3 weapons have higher tier versions with following prefixes:
+1 tier: Improved
+2 tiers: Superior
+3 tiers: Elite
+4 tiers: Perfected
For example Improved Plasma rifle is tier 4, while Elite Laser Rifle is tier 5.

###Shop and research
After each mission, the shop offers a small, random assortment of equipment, whose quality depends on Research acquired. Each Single item costs supplies.

### Squad
* There is now only 1 Basic soldier class - The operator
It can equip almost every primary and secondary weapon in the game, and its perk tree is randomized.

*Each Squad will now consist of 5 Operators and 1 “Hero” Unit Randomly Chosen (Reaper, Skirmisher, Templar and not yet implemented spark)

*Reworked Skirmisher - Uses Heatsink similar to the proficiency rework. 
*Reworked Reaper  - 
*Reworked Templar - Focus no longer increases rend damage, and all psi perks have far superior action economy. Gains meditation as a base perk, all other perks are granted by the gauntlet type.

* Soldier base stats have been rescaled like this:
8 base HP
80 base aim
15 base mobility
40 base will

* Soldier HP, Aim and Will growths have been completely removed - Makes sure cover is just as important early game as it is late



##Tactical

Here's a headline list of features of this mod

### Podless
* As soon as you are spotted, every enemy in the map activates. Enemy count, XCOM HP and injury recovery times, and defensive tools are all redesigned with this in mind. 
* AI Aggression depends on a mission type. Some missions will be one big map-wide firefight where the enemy hunts you down, but some missions enemies will try to stall you out until reinforcements arrive, and you’ll have to engage them more aggressively.

### Revamped concealment
* With some exceptions, shared concealment now breaks at the start of the 2nd turn.

* Phantom is reworked to temporarily concealing yourself as a free action for 1 turn. (with 3 charges)

* Enemy Detection ranges are severely decreased

* Shadow is keeping its LWOTC Variant

### Grenade Scatter

* Grenades are overall more powerful, but also more unreliable, and can now scatter just like rockets.
* Damage falloff is also quite a bit harsher, and grenades and normal rockets do not shred.

### Cover
* Cover Defense is further increased to 40/55 from 30/45 - significantly raising the value of cover
* Base Flanking crit bonus increased to 60% from 40%

### Ammo management
* Reload is now turn ending

### Attachments
Attachments are not implemented yet, I'm currently trying to figure out how to fit them better with the shop system, as you'll often change weapons, so constantly equipping and unequipping tyem will be tedious. Still, I've got a rough outline already:

Attachments have been rebalanced to:
* Scope - Gain 5 aim, and reduce the long range non-squadsight penalties for weapons by 67%
* Laser sight - Gain 10 crit and reduce the short range penalties for weapons by 67%

* Hair trigger - After a miss, gain +25 aim and crit
* Stock - Missed attacks have a 35% chance to become a graze. Your attacks ignore up to 10 dodge

* Expended magazine, Auto-loader - removed, as they often would remove the gimmicks for a lot of weapons.

* Suppressor - Gain 5 defense. Your first shot in a mission has +25/25 aim and crit.

*Will add support for underbarrel launchers and bayonets.

### Overwatch and suppression
Overwatch has been overhauled:

* Overwatch is now: Fire on the first enemy within line of sight of this soldier (at the time of activating Overwatch) that moves. No aim penalty and ignores cover defense. A unit can only go on overwatch if it has an enemy in line of sight
* Overwatch is no longer removed upon taking damage

Similar to LWR overwatch rules, except it doesn't have covering fire by default. This is an important mechanic change because:
* Makes sure not every mission is a spawn defense with podless
* Makes reinforcements (RNF) something that you will have to deal with instead of just blowing up instantly
* Makes overwatch strong without needing multiple overwatch perks beforehand

* Suppression is now: Fire a barrage that pins down a target, reducing their action points by 1 (units unable to take cover are immune), restricting the use of many abilities, and imposing a 15 penalty to the target's aim. Grants an  overwatch shot that deals half damage if the target moves.

These changes make suppression far more effective at locking down units, and far less effective at killing them.


### Enemies

* Enemy Aim and Will growths have been completely removed - Makes sure cover is just as important early game as it is late
* Enemies no longer have tiers, instead they gain stats based on Force level.
* Incorporated over 100 new permament dark events as new and unpredictable enemy scaling

More detailed enemy changes can be found [Here]([https://docs.google.com/document/d/1NQ52aOqW9bp9_9SxR-L5bFT3OggpIEgcvE1TJTrv2co/edit](https://docs.google.com/document/d/1e5toqREdla1HAwP09LcdcJ7cviJVCrNbk3SPPAYg9X4/edit?usp=sharing), I'll just present some more important changes here

#### The Leader System

* Most pods now have a leader, which is now a significantly more powerful version of a standard unit (eg trooper leader becomes advent vanguard, priest leader is a modified purge priest).

### PRIMARY WEAPONS

* Significantly decreased the amount of shred in the game - makes armor actually important
* Critical Damage is now +50% of a weapon's base damage (Ex. Assault rifle with base damage of 4 will have +2 critical damage)

### Weapon Ranges
Assault Rifles and Bullpups use mid range
SMG’s and Pistols use midshort
Shotguns and Autopistols use short
Cannons and LMG use LMG
Vektors use Midlong
Sniper Rifles use Long
Here are new Weapon Ranges: ```
LMG_ALL_RANGE[0] = -15
LMG_ALL_RANGE[1] = -15
LMG_ALL_RANGE[2] = -10
LMG_ALL_RANGE[3] = -5
LMG_ALL_RANGE[4] = 0
LMG_ALL_RANGE[5] = 4
LMG_ALL_RANGE[6] = 6
LMG_ALL_RANGE[7] = 8
LMG_ALL_RANGE[8] = 9
LMG_ALL_RANGE[9] = 10
LMG_ALL_RANGE[10] = 9
LMG_ALL_RANGE[11] = 8
LMG_ALL_RANGE[12] = 7
LMG_ALL_RANGE[13] = 6
LMG_ALL_RANGE[14] = 5
LMG_ALL_RANGE[15] = 4
LMG_ALL_RANGE[16] = 3
LMG_ALL_RANGE[17] = 2
LMG_ALL_RANGE[18] = 1
LMG_ALL_RANGE[19] = 0
LMG_ALL_RANGE[20] = -4
LMG_ALL_RANGE[21] = -8
LMG_ALL_RANGE[22] = -12
LMG_ALL_RANGE[23] = -16
LMG_ALL_RANGE[24] = -20
LMG_ALL_RANGE[25] = -24
LMG_ALL_RANGE[26] = -100

MID_LONG_ALL_RANGE[0] = -30
MID_LONG_ALL_RANGE[1] = -30
MID_LONG_ALL_RANGE[2] = -27
MID_LONG_ALL_RANGE[3] = -24
MID_LONG_ALL_RANGE[4] = -21
MID_LONG_ALL_RANGE[5] = -18
MID_LONG_ALL_RANGE[6] = -15
MID_LONG_ALL_RANGE[7] = -12
MID_LONG_ALL_RANGE[8] = -9
MID_LONG_ALL_RANGE[9] = -6
MID_LONG_ALL_RANGE[10] = -3
MID_LONG_ALL_RANGE[11] = 0
MID_LONG_ALL_RANGE[12] = 0
MID_LONG_ALL_RANGE[13] = 0
MID_LONG_ALL_RANGE[14] = 0
MID_LONG_ALL_RANGE[15] = 0
MID_LONG_ALL_RANGE[16] = 0
MID_LONG_ALL_RANGE[17] = 0
MID_LONG_ALL_RANGE[18] = 0
MID_LONG_ALL_RANGE[19] = 0
MID_LONG_ALL_RANGE[20] = -3
MID_LONG_ALL_RANGE[21] = -6
MID_LONG_ALL_RANGE[22] = -9
MID_LONG_ALL_RANGE[23] = -12
MID_LONG_ALL_RANGE[24] = -15
MID_LONG_ALL_RANGE[25] = -18
MID_LONG_ALL_RANGE[26] = -21
MID_LONG_ALL_RANGE[27] = -24
MID_LONG_ALL_RANGE[28] = -27
MID_LONG_ALL_RANGE[29] = -30
MID_LONG_ALL_RANGE[30] = -33
MID_LONG_ALL_RANGE[31] = -36
MID_LONG_ALL_RANGE[32] = -39
MID_LONG_ALL_RANGE[33] = -42
MID_LONG_ALL_RANGE[34] = -45
MID_LONG_ALL_RANGE[35] = -48
MID_LONG_ALL_RANGE[36] = -51
MID_LONG_ALL_RANGE[37] = -54
MID_LONG_ALL_RANGE[38] = -57
MID_LONG_ALL_RANGE[39] = -60
MID_LONG_ALL_RANGE[40] = -80
 
 
MEDIUM_ALL_RANGE[0] = 30
MEDIUM_ALL_RANGE[1] = 30
MEDIUM_ALL_RANGE[2] = 27
MEDIUM_ALL_RANGE[3] = 24
MEDIUM_ALL_RANGE[4] = 21
MEDIUM_ALL_RANGE[5] = 18
MEDIUM_ALL_RANGE[6] = 15
MEDIUM_ALL_RANGE[7] = 12
MEDIUM_ALL_RANGE[8] = 11
MEDIUM_ALL_RANGE[9] = 10
MEDIUM_ALL_RANGE[10] = 9
MEDIUM_ALL_RANGE[11] = 8
MEDIUM_ALL_RANGE[12] = 7
MEDIUM_ALL_RANGE[13] = 6
MEDIUM_ALL_RANGE[14] = 5
MEDIUM_ALL_RANGE[15] = 4
MEDIUM_ALL_RANGE[16] = 3
MEDIUM_ALL_RANGE[17] = 2
MEDIUM_ALL_RANGE[18] = 1
MEDIUM_ALL_RANGE[19] = 0
MEDIUM_ALL_RANGE[20] = -5
MEDIUM_ALL_RANGE[21] = -10
MEDIUM_ALL_RANGE[22] = -15
MEDIUM_ALL_RANGE[23] = -20
MEDIUM_ALL_RANGE[24] = -25
MEDIUM_ALL_RANGE[25] = -100

SAWED_OFF_RANGE[0]=60
SAWED_OFF_RANGE[1]=60
SAWED_OFF_RANGE[2]=20
SAWED_OFF_RANGE[3]=0
SAWED_OFF_RANGE[4]=-30
SAWED_OFF_RANGE[5]=-60
SAWED_OFF_RANGE[6]=-90
SAWED_OFF_RANGE[7]=-100

MIDSHORT_ALL_RANGE[0] = 45
MIDSHORT_ALL_RANGE[1] = 45
MIDSHORT_ALL_RANGE[2] = 35
MIDSHORT_ALL_RANGE[3] = 25
MIDSHORT_ALL_RANGE[4] = 15
MIDSHORT_ALL_RANGE[5] = 10
MIDSHORT_ALL_RANGE[6] = 7
MIDSHORT_ALL_RANGE[7] = 3
MIDSHORT_ALL_RANGE[8] = 0
MIDSHORT_ALL_RANGE[9] = 0
MIDSHORT_ALL_RANGE[10] = 0
MIDSHORT_ALL_RANGE[11] = 0
MIDSHORT_ALL_RANGE[12] = -3
MIDSHORT_ALL_RANGE[13] = -6
MIDSHORT_ALL_RANGE[14] = -9
MIDSHORT_ALL_RANGE[15] = -12
MIDSHORT_ALL_RANGE[16] = -16
MIDSHORT_ALL_RANGE[17] = -19
MIDSHORT_ALL_RANGE[18] = -22
MIDSHORT_ALL_RANGE[19] = -30
MIDSHORT_ALL_RANGE[20] = -45
MIDSHORT_ALL_RANGE[21] = -60
MIDSHORT_ALL_RANGE[22] = -75
MIDSHORT_ALL_RANGE[23] = -90
MIDSHORT_ALL_RANGE[24] = -100
MIDSHORT_ALL_RANGE[25] = -100

SHORT_ALL_RANGE[0] = 60
SHORT_ALL_RANGE[1] = 60
SHORT_ALL_RANGE[2] = 45
SHORT_ALL_RANGE[3] = 30
SHORT_ALL_RANGE[4] = 15
SHORT_ALL_RANGE[5] = 8
SHORT_ALL_RANGE[6] = 4
SHORT_ALL_RANGE[7] = 0
SHORT_ALL_RANGE[8] = 0
SHORT_ALL_RANGE[9] = -4
SHORT_ALL_RANGE[10] = -8
SHORT_ALL_RANGE[11] = -16
SHORT_ALL_RANGE[12] = -32
SHORT_ALL_RANGE[13] = -40
SHORT_ALL_RANGE[14] = -48
SHORT_ALL_RANGE[15] = -60
SHORT_ALL_RANGE[16] = -70
SHORT_ALL_RANGE[17] = -80
SHORT_ALL_RANGE[18] = -90
SHORT_ALL_RANGE[19] = -100
SHORT_ALL_RANGE[20] = -100
SHORT_ALL_RANGE[21] = -100
SHORT_ALL_RANGE[22] = -100
SHORT_ALL_RANGE[23] = -100
SHORT_ALL_RANGE[24] = -100
SHORT_ALL_RANGE[25] = -100
 
LONG_ALL_RANGE[0] = -40
LONG_ALL_RANGE[1] = -40
LONG_ALL_RANGE[2] = -36
LONG_ALL_RANGE[3] = -32
LONG_ALL_RANGE[4] = -28
LONG_ALL_RANGE[5] = -24
LONG_ALL_RANGE[6] = -20
LONG_ALL_RANGE[7] = -16
LONG_ALL_RANGE[8] = -12
LONG_ALL_RANGE[9] = -8
LONG_ALL_RANGE[10] = -4
LONG_ALL_RANGE[11] = 0
LONG_ALL_RANGE[12] = 0
LONG_ALL_RANGE[13] = 0
LONG_ALL_RANGE[14] = 0
LONG_ALL_RANGE[15] = 0
LONG_ALL_RANGE[16] = 0
LONG_ALL_RANGE[17] = 0
LONG_ALL_RANGE[18] = 0
LONG_ALL_RANGE[19] = 0
LONG_ALL_RANGE[20] = -2
LONG_ALL_RANGE[21] = -4
LONG_ALL_RANGE[22] = -6
LONG_ALL_RANGE[23] = -8
LONG_ALL_RANGE[24] = -10
LONG_ALL_RANGE[25] = -12
LONG_ALL_RANGE[26] = -14
LONG_ALL_RANGE[27] = -16
LONG_ALL_RANGE[28] = -18
LONG_ALL_RANGE[29] = -20
LONG_ALL_RANGE[30] = -22
LONG_ALL_RANGE[31] = -24
LONG_ALL_RANGE[32] = -26
LONG_ALL_RANGE[33] = -28
LONG_ALL_RANGE[34] = -30
LONG_ALL_RANGE[35] = -32
LONG_ALL_RANGE[36] = -34
LONG_ALL_RANGE[37] = -36
LONG_ALL_RANGE[38] = -38
LONG_ALL_RANGE[39] = -40
LONG_ALL_RANGE[40] = -42
LONG_ALL_RANGE[41] = -44
```
* Notice mid range being much better at longer ranges, and midlong and long ranges having very harsh close range penalties


### DOT EFFECTS CHANGES

* Disorient: more or less the same, slighty lower aim penalty and no longer kills zombies 

* Poison: does not block any abilities, but has much more severe stat penalties than disorient and deals damage 

* Acid burn: One of the few sources of shred, the game is getting changed so armor is overall rarer but shred is much, MUCH less common and harder to do 

## Current State
Currently the Mod is in beta, in a playable but feature incomplete, unbalanced and unpolished state.

It already has a large arsenal of equipment to choose from, and a wide variety of enemies to go against, but more could be added, and I plan on adding a lot more UX features, like better squad editing, tutorial popups for new mechanics, and clearer start game navigation.


## Acknowledgements and Credits


### LWOTC Credits:

 * Track Two, who has provided a huge amount of advice and insight that saved me lots of time
   and ensured certain bugs got fixed at all.
 * The folks behind X2WOTCCommunityHighlander.
 * All the folks in XCOM 2 modders' Discord who have answered my questions.
 * All the authors of the mods that are integrated into this port:
   - robojumper's Squad Select
   - Detailed Soldier List
 * The Long War 2 team for producing the mod in the first place!

 * Peter and Grobo as Main devs
 * Iridar for permission to use his [More Psi Abilities](https://steamcommunity.com/sharedfiles/filedetails/?id=2245270253), [One Handed Templar](https://steamcommunity.com/sharedfiles/filedetails/?id=1593890402), and sawn-off shotgun (from [LW2 Secondary Weapons](https://steamcommunity.com/workshop/filedetails/?id=1140434643))
 * Musashi for permission to use his [Ballistic Shields](https://steamcommunity.com/sharedfiles/filedetails/?id=1416242202) and throwing knives (from [WotC Combat Knives](https://steamcommunity.com/sharedfiles/filedetails/?id=1135248412)).
 * InternetExploder for permission to use their [Beam Grenade Launcher](https://steamcommunity.com/sharedfiles/filedetails/?id=1181681128)
 * Favid for permission to use abilities from the [[WOTC] Shadow Ops Perk Pack](https://steamcommunity.com/sharedfiles/filedetails/?id=1519841231) and their [[WOTC] Extended Perk Pack](https://steamcommunity.com/sharedfiles/filedetails/?id=1546482849)
 * Shiremct for permission to use abilities from [[WOTC] Proficiency Class Pack](https://steamcommunity.com/sharedfiles/filedetails/?id=1265143828)
 * bstar for permission to use abilities from [their perk pack](https://steamcommunity.com/sharedfiles/filedetails/?id=2115077818)
 * The Community Highlander team, as we rely heavily on its bug fixes and modding features
 * The various folks that have been submitting pull requests
 * The people that have provided translations for LWOTC:
   - Italian: SilentSlave
   - Russian: FlashVanMaster
   - French: Savancosinus
 * The folks on XCOM 2 Modders Discord, who have been incredibly helpful at all stages of this project
 * All the folks that have been testing the development builds and providing feedback and issue reports

### GTO specific Credits:

* Iridar for his [Rocket Launchers](https://steamcommunity.com/sharedfiles/filedetails/?id=1775963384&searchtext=rocket+launcher)
* Iridar and claus for [Immolator Models](https://steamcommunity.com/sharedfiles/filedetails/?id=2237137501&searchtext=immolator+overhaul)
* Mitzuri for [Immolator code/Canisters](https://steamcommunity.com/sharedfiles/filedetails/?id=1918448514&searchtext=immolator+overhaul)
* Mitzuri for [Chaining Jolt Code](https://steamcommunity.com/sharedfiles/filedetails/?id=1561030099&searchtext=perk+pack)
* NeIVIeSiS for various 2D icons (Like the light kevlar one)
* Iridar for [Grenade scatter mod](https://steamcommunity.com/sharedfiles/filedetails/?id=2025928724&searchtext=grenade+scatter)
* Claus for [Magnetic Grenade](https://steamcommunity.com/sharedfiles/filedetails/?id=2552974509&searchtext=assault)
* Hnefi for [Some of the podless code](https://steamcommunity.com/sharedfiles/filedetails/?id=1302278158&searchtext=podless+wotc)
* Xylth for [Rookie's choice GTS code](https://steamcommunity.com/sharedfiles/filedetails/?id=1302278158&searchtext=podless+wotc)


## Contributing translations

If you would like to contribute to translations for LWOTC, then check out the
[wiki page](https://github.com/long-war-2/lwotc/wiki/Contributing#localization-translating-text-in-the-game)
that explains how it works.

## Building and running the mod

If you want to contribute changes to code or assets, then you will need to
build the mod so that you can test them. Before you can do that, you need to
set some things up:

 1. Make sure you have the WOTC SDK `full_content` branch installed - see the
    [xcom2mods wiki](https://www.reddit.com/r/xcom2mods/wiki/index#wiki_setting_up_tools_for_modding)
    for details on how to do that (plus lots of other useful information)

 2. [Fork this repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo)
    and then clone your fork locally, which you can do via [Git for Windows](https://gitforwindows.org/)
    (a command-line tool), [GitHub Desktop](https://desktop.github.com/), or some other
    git client tool

 3. Once you have cloned the repository, you may need to pull the code for the embedded
    highlander. If the *X2WOTCCommunityHighlander* directory is empty, then use the
    command line from the project's root directory (the one containing this README.md):
    ```
        > git submodule update --init
    ```
    or whatever is the equivalent with the git client tool you are using.

 4. Obtain the LWOTC-R media assets (video, graphics and sound) from [this Dropbox link](https://www.dropbox.com/s/209rybpdl3khb26/lwotc-content.zip?dl=0)
    and unpack the resulting zip file into this project's *WarOfTheChosenRebalanced* directory.  The link is not up to date with assets added in LWOTC-R, so you will also need to copy over the *WarOfTheChosenRebalanced/Content* directory from one of the released alpha builds.

 5. Set up the following environment variables:
    * `XCOM2SDKPATH` — typically &lt;path to Steam&gt;\steamapps\common\XCOM 2 War Of The Chosen SDK
    * `XCOM2GAMEPATH` — typically &lt;path to Steam&gt;\steamapps\common\XCOM 2\XCom2-WarOfTheChosen
    Don't put these paths in quotes.
	
 6. Open a new command prompt after setting those environment variables and run
    the following from the LWOTC project directory:
    ```
    > build-lwotc.bat -config default
    ```
    (You can specify `-config debug` to compile with debug info)
 
 7. Compilation may fail with errors that certain classes variables and functions in the Community Highlander are private/protected, rather than protected/public.  Edit the corresponding file within the *X2WOTCCommunityHighlander* directory and change variables from private->protected and functions from protected->public as needed to resolve each error.
 
 8. You should also build this modified Community Highlander. Follow [the most up to date instructions in that repository](https://github.com/X2CommunityCore/X2WOTCCommunityHighlander#cooking-a-final-release-automated-method) (CookCommunityHighlander.bat)

Once the highlander and LWOTC-R are built, you will be able to select them as local
mods in Alternative Mod Launcher and run Long War of the Chosen Rebalanced.

## Contributing

Contributions are welcome. If you just want to raise issues, please do so [on GitHub](https://github.com/long-war-2/lwotc/issues),
preferably including a save file if possible.

If you wish to contribute to development — and this project will rely heavily on such contributions — then please
look through the issues and if you want tackle one, just leave a comment along the lines of "I'll take this one".
If you find you can't complete the issue in a reasonable time, please add another comment that says you're relinquishing
the issue.

All contributions are welcome, but bug fixes are _extremely_ welcome!
