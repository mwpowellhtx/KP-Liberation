#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_onPlayerRedeployed

    File: fn_ieds_onPlayerRedeployed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-07 12:38:15
    Last Update: 2021-05-07 12:38:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles IED related tasks on PLAYER REDEPLOY events.

    Parameter(s):
        _player - the PLAYER object who respawned [OBJECT, default: objNull]
        _respawnPos - 
        _loadout - 

    Returns:
        The event handler completed [BOOL]
 */

private _debug = MPARAM(_onPlayerRedeploy_debug);

params [
    [Q(_player), objNull, [objNull]]
];

[{ alive _this; }, { [_this] call MFUNC(_setupPlayerActions); }, _player] call CBA_fnc_waitUntilAndExecute;

true;
