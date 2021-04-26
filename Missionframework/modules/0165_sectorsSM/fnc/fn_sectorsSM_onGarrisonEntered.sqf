#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onGarrisonEntered

    File: fn_sectorsSM_onGarrisonEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-22 15:03:54
    Last Update: 2021-04-25 20:07:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        GARRISON 'onStateEntered' event handler.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAMSM(_onGarrisonEntered_debug)
    || (_namespace getVariable [QMVARSM(_onGarrisonEntered_debug), false]);

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectorsSM_onGarrisonEntered] Entering: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

[_namespace] call KPLIB_fnc_garrison_onGarrisoning;

// We are 'here' because SECTOR has not yet been GARRISONED...
[_namespace, MSTATUS(_garrisoning), { true; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;

// TODO: TBD: spec out what the garrison should look like
// TODO: TBD: given awareness, strength
// TODO: TBD: also civrep
// TODO: TBD: any other conditions?

private _statusReport = [_namespace] call MFUNC(_getStatusReport);

if (_debug) then {
    [format ["[fn_sectorsSM_onGarrisonEntered] Fini: [_markerName, _statusReport]: %1"
        , str [_markerName, _statusReport]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
