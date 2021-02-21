/*
    KPLIB_fnc_productionsm_hasPublicationTimer

    File: fn_productionsm_hasPublicationTimer.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-17 15:42:14
    Last Update: 2021-02-20 22:19:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the CBA production '_namespace' is considered elapsed.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]
        _timerPredicate - a timer predicate [CODE, default: KPLIB_fnc_timers_hasElapsed]

    Returns:
        Whether the production timer is considered to be elapsed [BOOL]
 */

private _debug = [["KPLIB_param_productionsm_conditions_debug"]] call KPLIB_fnc_productionsm_debug;

params [
    ["_timerPredicate", KPLIB_fnc_timers_hasElapsed, [{}]]
];

private _objSM = KPLIB_productionsm_objSM;

if (_debug) then {
    ["[fn_productionsm_hasPublicationTimer] Entering", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _retval = [_objSM, _timerPredicate] call {
    params ["_objSM", "_timerPredicate"];
    private _publicationTimer = _objSM getVariable ["KPLIB_productionsm_publicationTimer", []];
    _publicationTimer call _timerPredicate;
};

if (_debug) then {
    [format ["[fn_productionsm_hasPublicationTimer] Finished: [_retval]: %1"
        , str [_retval]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

_retval;
