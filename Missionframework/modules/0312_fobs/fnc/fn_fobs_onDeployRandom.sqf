#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_onDeployRandom

    File: fn_fobs_onDeployRandom.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-11
    Last Update: 2021-05-18 22:01:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Functionality to place the FOB box at a random spawn point and trigger the FOB buildings placement to establish a random FOB at start.

    Parameter(s):
        _boxOrTruck - an FOB BOX or TRUCK target of the action [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

// TODO: TBD: refactor into the FOBS module...
params [
    [Q(_boxOrTruck), objNull, [objNull]]
    , [Q(_player), objNull, [objNull]]
];

private _markerName = [] call KPLIB_fnc_common_getRandomSpawnMarker;

if (_markerName isEqualTo "") exitWith {
    [
        "KPLIB_notification_blufor"
        , [
            "KP LIBERATION - FOB"
            , MPRESET(_markerPath)
            , localize "STR_KPLIB_NOTIFICATION_FOBS_DEPLOY_RANDOM_FAILED"
        ]
    ] call KPLIB_fnc_notification_show
};

private _markerPos = markerPos _markerName;

// Disable damage handling and simulation
_boxOrTruck allowDamage false;
_boxOrTruck enableSimulationGlobal false;

// Set the vehicle to the position where it should be
_boxOrTruck setPosATL [_markerPos#0, _markerPos#1, 0.25];

// Activate the simulation again
_boxOrTruck enableSimulationGlobal true;
_boxOrTruck setDamage 0;
_boxOrTruck allowDamage true;

// Set the FOB BOX or TRUNK here same as during the direct request
_player setVariable [QMVAR(_boxOrTruck), _boxOrTruck];

// Then handoff the relay to the normal DEPLOY REQUESTED event handler
[_boxOrTrunk, _player] call MFUNC(_onDeployRequested);
