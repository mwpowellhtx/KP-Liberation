#include "script_component.hpp"
/*
    KPLIB_fnc_firedrill_onUpdate

    File: fn_firedrill_onUpdate.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 16:42:28
    Last Update: 2021-03-22 23:29:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _mission - a CBA MISSION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [STATUS]
 */

params [
    [Q(_mission), locationNull, [locationNull]]
];

[
    KPLIB_param_fobRange
    , +KPLIB_sectors_fobs
    , []
    , []
] params [
    Q(_range)
    , Q(_fobs)
    , Q(_players)
    , Q(_playersWithin)
];

// May be updating, or seeing it for the first time, i.e. 'allPlayers'
private _updating = toLower QPVAR(_players) in allVariables _mission;

private _allPlayers = _mission getVariable [QPVAR1(_players), allPlayers];

// Reads around disconnected players
_allPlayers = _allPlayers select { _x in allPlayers; };

// Gather up all the PLAYERS across all FOBS and their distances
private _playerDistances = [_allPlayers, {_fobs}, {
    params [
        [Q(_player), objNull, [objNull]]
        , [Q(_fob), [], [[]]]
    ];
    _fob params [
        Q(_0)
        , Q(_1)
        , Q(_2)
        , Q(_3)
        , [Q(_pos), +KPLIB_zeroPos, [[]], 3]
    ];
    [_player, _player distance2D _pos];
}] call KPLIB_fnc_linq_selectMany;

{
    _players pushBackUnique (_x#0);
} forEach (
    _playerDistances select { (_x#1) <= _range; }
);

private _toUpdate = if (_updating) then {
    [
        [QPVAR1(_players), _allPlayers]
        , [QMVAR(_playersWithin), _players]
    ];
} else {
    [
        [QMVAR(_fobs), _fobs]
        , [QPVAR1(_range), _range]
        , [QPVAR1(_players), _players]
    ];
};

{ _mission setVariable _x; } forEach _toUpdate;

true;
