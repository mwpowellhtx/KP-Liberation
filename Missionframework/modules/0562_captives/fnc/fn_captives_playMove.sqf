#include "script_component.hpp"
/*
    KPLIB_fnc_captives_playMove

    File: fn_captives_playMove.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-18 13:27:36
    Last Update: 2021-06-18 13:27:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Ensures that the UNIT receives the appropriate requested animations.

    Parameter(s):
        _unit - a UNIT to consider [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/playMove
        https://community.bistudio.com/wiki/playMoveNow
        https://community.bistudio.com/wiki/switchMove
        https://community.bistudio.com/wiki/Arma_3:_Moves
        https://community.bistudio.com/wiki/ArmA:_Armed_Assault:_Moves
 */

params [
    [Q(_unit), objNull, [objNull]]
];

private _debug = MPARAM(_playMove_debug)
    || (_unit getVariable [QMVAR(_playMove_debug), false])
    ;

private _surrender = _unit getVariable [Q(KPLIB_surrender), false];
private _captured = _unit getVariable [Q(KPLIB_captured), false];
private _interrogated = _unit getVariable [Q(KPLIB_interrogated), false];

if (_debug) then {
    [format ["[fn_captives_playMove] Entering: [name _unit, _surrender, _captured, _interrogated, KPLIB_ace_enabled]: %1"
        , str [name _unit, _surrender, _captured, _interrogated, KPLIB_ace_enabled]], "CAPTIVES", true] call KPLIB_fnc_common_log;
};

// // ACE handles all of this for us
// if (KPLIB_ace_enabled) exitWith {
//     false;
// };

// TODO: TBD: ACE uses animation handlers (?)
// https://github.com/acemod/ACE3/blob/master/addons/captives/functions/fnc_setSurrendered.sqf
// In reverse order of the captives progression

// https://github.com/KillahPotatoes/KP-Liberation/blob/696c395f68987762d34928371c2cf8ec3a5b50d8/Missionframework/scripts/client/civinformant/civinfo_escort.sqf
// https://github.com/KillahPotatoes/KP-Liberation/blob/696c395f68987762d34928371c2cf8ec3a5b50d8/Missionframework/scripts/client/remotecall/remote_call_prisonner.sqf
private _allPredicatedMoves = [
    [_interrogated, {
        _this playMove "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon_ground";
        _this switchMove "AidlPsitMstpSnonWnonDnon_ground00";
    }]
    , [_captured && !KPLIB_ace_enabled, {
        _this playMoveNow "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";
        _this playMove "AmovPercMstpSnonWnonDnon_EaseIn";
    }]
    , [_surrender && !KPLIB_ace_enabled, {
        _this playMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
    }]
    , [!KPLIB_ace_enabled, {
        _this playMove "AmovPlieMstpSnonWnonDnon";
        _this setBehaviour "CARELESS";
    }]
];

private _predicatedMoves = _allPredicatedMoves select {
    _x params [
        [Q(_condition), false, [false]]
    ];
    _condition;
};

_predicatedMoves params [
    [Q(_predicatedMove), [], [[]]]
];

_predicatedMove params [
    Q(_condition)
    , [Q(_callback), {}, [{}]]
];

_unit disableAI "ANIM";
_unit disableAI "MOVE";

// TODO: TBD: case sensitive?
_unit setUnitPos "UP";

_unit call _callback;

if (_debug) then {
    ["[fn_captives_playMove] Fini", "CAPTIVES", true] call KPLIB_fnc_common_log;
};

true;
