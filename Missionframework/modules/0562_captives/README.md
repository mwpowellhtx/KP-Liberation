<!-- See also: https://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references -->
## KPLIB CAPTIVES module

### Key variables

There are several types of objects that receive several strategic variables throughout the life cycle of the `CAPTURED` module aspects. When we introduce aspects, we may go into more depth in subsequent sections. Unless otherwise noted, all variables are installed globally.

|Class|Type|Default|Variables|
|-|-|-|-|
|CBA `SECTOR` namespace|`LOCATION`|`locationNull`|<ul><li>`KPLIB_captured`</ul>|
|`Man`\|`CAManBase`|`OBJECT`|`objNull`|<ul><li>`KPLIB_surrender`<li>`KPLIB_captured`<li>`KPLIB_interrogated`<li>`KPLIP_captives_timer`</ul>|
|`Air`\|`LandVehicle`\|`Ship`|`OBJECT`|`objNull`|<ul><li>`KPLIB_surrender`<li>`KPLIB_captured` vehicles not built at a FOB may be captured.<li>`KPLIP_captives_timer` optional, for vehicles surrendered during sector engagement.</ul>|

|Variable|Type|Description|
|-|-|-|
|`KPLIB_surrender`|`BOOL`|<ul><li>When an OPFOR aligned sector is capture by BLUFOR, there is a chance that OPFOR units may surrender themselves.</ul>|
|`KPLIB_captured`|`BOOL`| <ul><li>Installed when a sector is captured; maintained until the sector may be deactivated. This is used to determine whether the sector was captured in order to prohibit false positive activation events from happening. The scope of this variable does not impact the `CAPTIVES` module, however, apart from lending consistency throughout the framework naming conventions.<li>A surrendered `OPFOR` _unit_ may subsequently be _captured_ by `BLUFOR`. Such units must be captured before any other level of interaction may occur. May be _escorted_, _loaded_ onto a _transport vehicle_, _unloaded_ from a transport vehicle, and _interrogated_ in proximity to any _FOB building_.</ul>|
|`KPLIB_interrogated`|`BOOL`|<ul><li>Indicates whether a _unit_ has been _interrogated_.</ul>|
|`KPLIP_captives_timer`|`BOOL`|<ul><li>A `TIMER` `ARRAY` shape that is used to gauge whether a surrendered `UNIT` should be _garbage collected_ (GC).</ul>|
|`KPLIP_captives_transport`|`OBJECT`|<ul><li>An `OBJECT` that is injected on an `ESCORT` prior to interacting with a _transport vehicle_, _captive_, etc. Typically set in a _just-in-time_ (JIT) manner, may or may not need to be global depending on the callback, and which once complete, should also _nilify_ the same.</ul>|

### Captive mode timeout

Timeout is gauged by measuring the `KPLIP_captives_timer`. The tuple is serviced by _server side callbacks_ since the start times are all server based. Not for use in the clients in this sense. The timeout period is used to allow captured units to rest while players mobilize to capture, transport, and, eventually, interrogate. When a timer has elapsed the unit may be _garbage collected_ (GC), meaning deleted. The timer shall be reset in progression with the setting of the flags.

1. _Vehicles_ and _units_ may be _surrendered_, i.e. `_object setVariable ['KPLIB_surrender', true, true]`
1. _Vehicles_ and _units_ alike may then be _captured_, i.e. `_object setVariable ['KPLIB_captured', true, true]`
1. For _vehicles_ that is the extent of their progression; _units_ may further be _interrogated_, i.e. `_object setVariable ['KPLIB_interrogated', true, true]`

_Objects_ and _states_ that are eligible for GC include: `[[VEHICLE, [surrendered]], [UNIT, [any]]]`. _Units_ in _ANY_ state may see GC. Only _vehicles_ that are _surrendered_ may see GC. With _vehicles_, _once captured, always captured_, and they should never see GC following that moment. Now, vehicles may always be lost when away from a _FOB zone_ between server sessions, i.e. need to be in proximity to be serialized, etc, but that is a different topic.

### Captive mode flags

Most client and server side interaction is performed via global variables, `KPLIB_surrender`, `KPLIB_captured`, `KPLIB_interrogated`, depending on the question being asked, by which event handlers, actions, callbacks, etc. In general, expected a `false` default value when getting the variable.

```sqf
_object setVariable ['KPLIB_surrender', true, true];
_object setVariable ['KPLIB_captives_timer', ..., true];
// ...
_object getVariable ['KPLIB_surrender', false];
_object getVariable ['KPLIB_captives_timer', []];
```

### Vehicle concerns

Vehicles are evaluated when they are created by the _KPLIB framework_ during the `'KPLIB_vehicle_created'` event. All objects are evaluated, regardless whether they were built by players at a _FOB zone_, or created in response to _OPFOR_, _CIVILIAN_, or _RESISTENCE_ affairs. Should typically only be evaluated once, but just in case, we include variable guards which preclude stacking actions, event handlers, etc.

#### Vehicle events

_Server side_ event handling ensures that the following [_events_](https://community.bistudio.com/wiki/Arma_3:_Event_Handlers) are wired.

|Event|Parameters|Description|
|-|-|-|
|[`GetInMan`](https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#GetInMan)|`['_unit', '_role', '_vehicle', '_turret']`|Essentially a placeholder for the time being.|
|[`GetOutMan`](https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#GetOutMan)|`['_unit', '_role', '_vehicle', '_turret']`|Ensuring that `'KPLIB_captured'` units are properly positioned aft of the vehicle with appropriate animations.|

#### Vehicle actions <sup>&dagger;</sup>

_Client side_ _JIP_ event handling ensures that the following [_actions_](https://community.bistudio.com/wiki/addAction) are wired. Parameters are adapted from the A3 docs accordingly. `['_vehicle', '_escort']` are analogous to `['_target', '_this']` for purposes of illustration. Only mission critical conditions shall be highlighted here, whereas mundane conditions such as whether the _vehicle_, _escort_, or _captive_ are [`alive`](https://community.bistudio.com/wiki/alive), shall not be mentioned.

|Action|Parameters|Description|Conditions|
|-|-|-|-|
|`STR_KPLIB_ACTION_CAPTIVES_UNLOAD_CAPTIVES`|`['_vehicle', '_escort']`|Initiates an `UNLOAD CAPTIVES` [_commanding menu_](https://community.bistudio.com/wiki/Arma_3:_Communication_Menu) via [`showCommandingMenu`](https://community.bistudio.com/wiki/showCommandingMenu), which shall enumerate the _currently loaded captives_ by name, i.e. `'Unload %1'` (insert `<unit-name/>`), plus a `STOP UNLOADING` action.|`([_vehicle] call KPLIB_fnc_captives_getLoadedCaptives) isNotEqualTo []`|
|`STR_KPLIB_ACTIONS_CAPTIVES_LOAD_CAPTIVE`|`['_vehicle', '_escort']`|Allows an _ESCORT_ to _LOAD_ the currently escorted _CAPTIVE unit_.|`_escort getVariable ['KPLIB_captives_isEscorting', false]`<br>` && [_vehicle, _escort] call KPLIB_fnc_captives_canLoadTransport`|

All such vehicle oriented actions must be presented agnostic of the [`name _unit`](https://community.bistudio.com/wiki/name). This is necessarily the case because we cannot know every unit name that may cross paths with the action. This is appropriately by design.

### Unit concerns

Upon _BLUFOR sector capture_, _OPFOR units_ within _capture range_ are evaluated whether they should _surrender_.

#### Unit actions <sup>&dagger;</sup>

_Client side_ JIP event handling ensures that the following actions are wired. Similar caveats apply for unit_s_ as did for _vehicles_; `['_captive', '_escort']` are analogous to `['_target', '_this']` for purposes of illustration.

|Action|Parameters|Description|Conditions|
|-|-|-|-|
|`STR_KPLIB_ACTIONS_CAPTIVES_CAPTURE_FORMAT`|`['_captive', '_escort']`|Captures the _surrendering captive_; sets `'KPLIB_captured'` flag, and animates accordingly.|`_captive getVariable ['KPLIB_surrender', false]`<br>` && !(_captive getVariable ['KPLIB_captured', false])`|
|`STR_KPLIB_ACTIONS_CAPTIVES_ESCORT_FORMAT`|`['_captive', '_escort']`|_Escorts_ the _captured captive_; sets `'KPLIB_captured'` flag, and animates accordingly.|`isNull attachedTo _captive`<br>`&& isNull objectParent _target`<br>`&& _captive getVariable ['KPLIB_captured', false]`<br>`&& !(_escort getVariable ['KPLIB_captives_isEscorting', false])`|
|`STR_KPLIB_ACTIONS_CAPTIVES_STOP_ESCORT_FORMAT`|`['_captive', '_escort']`|_Stops escorting_ the _escorted captive_; [_detaches_](https://community.bistudio.com/wiki/detach) the _captive_ from the _escort_.|`attachedTo _captive isEqualTo _escort`<br>` && _captive getVariable ['KPLIB_captured', false]`<br>` && (_captive isEqualTo (_escort getVariable ['KPLIB_captives_escortedUnit', objNull]))`|
|`STR_KPLIB_ACTIONS_CAPTIVES_LOAD_FORMAT`|`['_captive']`|Infers the _escort_ by the [_attached object_](https://community.bistudio.com/wiki/attachedTo) to the _captured captive_, in turn the _transport vehicle_ from the _escort_, [_detaches_](https://community.bistudio.com/wiki/detach) the _captive_ from the _escort_, _nilifies_ the `'KPLIB_captives_isEscorting'` and `'KPLIB_captives_escortedUnit'` variables from the _escort_, and raises the `'KPLIB_captives_load'` _server side_ event with `['_captive', '_vehicle']` arguments.|`isNull objectParent _captive`<br>` && attachedTo _captive isEqualTo _escort`<br>` && !isNull ([_escort] call KPLIB_fnc_captives_getNearestTransport)`<br>` && _captive isEqualTo (_escort getVariable ["KPLIB_captives_escortedUnit", objNull])`<br>` && _captive getVariable ["KPLIB_captured", false]`|

### Watch service

<!-- TODO: TBD: pick it up here... -->
<!-- TODO: TBD: watch service does a couple of things... -->
<!-- TODO: TBD: 1. interrogates any of the units that may be such -->
<!-- TODO: TBD: 2. does GC on any of the expiring SURRENDER+ units -->
<!-- TODO: TBD: and as to whether triggers might be a fit for this issue... -->
<!-- TODO: TBD: doubtful, in fact, probably over kill for what this is doing in the end... -->

### Module parameters or other variables

Several parameters influence the manner in which we conduct module operations during the course of a running campaign. Note that, unless otherwise noted, all parameters are of the form, `KPLIB_param_captives%1`.

|Variables|Types|Description|
|-|-|-|
|<ul><li>`_intelDieSides`<li>`_intelDieTimes`<li>`_intelDieOffsets`</ul>|`STRING`|In the form of a comma delimited list of numbers, i.e. `'1,2,3'`, and are indexed according to the inverse of the `ENEMY AWARENESS` ratio. In other words, the more aware the enemy is, the less likely it is that `INTEL` shall be discovered.|
|<ul><li>`_unitSurrenderBias`<li>`_opforLightVehicleSurrenderBias`<li>`_opforHeavyVehicleSurrenderBias`<li>`_opforApcSurrenderBias`</ul>|`SCALAR`|A ratio ranging `[0, 1]`, used to bias whether the object shall surrender when a sector is captured. Capture chances are weighed according to both _BLUFOR strength_ as well as the `ENEMY STRENGTH` ratios.|
|<ul><li>`_assetSurrenderThreshold`<li>`_unitSurrenderThreshold`</ul>|`SCALAR`|A target number used to gauge whether an _ASSET_ or a _UNIT_, respectively, shall surrender when a sector has been _captured_.|
|<ul><li>`_minScuttleTimeout`<li>`_bluforScuttleTimeout`</ul>|`SCALAR`|Timeouts values used to determine when module services should scuttle _BLUFOR_ bits following _OPFOR_ conversion of sectors to enemy alignment.|
|<ul><li>`_captiveTimeout`<li>`_watchUnitSurrenderPeriod`</ul>|`SCALAR`|Meters used to gauge _captive timer durations_, as well as a frequency with which to wake up and evaluate objects for _garbage collection_ (GC).|
|`_loadRange`|`SCALAR`|Literally the _distance_ from which, in meters, _ESCORTING_ players may _LOAD CAPTIVE_ units in to _TRANSPORT VEHICLE CARGO_ positions, or _UNLOAD CAPTIVES_ from the same, respectively.|
|`KPLIB_param_sectors_capRange`|`SCALAR`|`SECTOR` module `CAPTURE RANGE` used to evaluate capture conditions, identify units and assets within range of the sector, and so on.|
|`KPLIB_ace_enabled`|`BOOL`|Indicates whether [_ACE3_](https://ace3mod.com/wiki) is enabled.|

### ACE3 captives support

The [_ACE3 CAPTIVES_ module](https://ace3mod.com/wiki/feature/captives.html) is also supported by KPLIB, for which you should review the documentation and familiarize yourselves with the operation. We have made a somewhat concerted effort in the approach we have taken here to remain consistent with some ACE3-isms, if you will, particularly in how we handle module artifacts such as `'KPLIB_captives_isEscorting'` and `'KPLIB_captives_escortedUnit'` variables. Consistency is also a goal in terms of the chain of events that are wired together, as much as is feasible to accomplish.

### Footnotes
 &dagger; <font size="-1"><em>All actions are considered client side. As such, server side callbacks must invoke them remotely. In general, we try to encapsulate the actions in a steadily wrapped function invocation in order so that we may mitigate the arguments we must provide, and so that we may perform them in a JIP manner when necessary to do so, therefore allowing for maximum availability for current as well as new join players. i.e. `[_object, ...] remoteExecCall ['KPLIB_fnc_captives_addObjectActions', 0, _object]`. Usually the arguments are at least involving the target `_object`. Also, most of the time, the key is that we arrange for the callback on all machines targeting that `_object` in a JIP manner, although sometimes we simple invoke on the server, i.e. `[_object, ...] remoteExecCall ['KPLIB_fnc_captives_serverSideCallback', 2]`.</em></font>











### 'KPLIB_sectors_captured' CBA event

`OPFOR` units caught within _capture range_ of sector during an engagement when the sector has been captured may surrender themselves to capture. Likelihood of surrender depends on several factors, including `BLUFOR` _strength_, `OPFOR` _strength_, and may be further biased by module CBA settings.

 * `KPLIB_surrender`
 * `KPLIB_param_sectors_capRange`
 * `KPLIB_fnc_core_getPlayerStrength`
 * `KPLIB_fnc_enemies_getStrengthRatio`
 * `KPLIB_param_captives_surrenderBias`

### 'KPLIB_surrender' units or assets

_Units_ or _assets_ that are given to surrender shall have the `KPLIB_surrender` variable set as a global variable, and is typically verified accordingly, regardless of the location, whether client or server sides.

```sqf
_target setVariable ['KPLIB_surrender', true, true];
// ...
_target getVariable ['KPLIB_surrender', false];
```

#### Surrendered units

Units receiving the `'KPLIB_surrender'` variable shall have a `'Capture %1'` action added to the unit with which players may interact.

#### Surrendered assets

Players may be permitted to enter enemy _assets_. When assets are determined to be _surrendered_, they shall also receive a `'KPLIB_surrender'` variable. Mostly this is a formality, and for module consistency.

In general, players may `'GetIn'` to any enemy or civilian vehicles. Also such vehicle entries into the driver position shall receive a `'KPLIB_captured'` global variable.

```sqf
_target setVariable ['KPLIB_captured', true, true];
// ...
_target getVariable ['KPLIB_captured', false];
```

The sequence here is tricky, because we respond to _server side_ `'KPLIB_vehicle_created'` events, and want to setup player `'GetIn'` vehicle events on the _client side_. We need to do so JIP so that new server joins may also have access to the _capture_ capabilities.

### Actions are local

Note that all module actions at every phase shall be wrapped in functions that allow for easy invocation for all players. Such invocations shall be performed in a [JIP](https://community.bistudio.com/wiki/remoteExecCall) manner. This should allow server new joins to access the same action as currently connected players.

Conversely, remote executing the action add itself is inefficient at best. Rather we want to contain these in easier to identify functions, with much simpler parameter arrays.

### 'GetInMan' and 'GetOutMan' transport events are server side

When vehicles are created by the KPLIB framework, the module evaluates whether they support `CARGO` positions, i.e. for passengers, _captives_, etc; those that do receive the module `'GetInMan'` and `'GetOutMan'` event handlers. When `UNITS` [`moveInCargo`](https://community.bistudio.com/wiki/moveInCargo) to the vehicle, nothing further is required, and any conditions that depend on that state should keep pace accordingly.

On the other hand, when units are instructed to [`moveOut`](https://community.bistudio.com/wiki/moveOut), we need to refresh the animation, potentially. We may also elect to position the unit accordingly aft of the vehicle several meters or at an otherwise safe distance, or even depending on the form factor of said vehicle, whether `'Air'`, `'LandVehicle'`, `'Ship'`.

### Load and unload captive vehicle actions

Client side vehicle actions include `LOAD CAPTIVE` and `UNLOAD CAPTIVES`. These are by nature non-descript; by definition they cannot know the name of the `UNIT` being `ESCORTED` by a player. Additionally, unloading captives presents an `UNLOAD TRANSPORT COMMANDING MENU`, which presents the captives currently loaded in the vehicle to unload.

Loading the escorted captive is a one shot action. The unit shall detach from the the player and be moved in to the next available vehicle cargo position. Unloading captives presents a commanding menu with currently loaded captives enumerated, `Unload <name-of-unit/>`. Once unloaded the menu will continually refresh until either all such units have been unloaded, or the player chooses to `STOP UNLOADING`, whichever comes first.
