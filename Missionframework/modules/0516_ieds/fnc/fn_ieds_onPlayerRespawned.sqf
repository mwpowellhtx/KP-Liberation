#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_onPlayerRespawned

    File: fn_ieds_onPlayerRespawned.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-07 11:53:15
    Last Update: 2021-05-07 11:53:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles IED related tasks on PLAYER RESPAWN events.

    Parameter(s):
        _player - the PLAYER object who respawned [OBJECT, default: objNull]
        _corpse - the CORPSE object who respawned [OBJECT, default: objNull]

    Returns:
        The event handler completed [BOOL]
 */

private _debug = MPARAM(_onPlayerRespawn_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_corpse), objNull, [objNull]]
];

[_player] call MFUNC(_setupPlayerActions);

true;
