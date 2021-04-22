#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onDeactivating

    File: fn_sectorsSM_onDeactivating.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-21 19:29:13
    Last Update: 2021-04-21 19:29:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        We handle these conditions incrementally.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_arrayShuffle
 */

private _debug = MPARAMSM(_onDeactivatingEntered_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

// Probably also need some comprehension whether the sector is captured, i.e. as to whether other bits may occur
private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectorsSM_onDeactivating] Entering: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

[
    _namespace getVariable [Q(KPLIB_garrison_units), []]
    , _namespace getVariable [Q(KPLIB_garrison_assets), []]
] apply {
    // GC regardless of whether ALIVE or DEAD but we do care about !CAPTURED
    _x select { !(_x getVariable [Q(KPLIB_captured), false]); };
} params [
    Q(_units)
    , Q(_assets)
];

// Peeling off one single UNIT+ASSET per state machine iteration
switch (true) do {
    case (count _units > 0): {
        // TODO: TBD: should this really be more of a primitive API function?
        private _unit = (_units call BIS_fnc_arrayShuffle) select 0;
        _namespace setVariable [Q(KPLIB_garrison_units), _units - [_unit]];
        deleteVehicle _unit;
    };
    case (count _assets > 0): {
        // Proper vehicles should be decrewed by this point during the CAPTURING phase
        private _asset = (_assets call BIS_fnc_arrayShuffle) select 0;
        _namespace setVariable [Q(KPLIB_garrison_assets), _assets - [_asset]];
        deleteVehicle _asset;
    };
};

// Remember we got 'here' BECAUSE timer elapsed and other conditions were met
if ((count _units + count _assets) == 0) then {
    // TODO: TBD: deactivate conditioned on whether appropriate resource cleanup has occurred
    [_namespace, MSTATUS(_deactivated), { true; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;
};

if (_debug) then {
    ["[fn_sectorsSM_onDeactivating] Fini", "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
