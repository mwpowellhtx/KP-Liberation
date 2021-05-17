#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onReinforce

    File: fn_sectorsSM_onReinforce.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-13 20:16:27
    Last Update: 2021-04-13 20:16:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        REINFORCE 'onStateEntered' event handler.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAMSM(_onReinforce_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectorsSM_onReinforce] Entering: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: reinforce, then raise the flag signaling we can leave the state...
if (true) then {
    [_namespace, MSTATUS(_reinforced), { true; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;
};

if (_debug) then {
    [format ["[fn_sectorsSM_onReinforce] Fini: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
