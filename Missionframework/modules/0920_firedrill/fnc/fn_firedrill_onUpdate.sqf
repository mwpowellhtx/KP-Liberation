#include "script_component.hpp"
/*
    KPLIB_fnc_firedrill_onUpdate

    File: fn_firedrill_onUpdate.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 16:42:28
    Last Update: 2021-05-17 20:35:50
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _mission - a CBA MISSION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [STATUS]
 */

private _debug = [
    [
        {MPARAM(_onUpdate_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_mission), locationNull, [locationNull]]
];

if (_debug) then {
    [format ["[fn_firedrill_onUpdate] Entering: [isNull _mission]: %1"
        , str [isNull _mission]], "FIREDRILL", true] call KPLIB_fnc_common_log;
};

[
    KPLIB_param_fobs_range
    , +KPLIB_sectors_fobs
] params [
    Q(_range)
    , Q(_fobs)
];

// May be updating, or seeing it for the first time, i.e. 'allPlayers'
private _updating = toLower QPVAR(_players) in allVariables _mission;

private _players = _mission getVariable [QPVAR1(_players), allPlayers];

// Reads around disconnected players
_players = _players select { _x in allPlayers; };

// Much smoother, which players are within range of any of the FOBs
private _playersWithin = _players select {
    private _player = _x;
    ({ (markerPos _x distance2D _player) < _range; } count _fobs) > 0;
};

private _toUpdate = if (_updating) then {
    [
        [QPVAR1(_players), _players]
        , [QMVAR(_playersWithin), _playersWithin]
    ];
} else {
    [
        [QMVAR(_fobs), _fobs]
        , [QPVAR1(_range), _range]
        , [QPVAR1(_players), _players]
        , [QMVAR(_playersWithin), _playersWithin]
    ];
};

// So that we gain the benefit of CHANGED especially for publish purposes
[_mission, _toUpdate] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    [format ["[fn_firedrill_onUpdate] Fini: [count _fobs, _range, count _players, count _playersWithin]: %1"
        , str [count _fobs, _range, count _players, count _playersWithin]], "FIREDRILL", true] call KPLIB_fnc_common_log;
};

true;
