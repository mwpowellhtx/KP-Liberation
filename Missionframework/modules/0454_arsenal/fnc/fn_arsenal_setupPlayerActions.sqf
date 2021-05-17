#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_arsenal_setupPlayerActions

    File: fn_arsenal_setupPlayerActions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-14
    Last Update: 2021-02-13 07:14:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization of actions availible to players.

    Parameters:
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Actions available LOCALLY to player
private _arsenalCondition = '
    _target isEqualTo _originalTarget
      && ([_target, KPLIB_param_fobRange, KPLIB_sectors_fobs] call KPLIB_fnc_common_getTargetMarkerInRange
        || [_target, KPLIB_param_edenRange, KPLIB_sectors_edens] call KPLIB_fnc_common_getTargetMarkerInRange)
';

// Arsenal action
private _actionArray = [
    localize "STR_KPLIB_ACTION_ARSENAL"
    , {[] call KPLIB_fnc_arsenal_openDialog}
    , nil
    , KPLIB_ACTION_PRIORITY_ARSENAL
    , false
    , true
    , ""
    , _arsenalCondition
    , -1
];

[_actionArray] call CBA_fnc_addPlayerAction;

true;
