/*
    KPLIB_fnc_build_setupPlayerActions

    File: fn_build_setupPlayerActions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-07-01
    Last Update: 2021-01-27 22:37:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization of actions availible to players.

    Parameters:
        NONE

    Returns:
        Actions were set up [BOOL]
*/

// Actions avalible LOCALLY to player
if (hasInterface) then {

    //// TODO: TBD: baseline was this:
    // (_target == _originalTarget)
    // && !(_originalTarget getVariable ["KPLIB_fob", ""] in ["", "KPLIB_eden_startbase_marker"])
    // && (["Build"] call KPLIB_fnc_permission_checkPermission)

    // TODO: TBD: ditto helper functions...
    // We can know more specifically the _sectorType, so just do it.
    private _buildCondition = '
        _target == _originalTarget
        && ([_originalTarget, {_this#2}] call KPLIB_fnc_common_getSectorInfo) in [KPLIB_sectorType_fob]
        && ["Build"] call KPLIB_fnc_permission_checkPermission
    ';

    private _onPlayerBuild = {
        // Learn to love working with the marker names...
        private _markerName = [] call KPLIB_fnc_common_getPlayerFob;
        private _markerPos = getMarkerPos _markerName;
        [_markerPos, KPLIB_param_fobRange] call KPLIB_fnc_build_start;
    };

    // Build actions
    private _actionArray = [
        localize "STR_KPLIB_ACTION_BUILD"
        , _onPlayerBuild
        , nil
        , -802
        , false
        , true
        , ""
        , _buildCondition
        , 10
    ];

    [_actionArray] call CBA_fnc_addPlayerAction;
};

true
