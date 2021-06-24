#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSectorRegiment

    File: fn_garrison_onSectorRegiment.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-03 17:57:36
    Last Update: 2021-06-24 12:47:48
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

private _debug = MPARAM(_onSectorRegiment_debug)
    || (_sector getVariable [QMVAR(_onSectorRegiment_debug), false])
    ;

// REGIMENT one way or another whether BLUFOR+OPFOR
private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _blufor = _sector getVariable [Q(KPLIB_sectors_blufor), false];

if (_debug) then {
    [format ["[fn_garrison_onSectorRegiment] Entering: [_markerName, markerText _markerName, _blufor]: %1"
        , str [_markerName, markerText _markerName, _blufor]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _garrisonMap = _sector getVariable [QMVAR(_garrisonMap), createHashMap];

private _onRegimentCallbacks = [
    {
        private _regimentMap = _sector getVariable [QMVAR(_opforRegimentMap), createHashMap];
        [QMVAR(_regimentOpfor), [_sector, _regimentMap, _garrisonMap]] call CBA_fnc_serverEvent;
        _sector setVariable [QMVAR(_opforRegimentMap), _regimentMap];
    }
    , {
        private _regimentMap = _sector getVariable [QMVAR(_bluforRegimentMap), createHashMap];
        [QMVAR(_regimentBlufor), [_sector, _regimentMap, _garrisonMap]] call CBA_fnc_serverEvent;
        _sector setVariable [QMVAR(_bluforRegimentMap), _regimentMap];
    }
];

private _onRegimentDefault = {
    if (_debug) then {
        ["[fn_garrison_onSectorRegiment] Default", "GARRISON", true] call KPLIB_fnc_common_log;
    };
    true;
};

// There should be a callback here but we will default it just in case
[_onRegimentCallbacks select _blufor] params [
    [Q(_onRegiment), _onRegimentDefault, [{}]]
];

[] call _onRegiment;

if (_debug) then {
    ["[fn_garrison_onSectorRegiment] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
