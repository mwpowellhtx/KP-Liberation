#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_mission_setupPlayerActions

    File: fn_mission_setupPlayerActions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-06-23
    Last Update: 2019-06-23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization of actions available to players.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Actions available LOCALLY to player
// Permission action
private _missionCondition = '
    _target isEqualTo _originalTarget &&
    (
        serverCommandAvailable "#kick" ||
        {["Mission"] call KPLIB_fnc_permission_checkPermission}
    )
';

private _actionArray = [
    localize "STR_KPLIB_ACTION_MISSIONS"
    , {[] call KPLIB_fnc_mission_openDialog}
    , nil
    , KPLIB_ACTION_PRIORITY_MISSIONS
    , false
    , true
    , ""
    , _missionCondition
    , -1
];

[_actionArray] call CBA_fnc_addPlayerAction;

true
