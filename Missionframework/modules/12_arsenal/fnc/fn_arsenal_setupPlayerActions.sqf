/*
    KPLIB_fnc_arsenal_setupPlayerActions

    File: fn_arsenal_setupPlayerActions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-14
    Last Update: 2021-01-27 10:51:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization of actions availible to players.

    Parameters:
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Actions avalible LOCALLY to player

// TODO: TBD: ditto helper functions...
// TODO: TBD: condition was: _target isEqualTo _originalTarget && !(_originalTarget getVariable ["KPLIB_fob", ""] isEqualTo "")
// TODO: TBD: might also make some sense for ARSENAL to be available from mobile respawn, or at least optionally
private _arsenalCondition = '
    _target isEqualTo _originalTarget
    && ([_originalTarget, {_this#2}] call KPLIB_fnc_common_getSectorInfo) in [KPLIB_sectorType_eden, KPLIB_sectorType_fob]
';

// Arsenal action
private _actionArray = [
    localize "STR_KPLIB_ACTION_ARSENAL"
    , {[] call KPLIB_fnc_arsenal_openDialog}
    , nil
    , -801
    , false
    , true
    , ""
    , _arsenalCondition
    , 10
];

[_actionArray] call CBA_fnc_addPlayerAction;

true
