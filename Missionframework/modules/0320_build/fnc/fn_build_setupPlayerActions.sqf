#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_build_setupPlayerActions

    File: fn_build_setupPlayerActions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-07-01
    Last Update: 2021-02-15 10:02:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization of actions availible to players.

    Parameters:
        NONE

    Returns:
        Actions were set up [BOOL]
*/

// Actions available LOCALLY to player
if (hasInterface) then {

    // TODO: TBD: ditto helper functions...
    // We can know more specifically the _sectorType, so just do it.
    private _fobBuildCondition = '
        _target == _originalTarget
          && ["Build"] call KPLIB_fnc_permission_checkPermission
          && [_target, KPLIB_param_fobRange, KPLIB_sectors_fobs] call KPLIB_fnc_common_getTargetMarkerInRange
    ';

    private _onFobBuildCallback = {
        // Learn to love working with the marker names...
        private _markerName = [] call KPLIB_fnc_common_getPlayerFob;
        [(getMarkerPos _markerName), KPLIB_param_fobRange] call KPLIB_fnc_build_start;
    };

    // Build actions
    private _fobBuildAction = [
        localize "STR_KPLIB_ACTION_BUILD"
        , _onFobBuildCallback
        , nil
        , KPLIB_ACTION_PRIORITY_BUILD
        , false
        , true
        , ""
        , _fobBuildCondition
        , -1
    ];

    [_fobBuildAction] call CBA_fnc_addPlayerAction;

    private _buildStorageArgs = [
        localize "STR_KPLIB_ACTION_BUILD_STORAGE"
        , {[(_this#0)] call KPLIB_fnc_buildClient_onBuildStorageClicked;}
        , nil
        , KPLIB_ACTION_PRIORITY_BUILD_STORAGE
        , false
        , true
        , ""
        , '
            [_target] call KPLIB_fnc_build_canBuildStorage
        '
        , -1
    ];

    [_buildStorageArgs] call CBA_fnc_addPlayerAction;
};

true;
