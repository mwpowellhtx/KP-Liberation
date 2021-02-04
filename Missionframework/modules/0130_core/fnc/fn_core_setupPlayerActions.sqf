#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_common_setupPlayerActions

    File: fn_common_setupPlayerActions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-28
    Last Update: 2021-01-26 12:01:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization of actions availible to players.

    Parameters:
        NONE

    Returns:
        Function reached the end [BOOL]
*/

//private _dep = [
//    "KPLIB_sectorType_eden"
//    , "KPLIB_sectorType_fob"
//];

//waitUntil {
//    _dep = _dep select {isNil _x};
//    _dep isEqualTo [];
//};

// Actions avalible LOCALLY to player
if (hasInterface) then {

    // TODO: TBD: condition was: _target isEqualTo _originalTarget && !(_originalTarget getVariable ["KPLIB_fob", ""] isEqualTo "")
    // TODO: TBD: also needing helper functions to filter on the fields...
    private _fobRedeployCondition = '
        _target isEqualTo _originalTarget
        && ([_originalTarget, {_this#1}] call KPLIB_fnc_common_getSectorInfo) in [KPLIB_sectorType_eden, KPLIB_sectorType_fob]
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

true
