# Changelog

## 0.98.0 (S2) (Under development)
* Added: Timers support, which will be necessary to support _production_, as well as _logistics_, features.
* Added: Established `production` support, starting with sector discovery and production reconciliation with the same. _Reconciliation_ means, allowing for deleted sectors, as well as for additional sectors. The data should remain healhy in the face of those sorts of changes. The key point is that we track in terms of `_markerName` and maintain a base `_baseMarkerText`. The actual `_markerText` that is applied is always calculated based on these two components, plus taking into consideration the sector `_capability` matrix.
* Bug: Corrected an oversight in the whole _Eden tuple reshaping_, specifically in the `KPLIB_fnc_eden_assetToFlightDeck` chain of custody.
* Refactored: Reshaped the _sectors tuples_, see _docs_: `kp-sectors-tuple-matrix.ods`. Informs both the _Edens_ as well as _FOBs_, for starters. Will soon also be useful for _production_, and in the future informing _logistics_.
  * Was mostly straightforward following the trail of breadcrumbs from KPLIB_sectors_edens and KPLIB_sectors_fobs.
    * Except in a couple of instances such as `KPLIB_fnc_eden_createOrUpdateMarkers` in which we gave element oriented functions defined.
    * Which is to underscore we just need to be careful with this sort of functional shift.
  * On the whole, however, we like this refinement much better than the initial draft.
* Refactored: Renumbered the modules with the introduction of the new ones from previous sprint. Should offer us plenty of room for growth, infilled bits, etc. See _docs_: `a3-kplib-refactor-modules.ods` for more details as to the ordering.
* Bug: Corrected verbiage concerning the `systemTime` formatting function.
* Bug: Handle the use case where serialization occurs for assets beyond the range of known _FOB_ sites. Should never be serialized in the first place, we think, but this is the next best manner in which to respond. Can verify in both `KPLIB_persistence_objects` and `KPLIB_persistence_units` arrays.
* Review: Reviewed bits of the code with regard to building the _FOB building_. We may have a clue as to why bits like _direction_ and _up vectors_ are not being conveyed quite correctly between build confirmation and the building being replaced. But moreover, we think there may be a more general use case for the same sort of functionality, especially as applied to _factory_ and possibly also _township sectors_, _building storage_, and so forth. Not a bridge we will necessarily be crossing today, but could come downstream from here in the next sprint; we want to try to stay focused on just introducing the basics in term of _timers_, introducing the _production_ features, etc.

## 0.98.0 (S1) (Thawed, under development)
* Thawed: **From the previous ice age.** (Details in the [Rekindling discussion](https://github.com/mwpowellhtx/KP-Liberation/discussions/1))
* **_Caveat_**: We are adding some bits that we think deserve a dedicated module unto their own, i.e. _UUID_, _LINQ_, and so on. However, that is going to require that we renumber the modules. This is no small effort, so for now we are placing them as we are in the `0120_common` module, however, with _prefixes_ that are unique to their module. Eventually we will renumber them but for now we are holding off on that level of effort.
* Added: _LINQ_ style aggregate and zip functions for use especially as we get further into things.
* Added: _UUID_ creation functions for purposes of uniquely identifying objects in hand. We will use this for sure to help differentiate between _FOB_ and _start base_ locations vis-a-vis _player_ geolocation.
* Added: `KPLIB_fnc_linq_min` function, which yields the _minimum element_ from a _vector of elements_ of _potentially any shape_.
* Added: Or clarified _static_ and _turret_ assets among the armies.
* Added: `KPLIB_param_edenRange` which captures _start base_ range boundaries for _minimum_ or _maximum_ inquiries, i.e. _within_ or _without_, etc.
* Added: `KPLIB_param_assetMoveRange` CBA setting as a way of tuning the behavior.
* Added: `KPLIB_fnc_eden_enumerate` which enumerates the _start bases_ according to known naming convention; defaults to `KPLIB_eden_startbase` or an open range of `KPLIB_eden_startbase_%1` where `%1` is a _zero based index_. Any break in the index short circuits the enumeration algorithm.
* Added: `KPLIB_fnc_eden_createOrUpdateMarker` which does as it says for an Eden tuple; proxies may specify a `KPLIB_eden_markerText` variable, which serves as the map marker text.
* Added: `KPLIB_fnc_eden_select` as the basis to inquire anything about matching _start base proxies_.
* Added: `KPLIB_fnc_eden_selectWithFlightDeck` which enhanced that inquiry relative to a target, usually `_rotary`, object.
* Added: `KPLIB_fnc_math_convertDecimalToBaseRadix` which does what it says, mainly for use with the military alphabet conversion.
* Added: Using `KPLIB_sectorType` instead of simply `KPLIB_respawn`. It adds clarity, and we can identify whether a _start base_ or an _FOB_ is the focus of deployment as well.
* Added: Ability to verify _UUID_ validity.
* Added: _LINQ_ style _first_ and _last_ functions for use in various aspects. Behaves like a hybrid of the baseline _First_ or _Last_ extension method, with _OrDefault_ comprehension, as well as ability to include the _index_ of the _predicated element_.
* Updated: player actions also respond taking spawn point `_flightDeckProxy` under consideration.
* Updated: The event loop for use with the refactored _start bases_.
* Updated: `KPLIB_fnc_respawn_getRespawns` with comprehension of refactored _start bases_ and use of the _military alphabet_ conversion. Changed the formatting to better suit our preferences; i.e. we like a _grid reference_ first, followed by a _text summary_. We could easily see these formats being user specified, but for now it is what it is.
* Updated: The event loop to better comprehend _player_ geolocation, especially discerning between _FOB_ and _start base_ locations.
* Updated: Applying _UUID_ to _start bases_, _FOBs_, and to _mobile respawn_ assets. We will leverage that in order to uniquely identify where _player_ when facilitating things like _menu actions_.
* Refactored: _Start base_ accounting for potentially one or more such proxies.
* Refactored: `heli` instead to `rotary` especially vis-a-vis moving assets to _flight deck_.
* Refactored: renamed `KPLIB_fnc_core_heliToDeck` instead to `KPLIB_fnc_eden_assetToFlightDeck`, which we think better describes. There is more we think we may do around that approach, but we will take the win that this is for the time being.
* Refactored: _potato spawn_ vis-a-vis moving rotary assets, instead as designated by _start base_ `_flightDeckProxy` variable.
* Refactored: `_flightDeckProxy` can be anything, does not need to be _just the potato spawn point_.
* Refactored: **_Any_** _start base_ can potentially support **_any_** _flight deck_, although typically this is a _cluttercutter proxy object_, specifically the _potato spawn point_.
* Refactored: `KPLIB_fnc_common_getFobAlphabetName` instead to `KPLIB_fnc_common_indexToMilitaryAlpha`, which has a broader application we will need approaching _logistics_, etc.
* Tweaked: Eden starting asset algorithm allowing for specification flexibility.
* Tweaked: A few naming conventions, _Anti-Air_ for _Aa_, _Anti-Tank_ for _At_, and so forth.
* Tweaked: Dropping the `KPLIB_respawn` vehicle variable for mobile respawns. This just adds confusion to the `class CfgRespawnTemplate {...}` template. Instead we leverage a `KPLIB_sectorType` variable.
* Tweaked: Mission object variable naming conventions in keeping with `KPLIB_eden_*` convention.

## 0.97.0 (Frozen, forked, baseline)
* **Fully rewritten the mission code from scratch.** (Details in the [Dev-Blogs](https://github.com/KillahPotatoes/KP-Liberation/issues?q=label%3Adev-blog))
* Added: Functions library via CfgFunctions.
* Added: Admin dialog with various functionalities for server admins.
* Added: Free camera view for building.
* Added: Config guard for preset file syntax error detection.
* Added: KP GUI system implemented for dialog creation.
* Added: Mission configuration completely via CBA Settings.
* Added: Logistic station with cratefiller, vehicle resupply and recycle functionality.
* Added: Garrison dialog for the commander to manage his own sector garrisons.
* Added: Enemy Commander decision making and (re)action triggering via a FSM.
* Updated: Traditional Chinese Localization. Thanks to [dustin902001](https://github.com/dustin902001)
* Removed: Mission configuration via mission parameters.
* Tweaked: License changed from MIT to GPLv3.
* Tweaked: Eden objects got `KPLIB_eden_` as prefix.
* Tweaked: Faster initial sector sorting.
* Tweaked: Stringtable key names categorized.
* Tweaked: Formatting and comments in preset files.
* Tweaked: Mission name now fits the [name standard](https://forums.bohemia.net/forums/topic/217676-mission-name-standard/).
* Tweaked: Sector garrisons are now persistent during activations and doesn't spawn fresh on each activation.
* Tweaked: Unit/Army presets are now universally used as friendly or enemy preset.
* Tweaked: Changing presets is now basically possible without server restart (still needed for Potato 01 replacement).

## 0.963a (10th April 2018 as "legacy support" release)
* Added: Action to raise/lower object while building. Thanks to [darrell-aevum](https://github.com/darrell-aevum)
* Added: Some classnames to arsenal allowed extension list. Thanks to [madpat3](https://github.com/madpat3)
* Added: Functionality to save/load mission parameters. Thanks to [veteran29](https://github.com/veteran29)
* Added: Presets for: RDS Civilians, Project OPFOR SLA and Project OPFOR RACS. Thanks to [PSYKO-nz](https://github.com/PSYKO-nz)
* Added: Automatic mission pbo build tool (available on GitHub). Thanks to [Dahlgren](https://github.com/Dahlgren) and [veteran29](https://github.com/veteran29)
* Added: Tanks DLC classnames for presets.
* Added: Group diag output for serverlog.
* Added: Debug output for group count and amount of active scripts. Liberation starts with [13,70,0,1] and may rise to [70,70,0,1].
* Added: Notification for incoming guerilla forces when attacking a sector.
* Added: Vehicle chance for guerilla forces who approach a sector.
* Added: Traditional Chinese localization. Thanks to [KOEI5113](https://github.com/KOEI5113)
* Added: IDE editorconfig file.
* Added: Overview of actual applied mission parameters on the map screen as diary record.
* Removed: Some old scripts which aren't needed anymore.
* Removed: Always no fog.
* Tweaked: All `spawn compileFinal preprocessFileLineNumbers` replaced with `execVM`.
* Tweaked: All `createGroup` now with activated `deleteWhenEmpty`.
* Tweaked: All `BIS_fnc_relPos` replaced with `getPos`.
* Tweaked: Guerilla forces event chances, strength gain values and unit amounts.
* Tweaked: The Commander / Admin can now change the permissions of offline players.
* Tweaked: BI Revive is now automatically deactivated if ACE Medical is loaded.
* Tweaked: FPS map marker is now below the map and also shows count of local groups.
* Tweaked: Overview picture for loading and mission selection screen.
* Tweaked: Log output source name is now set at each run.
* Fixed: Placement of buildings after save/load. Thanks to [Cre8or](https://github.com/Cre8or)
* Fixed: Sometimes helicopters exploded when spawning on the deck of the USS Freedom.
* Fixed: Players couldn't ziptie the civilian informant, if playing with ACE.
* Fixed: File name instead of mission name in mission selection screen.
* Fixed: "Taking Command" spam from AI after players death.
* Fixed: Fixed range for recycling and start of building instead of using FOB range.
* Fixed: Some vehicles with dynamic loadout support lost their weapons when rearmed by Liberation rearm module.

## 0.963 (05th January 2018)
* Added: Some missing RHS vehicles for the ACE medical system.
* Removed: Provided ACE settings, as they are not used anymore since the last ACE update.
* Tweaked: Arsenal blacklist for more compatibility with 3cbBAF. Thanks to [Applejakerie](https://github.com/Applejakerie)
* Tweaked: Some small tweaks for the Lythium basefile.
* Tweaked: BWMod Classnames due to the last mod update. Thanks to [madpat3](https://github.com/madpat3)
* Fixed: There was a string key twice in the stringtable.
* Fixed: Lythium basefile was missing mission name and description in the lobby.
* Fixed: Issue with building premade squads.

## 0.962 (10th December 2017)
* Added: ACE carry interaction for resource crates. Thanks to [veteran29](https://github.com/veteran29)
* Added: Some additional debug outputs.
* Added: RHS AFRF Preset for the player side. Thanks to [veteran29](https://github.com/veteran29)
* Added: Lythium basefile. Thanks to [Enigma](http://steamcommunity.com/profiles/76561198052767508)
* Added: Portuguese localization. Thanks to [NomadRomeo](https://github.com/NomadRomeo)
* Added: BW Mod Tropentarn preset.
* Added: Project OPFOR Islamic State enemy preset and Project OPFOR resistance preset. Thanks to [Applejakerie](https://github.com/Applejakerie)
* Updated: RHS transport configs.
* Updated: RHS vehicles in presets.
* Updated: Devkit mission.sqm.
* Tweaked: Wounded civilians event. Thanks to [veteran29](https://github.com/veteran29)
* Tweaked: Extended allowed items extension list with some bwmod classnames. Thanks to [madpat3](https://github.com/madpat3)
* Tweaked: Detection of UAVs. Thanks to [veteran29](https://github.com/veteran29)
* Tweaked: Enemy vehicle crew spawning. Ensure that they'll be on the right side (important for red vs blue). Thanks to [veteran29](https://github.com/veteran29)
* Tweaked: If you enter the arsenal with a packed weapon or UAV backpack, it won't be identified as blacklisted anymore.
* Tweaked: FOB container mass now scales with the selected spartan helicopter maximum load. Thanks to [veteran29](https://github.com/veteran29)
* Tweaked: Removed clutter and AI from the USS Freedom on all maps.
* Tweaked: Cleaned all custom placed places on all maps some more and renamed the respawn marker from `respawn_west` to `respawn`.
* Tweaked: Increased the distance of the Little Bird spawnpoints on the USS Freedom and let them facing to the front.
* Tweaked: Some typos in the german stringtable. Thanks to [gqgunhed](https://github.com/gqgunhed)
* Tweaked: The US Army woodland troops got the new OCP and were able to throw away their old UCP.
* Fixed: Wounded civilian animation in dedicated server environment. Thanks to [veteran29](https://github.com/veteran29)
* Fixed: With ACE you could take unconscious AI as POW.
* Fixed: You couldn't handcuff surrendered AI with ACE zipties.
* Fixed: Guerilla could spawn as neutral combatants.
* Fixed: Unloading crates from vehicles could let them sink into the ground since the last ArmA Update.

## 0.961 (6th November 2017)
* Added: ACE auto detection. (BI Revive still has to be disabled manually)
* Added: Parameter to decide if vehicles should have cleared cargo or not. Thanks to [veteran29](https://github.com/veteran29)
* Removed: ACE compatibility parameter.
* Updated: ACE settings from our community due to the new pylons system in ACE.
* Updated: Italian localization. Thanks to [k4s0](https://github.com/k4s0)
* Updated: Chinese Simplified localization. Thanks to [nercon](https://github.com/nercon)
* Updated: List of ignored buildings for the civil reputation.
* Tweaked: Logistic convoy ambush chance balancing.
* Fixed: SMAW optic placed in wrong array in RHS presets.

## 0.96 (12th October 2017)
* Added: BI Support System functionality. (Currently deactivated, as there are still issues in MP)
  * Added: Parameter for access to the Support System -> Disabled, Commander, Whitelist, Everyone.
  * Added: BI Artillery support for artillery vehicles and mortars (if built manned or AI ordered to get in as crew).
  * Added: Players can request artillery support from players (generates task).
* Added: Civil Reputation.
  * Added: Config variables in `kp_liberation_config.sqf`.
  * Added: Reputation penalty for killing civilians.
  * Added: Reputation penalty for killing allied resistance fighters.
  * Added: Reputation penalty for seizing civil vehicles.
  * Added: Reputation penalty for destroyed/damaged civil buildings. (evaluated only on capture a sector event)
  * Added: Mission parameter to choose building penalty for damaged or only destroyed buildings.
  * Added: Reputation gain for liberated sectors.
  * Added: After capturing a sector you might find wounded civilians. You can also gain reputation for offering medical support.
* Added: Civil informant.
  * Added: If you've a good reputation, a civil informant can rarely spawn at blufor sectors.
  * Added: Intel increase, if you capture the informant and bring him back to a FOB.
  * Added: There is a chance that an informant will reveal a time critical task to kill a HVT.
* Added: Asymmetric Threats.
  * Added: Possibility of IEDs in blufor sectors, if you have a bad civil reputation.
  * Added: Own logistic convoys can be ambushed by guerilla forces.
  * Added: Value for guerilla strength which will be affected by the events connected to guerilla forces.
  * Added: Guerilla forces presets.
  * Added: Dynamic guerilla forces equipment depending on their strength value.
  * Added: Chance that guerilla forces will join the fight at a sector as friend or foe. (depends on reputation)
  * Added: Possibility of a guerilla ambush in blufor sectors (additional to IEDs).
* Added: Chinese Simplified localization. Thanks to [nercon](https://github.com/nercon)
* Added: Automatic server restart script for dedicated servers. Thanks to [k4s0](https://github.com/k4s0)
* Added: Settings in the mission parameters for particular debug messages.
* Added: Factory map markers now indicate which production facilities are available there.
* Added: LoW Civilians.
* Added: LoW UAV backpacks to the default blacklist.
* Added: LoW AL-6 Pelican UAV.
* Added: Some of the new RHS vehicles.
* Added: Turkish localization. Thanks to [Carbneth](https://github.com/Carbneth)
* Added: Parameter to set a cooldown for using mobile respawns.
* Updated: English ingame tutorial texts in stringtable. Thanks to [FatRefrigerator](https://github.com/FatRefrigerator)
* Removed: Liberation skill handling of AI units, as BI do this good enough now concerning wounds, etc.
* Removed: Vehicle explosion chance script for convoy ambush.
* Removed: Old debug messages.
* Tweaked: Terrain alignment will be persistent during repeat building of objects (like walls). Thanks to [veteran29](https://github.com/veteran29)
* Tweaked: Some reordering of UI elements.
* Tweaked: Localization support for the extended options menu. Thanks to [nercon](https://github.com/nercon)
* Tweaked: Highlight color in production list changed to blue instead of misleading green.
* Tweaked: Amounts of resources on each FOB and production site is now visible in logistic dropdown menu as `(Supplies/Ammo/Fuel)`.
* Tweaked: Removed the logistic convoy cap of 26 (which was due to the alphabet).
* Tweaked: Captured enemy vehicles are now also listed in the commanders zeus interface.
* Tweaked: Cities won't be able to produce resources anymore.
* Tweaked: IED count in cities, capitals and factories is now dependend on the civil reputation.
* Tweaked: Corrected some strings in the stringtable.
* Tweaked: Factories don't have all facilities from the start anymore. The facility they start with is set at campaign start.
* Tweaked: Replaced all deprecated `BIS_fnc_selectRandom` with the engine solution `selectRandom`.
* Tweaked: Server log will now contain the `[STATS]` message of all clients. (players and HCs)
* Tweaked: Preset system split to select blufor, opfor, resistance and civilians independently. Thanks to [Applejakerie](https://github.com/Applejakerie)
* Tweaked: Capitals, cities and factories are now basically guarded by "militia" forces. Switching to regular army if the enemy combat readiness is increased.
* Tweaked: Static weapons array missed some weapons.
* Tweaked: Civil vehicles are now saved at a FOB after they were seized by players.
* Tweaked: Some small code optimizations and format corrections.
* Fixed: Player got custom recoil and aiming coefficients on respawn.
* Fixed: Rare script error on closing respawn screen directly after joining the mission.
* Fixed: Players could deploy multiple FOBs when they selected deploy fast enough on the same container.
* Fixed: It was possible to disassemble a mortar in preview.
* Fixed: Preview vehicles could get saved if you shut down the mission right after canceling the build process or if you'd still the preview in front you.
* Fixed: Small issues due to the default "hold fire" combat mode for AI.
* Fixed: Single Infantry units weren't saved sometimes.
* Fixed: Paratroopers got sometimes an attack helicopter instead of a transport helicopter.
* Fixed: Rescue helipad blocked building in their near vicinity.
* Fixed: MPKill Eventhandler issue when using ACE.
* Fixed: Function to buy a logistic truck worked but caused an error in dedicated server environment.
* Fixed: Couldn't build under powerlines.
* Fixed: Items in backpack weren't checked by arsenal blacklist crawler.

## 0.955 (24th June 2017)
* Added: Some small aesthetic things for the buildlist
* Added: Exception for TFAR items from the 1.0 Beta (it's TFAR_ and not tf_ in the classnames there)
* Added: Malden missionfile. Thanks to [Applejakerie](https://github.com/Applejakerie)
* Updated: German tutorial texts. Thanks to [madpat3](https://github.com/madpat3)
* Tweaked: Jets removed from battlegroups, so they won't spawn on the ground. But they still appear on high awareness
* Tweaked: Recycle action code, changed from `distance` to `distance2D` to prevent issues with buildings like the airport lamp
* Tweaked: Helipads are now added to Zeus, so the commander can delete them, as they can't be recycled normally
* Fixed: Production and Logistic Overview wasn't usable in normal UI scale
* Fixed: The RHS "Mk.V SOC" boat got no recycle action due to the mounted static weapons

## 0.954 (19th June 2017)
* Added: Some small aesthetic things for the buildlist
* Added: Transport configs for the unarmed Blackfish variants (can hold 5 crates). Thanks to [Applejakerie](https://github.com/Applejakerie)
* Tweaked: Production dialog list entries are now color coded depending on the actual production
* Tweaked: Small changes in the save_manager.sqf concerning object placement
* Tweaked: Raised the default production interval a little bit
* Tweaked: Updated ACE serverside settings
* Fixed: UAVs counted to heli / plane count concerning used slots
* Fixed: SDV was missing in the boats array to be able to place it on water
* Fixed: H-Barrier classname changed from the protected to the public one

## 0.953 (12th June 2017)
* Added: Action to stack and sort resources in storage areas
* Updated: Italian localization. Thanks to [k4s0](https://github.com/k4s0)
* Updated: German localization. (umlauts)
* Tweaked: Statics can now be placed inside buildings
* Tweaked: Recycle of objects which won't give any resources is now always possible
* Tweaked: Debug messages
* Tweaked: Added the blackfish to all presets, as it was already listed to be unlockable
* Tweaked: Again a small change at the placement of objects from the savegame
* Fixed: Error in production dialog due to wrong global variable
* Fixed: Last two supply_vehicle elements weren't shown in the build menu

## 0.952 (4th June 2017)
* Added: Action to push resource crates
* Added: More transport configs for various vehicles. Thanks to [ChiefOwens](https://github.com/ChiefOwens)
* Added: Some more vehicles from RHS to the presets
* Added: More buildable lights for the FOB. Thanks to [Reckulation](https://www.killahpotatoes.de/index.php?user/130-reckulation/)
* Added: [A devkit mission.sqm](https://github.com/Wyqer/kp_liberation/wiki/EN:Devkit) for people who want to port Liberation to other maps
* Added: [GitHub Wiki](https://github.com/Wyqer/kp_liberation/wiki) (will be expanded step by step in the future)
* Removed: Some clutter of the custom enemy bases on each map. Could maybe increase performance a little bit
* Tweaked: Starting times of the maps were not equal
* Tweaked: Syncing times for production when resources are stored or unstored in sector storages
* Tweaked: Moved ACE compatibility and Debug setting from `kp_liberation_config.sqf` to parameters
* Fixed: SDV and armed boat recycle caused a script error
* Fixed: AI Squads weren't saved
* Fixed: Start vehicles were spawning with items in the inventory
* Fixed: Sometimes you couldn't slingload crates which were unloaded from a storage

## 0.951 (28th May 2017)
* Added: Boats at the stern of the Freedom for amphibious insertion
* Added: Transport configs for guerilla offroad and van
* Added: Mission parameter to choose between arsenal with no restrictions at all or using the defined preset from `kp_liberation_config.sqf` (no restriction not recommended)
* Added: Al Rayak missionfile
* Updated: Italian localization. Thanks to [k4s0](https://github.com/k4s0)
* Updated: Russian localization. Thanks to [_KOC_](mailto:Constantin.rogozin@ya.ru)
* Tweaked: Syncing between server and clients after building a sector storage
* Tweaked: Debug info output for sector production and logistic management
* Tweaked: Small things on each mission.sqm. Thanks to [Applejakerie](https://github.com/Applejakerie)
* Tweaked: Factories will directly start producing supplies, as soon as a storage area is built
* Tweaked: General syncing of production and logistic data between client and server
* Tweaked: Resource amount is now also being displayed in the production dialog, not only crates count
* Tweaked: Production menu is now also available if near a production sector
* Tweaked: Checking the content of a crate now also checks if `ropeAttachEnabled` is true and set it to true if not
* Tweaked: Improved logistics algorithm concerning behaviour of loading resources
* Tweaked: Removed unarmed vehicles from sector defender vehicles. They are still transports for battlegroups
* Fixed: Hostile map markers on Sahrani had a little offset from the map grid
* Fixed: No intelobjects spawned at military bases
* Fixed: Missing vehicles because of classname changes due to the ArmA 3 update. Thanks to [madpat3](https://github.com/madpat3) for an overview of all changes
* Fixed: Production menu showed timer even if nothing is produced
* Fixed: Production timer displayed as float if using a resource multiplier
* Fixed: Sahrani mission name wasn't displayed in the server browser, even after mission start
* Fixed: FOB Box won't respawn if fallen into the water
* Fixed: It was possible to create a logistic mission without defining a A or B destination
* Fixed: Logistic dialog didn't update when buying or selling a truck
* Fixed: Error in serverlog concerning loading control CaptureFrames BLUFOR and OPFOR
* Fixed: Boat recycle caused a script error
* Fixed: Exploit of build menu if UI was set to show global resources
* Fixed: Build menu reloads constantly

## 0.95 (22th May 2017)
* Added: New resource system
* Added: Italian localization. Thanks to [k4s0](https://github.com/k4s0)
* Added: Action to change alignment (up or terrain aligned) during placement of buildings
* Added: Action to reassign the commander to the zeus module (only shows if the commander has no access to zeus)
* Added: Paradrop of a resource package when first FOB is built
* Added: Action to switch between displaying global or local FOB resources
* Added: Air vehicle slot system (need a Flight Control to build helipads, hangars and air vehicles)
* Added: Blacklist / Whitelist filtering for saved loadouts
* Added: Recycling of enemy vehicles
* Added: Recycle value now depends on vehicle damage, remaining ammo and fuel
* Added: Production system for factories and cities (not capitals). Accessable for the commander if near a FOB
* Added: Ability to build storage areas at sectors, where produced resources will be stored
* Added: Ability to unlock resource facilities in cities, so you can produce that resource there
* Added: RHS transport configs. Thanks to [Applejakerie](https://github.com/Applejakerie)
* Added: Civilian transport configs. Thanks to [Applejakerie](https://github.com/Applejakerie)
* Added: Optional logistics module for smaller groups to enable a automatic logistics system for the commander
* Added: Mission parameter to enable or disable the logistics system
* Added: [3cb BAF](https://3cbmod.wordpress.com) unit and arsenal preset. Thanks to [ChiefOwens](https://github.com/ChiefOwens)
* Added: DLC Jets to most presets
* Added: Sahrani missionfile. Thanks to [Applejakerie](https://github.com/Applejakerie) for helping with OPFOR Points
* Added: Debug messages for the server.rpt. Default disabled and can be enabled in the `kp_liberation_config.sqf`
* Removed: Resource caps system
* Removed: Old vanilla unit preset (custom.sqf already provides a vanilla setting)
* Removed: Passive Income (due to new resource system)
* Removed: Ammo Bounties (due to new resource system)
* Removed: Civilian Penalties (due to new resource system)
* Removed: Overwrite functionality for `classnames.sqf`, as it is no longer needed due to the preset system
* Removed: `gameplay_constants.sqf`
* Removed: Crate spawn at military bases
* Removed: Chimera Base on maps with a suitable amount of ocean for supporting the Freedom
* Merged: `gameplay_constants.sqf` settings into `kp_liberation_config.sqf` and added descriptions to the variables
* Updated: Spanish localization. Thanks to [regiregi22](https://github.com/regiregi22)
* Updated: English InGame Tutorial text with the latest informations for resource, production and logistic system. Thanks to [Applejakerie](https://github.com/Applejakerie)
* Replaced: Manpower icon with supplies icon. Thanks to [jus61](https://github.com/jus61)
* Replaced: Every deprecated `BIS_fnc_MP` with `remoteExec`
* Replaced: ATLAS LHD with USS Freedom. Thanks to [Applejakerie](https://github.com/Applejakerie) for the immersive clutter on the carrier
* Tweaked: Arsenal blacklist filtering. Thanks to [veteran29](https://github.com/veteran29)
* Tweaked: Initialization of the arsenal, which should increase the performance for blacklist using
* Tweaked: Save manager -> helicopters from the Freedom or Chimera won't be saved, as they spawn on every mission start/load
* Tweaked: Name for savegame namespace -> adapts automaticly to worldName
* Tweaked: Revive settings: BI Revive is enabled by default. Disable it, when you use ACE
* Tweaked: Config, as some apex classnames were missing. Thanks to [Applejakerie](https://github.com/Applejakerie)
* Tweaked: If attacking a sector, a random amount of crates with random resources will spawn once.
* Tweaked: Better comments in the unit preset files. Thanks to [Applejakerie](https://github.com/Applejakerie)
* Tweaked: Vehicles with dead crew can now be recycled
* Tweaked: Altis mission.sqm. Thanks to [Applejakerie](https://github.com/Applejakerie)
* Tweaked: Chimera bases on Takistan and Taunus. Thanks to [Applejakerie](https://github.com/Applejakerie)
* Tweaked: Enemy infantry units will now spawn in initial safe state instead of be directly aware
* Tweaked: Chimera / Carrier spawn markers. Removed any dependency, using only invisible grasscutter objects. Makes porting etc. much easier
* Fixed: UAV unconnectable after player death. Thanks to [veteran29](https://github.com/veteran29)
* Fixed: Missing batteries with Apex laser designators. Thanks to [veteran29](https://github.com/veteran29)
* Fixed: Enemy weapon dance. Thanks to [k4s0](https://github.com/k4s0)
* Fixed: Non vanilla paratroopers don't have a parachute
* Fixed: Enemy jets sometimes spawn on the ground instead flying
* Fixed: ACE medical crate was empty and couldn't be recycled
* Fixed: Slingloading while transport crates inside a helicopter causes the helicopter to slingload the loaded crates inside
* Fixed: Some buildable paratroopers from some presets don't had a parachute

## 0.94 (20th March 2017)
* Added: Tanoa missionfile and vanilla apex preset
* Added: Custom made Chimera Base for Tanoa. Thanks to [jus61](https://github.com/jus61) for building it
* Added: X-Cam-Taunus missionfile
* Added: Custom made Chimera Base for X-Cam-Taunus. Thanks to [jus61](https://github.com/jus61) for building it
* Added: Custom made Chimera Base for Chernarus. Thanks to [Enigma](http://steamcommunity.com/profiles/76561198052767508) for building it
* Added: Arsenal whitelist preset system (change via `kp_liberation_config.sqf`)
  * Use blacklist from unit preset (default)
  * custom whitelist file
  * KP Community Selection
  * RHS USAF
  * RHS USAF with ACE3
  * RHS USAF with ACE3 and ACRE2
* Removed: Dependencies on Takistan missionfile
* Removed: Apex dependencies on Chernarus missionfile (custom chimera base had two apex rocks)
* Removed: Apex dependencies on Taunus missionfile
* Replaced: Old hostile markers (exclamation marks) with a unit count sensitive area marking system
* Tweaked: Presets
  * custom.sqf is now default (vanilla is a kind of legacy now)
  * Vehicle ammo prices are raised to make them more valuable
  * Provided custom.sqf now adapt automaticly to installed mods
* Fixed: Falling Little Birds on LHD
* Fixed: Custom flag texture not applied after savegame load
* Fixed: Mapmarker disable won't work

## 0.931 (10th March 2017)
* Added: Takistan Missionfile
* Added: Chernarus Missionfile
* Added: RHS Takistan Classnames Preset (desert camo)
* Added: RHS Classnames Preset (woodland camo)
* Added: RHS / BW Mod Classnames Preset (woodland camo)
* Fixed: BI Revive Error
* Fixed: Starting game with a prebuild FOB caused errors on Takistan

## 0.93 (7th March 2017)
* Added: `kp_liberation_config.sqf` with some additional config values
* Added: ACE support
* Added: Fuel consumption script
* Added: Preset system (will grow with more maps) to choose between different classnames_extension presets
* Added: `custom.sqf` in the preset system, where you can adjust everything to your liking (like editing the old `classnames_extension.sqf`)
* Added: BI Revive System. Activate it via Parameters in the MP Lobby if you don't use ACE
* Added: Option in the mission parameters to disable the whole mapmarkers and disable the function in the extended options for every player
* Added: Ability to blacklist arsenal items
* Removed: Farooq's Revive
* Tweaked: Player group organisation (group changing via extended options ingame still enabled)
* Tweaked: File organization (split scriptpart from missionpart, so it's easier to provide different maps)
