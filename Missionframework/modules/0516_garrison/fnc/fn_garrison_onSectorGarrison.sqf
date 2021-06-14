#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSectorGarrison

    File: fn_garrison_onSectorGarrison.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-03 17:57:50
    Last Update: 2021-06-14 17:12:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to the SECTOR module 'KPLIB_sectors_regiment' event raised during
        the SECTOR STATEMACHINE 'KPLIB_sectorSM_state_garrison' state.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorGarrison_debug)
    || (_sector getVariable [QMVAR(_onSectorGarrison_debug), false])
    ;

// GARRISON one way or another whether BLUFOR+OPFOR
private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _blufor = _sector getVariable [Q(KPLIB_sectors_blufor), false];

if (_debug) then {
    [format ["[fn_garrison_onSectorGarrison] Entering: [_markerName, markerText _markerName, _blufor]: %1"
        , str [_markerName, markerText _markerName, _blufor]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// The GARRISON HASHMAP is the same either way but REGIMENT varies by SIDE
private _garrisonMap = _sector getVariable [QMVAR(_garrisonMap), createHashMap];

private _onGarrisonCallbacks = [
    {
        private _regimentMap = _sector getVariable [QMVAR(_opforRegimentMap), createHashMap];

        [QMVAR(_garrisonOpfor), [_sector, _regimentMap, _garrisonMap]] call CBA_fnc_serverEvent;
        _garrisonMap set [QMVAR(_ready), true];

        { _sector setVariable _x; } forEach [
            [QMVAR(_garrisonMap), _garrisonMap]
            , [QMVAR(_opforRegimentMap), _regimentMap]
        ];
    }
    , {
        private _regimentMap = _sector getVariable [QMVAR(_bluforRegimentMap), createHashMap];

        [QMVAR(_garrisonBlufor), [_sector, _regimentMap, _garrisonMap]] call CBA_fnc_serverEvent;
        _garrisonMap set [QMVAR(_ready), true];

        { _sector setVariable _x; } forEach [
            [QMVAR(_garrisonMap), _garrisonMap]
            , [QMVAR(_bluforRegimentMap), _regimentMap]
        ];
    }
];

private _onGarrisonDefault = {
    if (_debug) then {
        ["[fn_garrison_onSectorGarrison] Default", "GARRISON", true] call KPLIB_fnc_common_log;
    };
};

// There should be a callback here but we will default it just in case
[_onGarrisonCallbacks select _blufor] params [
    [Q(_callback), _onGarrisonDefault, [{}]]
];

[] call _callback;

if (_debug) then {
    ["[fn_garrison_onSectorGarrison] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
