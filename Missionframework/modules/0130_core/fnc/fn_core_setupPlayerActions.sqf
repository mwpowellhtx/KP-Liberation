#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_common_setupPlayerActions

    File: fn_common_setupPlayerActions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-28
    Last Update: 2021-02-13 07:12:48
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
if (hasInterface) then {

    private _fobRedeployCondition = '
        _target isEqualTo _originalTarget
          && ([_target, KPLIB_param_fobRange, KPLIB_sectors_fobs] call KPLIB_fnc_common_getTargetMarkerInRange
            || [_target, KPLIB_param_edenRange, KPLIB_sectors_edens] call KPLIB_fnc_common_getTargetMarkerInRange)
    ';

    // FOB redeploy action
    private _actionArray = [
        localize "STR_KPLIB_ACTION_REDEPLOY"
        , {["KPLIB_respawn_requested", _this] call CBA_fnc_localEvent}
        , nil
        , KPLIB_ACTION_PRIORITY_REDEPLOY
        , false
        , true
        , ""
        , _fobRedeployCondition
        , -1
    ];

    [_actionArray] call CBA_fnc_addPlayerAction;
};

true;
