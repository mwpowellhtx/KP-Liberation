
<!-- https://community.bistudio.com/wiki/getPos -->
<!-- https://community.bistudio.com/wiki/Position#PositionAGLS -->

## `0440 Logistics` (not to be confused with `0400 Logistic`)

Perhaps _0400 Logistic_ is not the best name for that particular one.

However, in this case, we are talking about the _logistical transport of resources_ between _factory sectors_, _FOB sites_, and so on.

* [[Logistics] [0001] Saga: establish the shape of a logistics tuple](https://github.com/mwpowellhtx/KP-Liberation/issues/27)
* [[Logistics] [0002] Saga: design the logistics dialog](https://github.com/mwpowellhtx/KP-Liberation/issues/28)
* [[Logistics] [0003] Saga: consider an appropriate FSM sequence](https://github.com/mwpowellhtx/KP-Liberation/issues/29)
* [_Units of measure_ module](https://github.com/mwpowellhtx/KP-Liberation/tree/rewrite/v0.98/s7/Missionframework/modules/0012_unitsofmeasure) - that we depend upon, in part, to perform various analytical tasks throughout this and the other _logistics_ modules.
* [_Logistics_ module](https://github.com/mwpowellhtx/KP-Liberation/tree/rewrite/v0.98/s7/Missionframework/modules/0440_logistics) - where you are now.
* [_Logistics state machine_ module](https://github.com/mwpowellhtx/KP-Liberation/tree/rewrite/v0.98/s7/Missionframework/modules/0445_logisticsSM) - the _CBA logistics state machine_ module.
* [_Logistics manager_ module](https://github.com/mwpowellhtx/KP-Liberation/tree/rewrite/v0.98/s7/Missionframework/modules/0450_logisticsMgr) - the _logistics manager UI_ module.

The focus here is on the _logistics_ model itself. Most of the elements will be useful when approaching the _logistic state machine_ (`logisticsSM`) module, as well as the _logistics manager_ (`logisticsMgr`) module, but those modules are not in focus here, per se.

### Logistics tuple shape

We like _tuples_ because they can convey a lot of useful very information in a very compact form factor. We use these not only for _serialization_ _loading_ and _saving mission data_, but also during _UI parseling_ among the overall _display_ as well as _constituent member controls_. Additionally, subsets of the same are also relayed during mission critical _change order requests_.

These are conveyed in the following form; note, this is as much intended as _tuple grammar_, a [_domain specific language_](https://en.wikipedia.org/wiki/Domain-specific_language) ([DSL](https://en.wikipedia.org/wiki/Domain-specific_language)) of sorts, as it is [SQF pseudocode](https://community.bistudio.com/wiki/SQF_Syntax):

```sqf
_timer = [
    _duration
    , _startTime
    , _elapsedTime
    , _timeRemaining
];

_billValue = [
    _supplyValue
    , _ammoValue
    , _fuelValue
];

_pos = /* insert valid 3D position */ ;

// Endpoints key on position above all, and may verify against marker bits
_endpoint = [
    _pos
    , _markerName
    , _baseMarkerText
    , _billValue
];

_endpoints = [
    _endpoint           // _alpha - always first, from whence logistic is departing
    , _endpoint         // _bravo - always second, to where logistic is arriving
];

_transportValue = _billValue;   // '_convoy' individually known as '_transportValue'

// May, in fact, be empty, i.e. no transports have been built
_convoy = [] || [
    _transportValue
    , ...
];

_totalDistanceMeters = /* total distance between ALPHA and BRAVO positions [SCALAR] */ ;
_transitDistanceMeters = /* distance the logistics asset has currently traversed [SCALAR] */ ;

_transitPos = /* insert valid 3D position */ ;
_actualPos = /* insert valid 3D position */ ;

_transitDir = /* a valid heading */ ;
_actualDir = /* a valid heading */ ;

/* Basically a 2D associative array mapping the TELEMETRY HASHMAP...
 * Although this is the form we deal with on the client side, we work with
 * a slimmer version of that on the server side.
 */
_telemetry = [
    ["_status", KPLIB_logistics_status_na]  // not applicable
    , ["_duration", KPLIB_timers_disabled]  // seconds
    , ["_elapsedTime", 0]                   // seconds
    , ["_timeRemaining", 0]                 // seconds
    , ["_transportSpeed", 0]                // kilometers per hour (kph)
    , ["_totalDistance", 0]                 // meters
    , ["_transitDistance", 0]               // meters
    , ["_transitPos", [0, 0, 0]]            // 3D position
    , ["_transitDir", 0]
    , ["_transitGridref", ""]               // i.e. '012345'
    , ["_actualPos", [0, 0, 0]]             // 3D position
    , ["_actualDir", 0]
    , ["_actualGridref", ""]                // i.e. '012345'
];

_transportRebateValue = [
    _cost // a [S, A, F] tuple
    , _rebateValue // percentage of expected rebate upon recycle, range: [0, 1]
];

// As aligned to the '_convoy' themselves
_transportRebateValues = [
    _transportRebateValue
    , ...
];

[
    _uuid
    , _status
    , _timer
    , _endpoints
    , _convoy               // Individually, '_transportValue'
    , _telemetry
    , _transportRebateValues
];
```

<!-- TODO: TBD: actually, we may want to serialize '_telemetry' after all, we'll see, especially
 taking into consideration potential for changes in transport speed (kph), and so forth... -->

* `_designation` - Automatically derived based on positional correlation between _array index_ and corresponding _military alphabet_ pseudonym; i.e. `0` refers to _ALPHA_, `3` refers to _DELTA_, and so on. Combinations in excess of the alphabetic numbers are also permissible, heaven forbid. Read: that is _a lot_ of logistics lines, but it can be supported. Strictly speaking, a UI thing for purposes of identifying logistics assets to the manager.
* `_markerName`, `_baseMarkerText` - _Marker name_ and _base marker text_ of _factory sector_ or _FOB site_.
* `_status` - A _bitwise mask_ that represents a precise _situation report_ of the logistics asset from moment to moment throughout the _state machine_. We think that _status_ is also a direct reflection of a logistic asset _state_, in _state machine_ terms, with the standard response, _conditions_, _transitions_, etc, as expected under each of those _state_ umbrellas.
  * `0` - _standby_, inactive, idle, not running, also indicative of an empty `_endpoints` array; _transports_ should be entirely _zeroed_ as well.
  * `1` - _loading_ at the current _ALPHA_ `_endpoint`.
  * `2` - _en route_, logistics running normally.
  * `4` - _aborting_, logistics aborting; similar to _en route_ in the sense that there is a transit to the _nearest endpoint_, but whose objective is to _unload_ all _transport resources_ and _cease logistic asset operation_, resulting in _inactive_ (`0`) `_status`. Precisely the same semantics apply re: _transit navigation_ as during _en route_ resolution.
  * `8` - _unloading_ at the current _BRAVO_ `_endpoint`.
  * `16` - _no resources_, should be seen in conjunction with _loading_, operation suspended for lack of _ALPHA_ `_endpoint` resources.
  * `32` - _route blocked_, should be seen in conjunction with _en route_ or _aborting_, transit literally blocked by _enemy sectors_ in range of current _estimated position_.
  * `64` - _no space_, should be seen in conjunction with _unloading_, operation suspended for lack of _BRAVO_ `_endpoint` _storage space_.
  * `128` - _ambushed_, logistics detected one of its assets has fallen under ambush; at the moment _ambushed_ may fall into `missions` module category, but this is TBD.
  * `256` - _abandoned_, there are moments when a _FOB zone_ may be _repackaged_, etc, players moving or establishing a new site, etc. In this case, the logistic asset was expecting an _endpoint_ to be there when it arrived, but could not continue because the site was _abandoned_, but it should not invalidate the endpoint such as it was, its position, etc. State machine states should anticipate this and update _marker names_, _texts_, accordingly, but never, ever forget the _endpoint position_ itself. Another reason why an _endpoint_ may be _abandoned_ is having lost control of a _factory sector_.
* `_timer` - In a form supported by the _timers module_.
* `_billValue` - In the expected form derived by `KPLIB_fnc_resources_getStorageValue`, specifically, `[_supplyValue, _ammoValue, _fuelValue]`. Semantically, represents the resources being _transfered from_ the associated `_endpoint`.
* `_endpoints` - A pair of _ALPHA_ and _BRAVO_ `_endpoint` tuples. At any given moment in the lifecycle of a logistics line, _ALPHA_ always refers to the origin of the current route, and _BRAVO_ always refers to the _destination_. When logistics has completed delivery in one direction, the endpoints are reversed in preparation of the return trip, if necessary. Additionally, semantically, there cannot be more than one logistics asset committed to an endpoint pairing in either direction; that is, the pairing `[_alpha, _bravo]` is the same as `[_bravo, _alpha]`.
* `_transportValues` - An array of zero or more `_transportValue` in the same shape as `_billValue`. Semantically, transports may only support at most _three_ (`3`) crates, which eligible combinations are mapped as a function of the remaining `_billValue` being transfered.
* `_uuid` - A `UUID`, as prepared by the _uuid module_, serving to uniquely identify each of the _logistics assets_, regardless of its position in the array.
* `_transportSpeedMps` - The most recent known transport speed in _meters per second_ (mps).
* `_totalDistanceMeters` - The total distance between _ALPHA_ and _BRAVO_ positions.
* `_transitDistanceMeters` - the distance the logistics asset has traveled thus far (meters).
* `_transitPos` - An estimated position factoring in distance between _ALPHA_ and _BRAVO_ and `_timer::_elapsedTime` components.
* `_transitDir` - _Direction_, or _heading_, between _ALPHA_ and _BRAVO_ positions in which the transports are traveling.
* `_actualPos` - The _actual position_, if possible, of the transports, usually _along a roadway_.
* `_actualDir` - The _actual direction_, or _heading_, the transports are oriented in, usually _along a roadway_.
* `_transportRebateValues` - A set of `[_cost, _rebateValue]` tuples aligned with the `_transportValues`. Captures the cost and rebate value of each transport _at the time_ of being _built_, in order to allow for the _most accurate actual rebate_ at the time of being _recycled_.

See the _LibreOffice Calc_ documentation concerning these details:

```sqf
KPLIB_logistics_status_standby              =   0;
KPLIB_logistics_status_loading              =   1;
KPLIB_logistics_status_enRoute              =   2;
KPLIB_logistics_status_aborting             =   4;
KPLIB_logistics_status_unloading            =   8;
KPLIB_logistics_status_noResource           =  16;
KPLIB_logistics_status_routeBlocked         =  32;
KPLIB_logistics_status_noSpace              =  64;
KPLIB_logistics_status_ambushed             = 128;
KPLIB_logistics_status_abandoned            = 256;
```

In addition, there are several `_status` masks that make sense to capture:

```sqf
KPLIB_logistics_status_loadingNoResource    = KPLIB_logistics_status_loading    + KPLIB_logistics_status_noResource;
KPLIB_logistics_status_unloadingNoSpace     = KPLIB_logistics_status_unloading  + KPLIB_logistics_status_noSpace;
KPLIB_logistics_status_enRouteAmbushed      = KPLIB_logistics_status_enRoute    + KPLIB_logistics_status_ambushed;
KPLIB_logistics_status_enRouteBlocked       = KPLIB_logistics_status_enRoute    + KPLIB_logistics_status_routeBlocked;
KPLIB_logistics_status_enRouteAbandoned     = KPLIB_logistics_status_enRoute    + KPLIB_logistics_status_abandoned;
KPLIB_logistics_status_abortingAmbushed     = KPLIB_logistics_status_aborting   + KPLIB_logistics_status_ambushed;
KPLIB_logistics_status_abortingBlocked      = KPLIB_logistics_status_aborting   + KPLIB_logistics_status_routeBlocked;
KPLIB_logistics_status_abortingAbandoned    = KPLIB_logistics_status_aborting   + KPLIB_logistics_status_abandoned;
KPLIB_logistics_status_enRouteAbortingAbandoned                                 = KPLIB_logistics_status_enRoute
                                            + KPLIB_logistics_status_aborting   + KPLIB_logistics_status_abandoned;
```

It should be noted, in legacy LIB, there was a state called _&quot;at&quot;_; we decided to simplify this. The state machine will be documented, and probably self-documented, but we can say now, the first state involves _ALPHA endpoint loading_, whereas arriving at the destination transitions to _BRAVO endpoint unloading_. When that process has completed, transports are fully unloaded, the SM will swap the endpoints, _BRAVO_ becomes _ALPHA_, and vice versa, and transitions to _ALPHA endpoint loading_.

See also [_Category: Function Group: Bitwise_](https://community.bistudio.com/wiki/Category:Function_Group:_Bitwise). We will, of course, lean on these functions quite heavily for purposes of these operations.
* [`BIS_fnc_bitwiseCheck`](https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck)
* [`BIS_fnc_bitflagsSet`](https://community.bistudio.com/wiki/BIS_fnc_bitflagsSet)
* [`BIS_fnc_bitflagsUnset`](https://community.bistudio.com/wiki/BIS_fnc_bitflagsUnset)
* [`BIS_fnc_bitflagsFlip`](https://community.bistudio.com/wiki/BIS_fnc_bitflagsFlip)
* [`BIS_fnc_bitwiseAND`](https://community.bistudio.com/wiki/BIS_fnc_bitwiseAND)
* [`BIS_fnc_bitwiseOR`](https://community.bistudio.com/wiki/BIS_fnc_bitwiseOR)
* [`BIS_fnc_bitwiseXOR`](https://community.bistudio.com/wiki/BIS_fnc_bitwiseXOR)
* [`BIS_fnc_bitwiseNOT`](https://community.bistudio.com/wiki/BIS_fnc_bitwiseNOT)

Working with CBA state machines, also be mindful that elements may be added or removed, and relayed to said state machine:
* [`CBA_statemachine_fnc_updateList`](https://cbateam.github.io/CBA_A3/docs/files/statemachine/fnc_updateList-sqf.html), which is critical when managers add or remove logistics assets.

### Server side CBA namespaces

We will want to routinely create _CBA namespaces_ for purposes of capturing _logistics assets_ on the _server side_. Given the _fluid_ nature of logistics assets, can be _added_ and _removed_ at the whims of the manager, we must be able to not only _create_ them, but also _delete_ them.
* [`CBA_fnc_createNamespace`](https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createNamespace-sqf.html)
* [`CBA_fnc_deleteNamespace`](https://cbateam.github.io/CBA_A3/docs/files/common/fnc_deleteNamespace-sqf.html)

We mays also reconsider serialization using namespaces:
* [`CBA_fnc_serializeNamespace`](https://cbateam.github.io/CBA_A3/docs/files/hashes/fnc_serializeNamespace-sqf.html)
* [`CBA_fnc_deserializeNamespace`](https://cbateam.github.io/CBA_A3/docs/files/hashes/fnc_deserializeNamespace-sqf.html)

In terms of namespace variables, the following variables are used to feed a _CBA logistics namespace_.
* `KPLIB_logistics_uuid` - The _UUID_ variable.
* `KPLIB_logistics_status` - The _status_ variable.
* `KPLIB_logistics_timer` - The _timer_ variable.
* `KPLIB_logistics_endpoints` - The _endpoints_ pair, `[_alphaEndpoint, _bravoEndpoint]`.
* `KPLIB_logistics_transportValues` - The `_transportValues` associated with the logistics asset. Better named `KPLIB_logistics_convoy` or `_convoy`.
* `KPLIB_logistics__transportRebateValues` - The `_transportRebateValues` associated with _transport recycle requests_. Should be aligned with the `KPLIB_logistics_transportValues`. Optional, defaults drawn from the current CBA settings, which is why this feature is a worthwhile loop to close, to avoid gaming the system.

And for _telemetry_, especially as a function of `KPLIB_logistics_status`:
* `KPLIB_logistics_telemetry_totalDistanceMeters` - The _total distance_, in _meters_, between _ALPHA_ and _BRAVO_ positions.
* `KPLIB_logistics_telemetry_transitDistanceMeters` - The _current distance_ traversed during _transit_.
* `KPLIB_logistics_telemetry_transportSpeedMps` - The current _transport speed_, in _meters per second_, as a function of `KPLIB_param_logistics_transportSpeedKph`.
* `KPLIB_logistics_telemetry_transitPos` - The _current position_ of the logistics asset during _transit_.
* `KPLIB_logistics_telemetry_transitDir` - The _direction_, or _heading_, between _ALPHA_ to _BRAVO_ endpoints, in that order.
* `KPLIB_logistics_telemetry_actualPos` - The _actual position_ of the logistics asset, usually with respect to a _nearest road segment_.
* `KPLIB_logistics_telemetry_actualDir` - The actual _direction_, or _heading_, with respect to the `KPLIB_logistics_telemetry_actualPos` or _road segment_, which ever _direction_ is most aligned towards the _BRAVO_ position.

### Server side CBA settings

* `KPLIB_param_logistics_transportLoadTimeSeconds` - the time, in _seconds_, it takes to _load_ or _unload_ each _transport_, range `[10, 120]`, default `60`.
* `KPLIB_param_logistics_transportBaseCost` - resource cost in both _supply_ as well as _fuel_ it takes to purchase each _transport_, i.e. `[_x, 0, _x]`, range `[50, 250]`, default `100`.
<!-- TODO: TBD: may actually want to record transport costs so that we do not
 inadvertently leave a gaping hole that can be gamed by smart admins... -->
* `KPLIB_param_logistics_transportRecycleValue` - _percentage_ of the cost that may be rebated upon _recycle_ of each _transport_, range `[0, 1]`, default `0.5`.
* `KPLIB_param_logistics_enemySectorsBlockRoute` - whether _enemy_ controlled sectors _block_ a logistics asset that is _en route_ or _aborting_; when `true`, transit **_halts_**, **_does not_** progress, when the logistics asset arrives within `KPLIB_param_sectors_capRange` of an _enemy controlled sector_. Logistics in this state may be _aborted_, which return to the _ALPHA endpoint_, **_regardless_** of the nearest endpoint distance.
* `KPLIB_param_logistics_transportsMayBeAmbushed` - whether transports _in transit_ may be _ambushed_, _BOOL_, default `true`.
* `KPLIB_param_logistics_safeZoneBuffer` - establishes a _buffer zone_ at an _endpoint_ around which _in transit transports_ **_may not_** be _ambushed_, as a percentage of either `KPLIB_param_fobRange` or `KPLIB_param_sectors_capRange` when _departing from_ or _arriving at_ a _FOB zone_ or _factory sector_, respectively; range `[1.0, 2.0]`, default `1.0`.
* `KPLIB_param_logistics_transportSpeedKph` - expressed in terms of _kilometers per hour_ (_kph_), factored in with `_timer` and with [`distance2D`](https://community.bistudio.com/wiki/distance2D) for purposes of calculating _delta times_, _distance traveled_, during in transit timer refresh, and so forth, so appropriate conversions are required when calculating positions.
* `KPLIB_param_logistics_telemetryRadius` - used to determine _telemetry_ and _proximity_ to features such as _roads_, etc, when estimating _approximate actual position_, for use _when mapping progress_, determining transport and resource splat _during ambush losses_, and so forth.
* `KPLIB_param_logistics_allowPartiallyLoadedTransports` - whether _partially loaded transports_ are allowed when transferring resources from one location to the next.

<!-- TODO: TBD: also determine appropriate settings for ambushed transport effects, i.e. health, fuel, etc...
 maybe as a function of, for instance, civilian reputation. the harsher, the stronger the damage, etc... -->

### Calculations

The primary component is the `_timer`. The logistics `_timer` component is for general use throughout the _state machine_, and its interpretation depends upon that state. _Loading_ and _unloading_ timers use one model. Whereas _en route_ or _aborting_ timers use another model. Distance traveled during transit is calculated by estimating the `_elapsedTime`, [`distance2D`](https://community.bistudio.com/wiki/distance2D) between endpoints, which is calculated in meters, and factoring in the estimated transport.

Use `KPLIB_uom_kph_to_mps`, defined in the `unitsofmeasure` module, for purposes of converting `KPLIB_param_logistics_transportSpeedKph` to _meters per second_, by multiplication. Estimate the _distance achieved during transit_, `_elapsedTime * ([] call KPLIB_fnc_logistics_getTransportSpeedMps)`. In the other direction, it is also possible to estimate `_timer` `_duration` concerning a logistic line, `_distance / ([] call KPLIB_fnc_logistics_getTransportSpeedMps)`.

In terms of _dimensional analysis_, this boils down to `T*(L/T)`, `L/(L/T)` or `L*(T/L)`, respectively, paying attention to _dimensional algebra_, etc. When calculating for _transit distance_, _time cancels_, so we are left with _distance_. Similarly, calculating for timer `_duration`, _distance cancels_, and we are left with _time_. This sort of _dimensional analysis_ helps to _illustate the components_ for what they are without getting lost in the _taxonomy of units_; assuming that the _units of measure_ are appropriately converted.

From there we may perform comparisons with _endpoint positions_, take into consideration _buffer zones_, estimate _road position and direction vectors_, and so on. Additionally, how much of these need to be _server side_, i.e. _CBA namespace-oriented_, or _client UI side_, i.e. _tuples-oriented_, remains to be seen. We will discover the appropriate factoring as we venture forth, cross bridges, etc.

<!-- See: https://github.com/tgrosinger/md-advanced-tables/blob/main/docs/formulas.md -->
<!-- See: https://stackoverflow.com/questions/11256433/how-to-show-math-equations-in-general-githubs-markdownnot-githubs-blog -->
