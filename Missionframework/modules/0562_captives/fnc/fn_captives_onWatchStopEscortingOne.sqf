#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onWatchStopEscortingOne

    File: fn_captives_onWatchStopEscortingOne.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-22 17:52:48
    Last Update: 2021-06-22 17:52:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sort of akin to toggling escort, but is more of a GC handler for cases
        when the ESCORTED UNIT may have been shot or killed, or has otherwise
        timed out and is literally no longer with us, deleted, etc. Must clear
        some states in the player object when that happens. Must be invoked
        remotely.

    Parameter(s):
        _escort - an ESCORT to consider [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
 */


params [
    [Q(_escort), objNull, [objNull]]
];

private _escorting = _escort getVariable [QMVAR(_isEscorting), false];
private _unit = _escort getVariable [QMVAR(_escortedUnit), objNull];

private _debug = MPARAM(_onWatchStopEscortingOne_debug)
    || (_unit getVariable [QMVAR(_onWatchStopEscortingOne_debug), false])
    || (_escort getVariable [QMVAR(_onWatchStopEscortingOne_debug), false])
    ;

if (_debug) then {
    [format ["[fn_captives_onWatchStopEscortingOne] Entering: [_escorting, name _escort, name _unit]: %1"
        , str [_escorting, name _escort, name _unit]], "CAPTIVES", true] call KPLIB_fnc_common_log;
};

/* ESCORT does not require any cleanup or housekeeping:
 *      - ESCORT is 'ESCORTING'
 *      - UNIT no longer ATTACHEDTO the ESCORT
 */
if (_escorting && attachedTo _unit isNotEqualTo _escort) then {

    // Should be fine to remote the ESCORT actions between escort activities
    private _varNames = [QMVAR(_loadUnitID), QMVAR(_stopEscortingID)];

    {
        private _varName = _x;
        private _id = _escort getVariable [_varName, -1];

        if (_debug) then {
            [format ["[fn_captives_onWatchStopEscortingOne] Removing: [_varName, _id]: %1"
                , str [_varName, _id]], "CAPTIVES", true] call KPLIB_fnc_common_log;
        };

        _escort removeAction _id;

    } forEach _varNames;

    if (_debug) then {
        ["[fn_captives_onWatchStopEscortingOne] Housekeeping", "CAPTIVES", true] call KPLIB_fnc_common_log;
    };

    { _escort setVariable _x; } forEach [
        [QMVAR(_escortedUnit), nil, true]
        , [QMVAR(_isEscorting), nil, true]
    ];
};

if (_debug) then {
    ["[fn_captives_onWatchStopEscortingOne] Fini", "CAPTIVES", true] call KPLIB_fnc_common_log;
};

true;
