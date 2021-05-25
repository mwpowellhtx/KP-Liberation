#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_build_setupPlayerActions

    File: fn_build_setupPlayerActions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-07-01
    Last Update: 2021-05-24 10:15:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initializes module actions available to the PLAYER.

    Parameters:
        _player - a PLAYER object about which to setup [OBJECT, default: objNull]

    Returns:
        The callback has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_addPlayerAction-sqf.html
 */

[
    [
        "STR_KPLIB_ACTION_BUILD"
        , {
            private _markerName = [] call KPLIB_fnc_common_getPlayerFob;
            [(getMarkerPos _markerName), KPLIB_param_fobs_range] call KPLIB_fnc_build_start;
        }
        , []
        , KPLIB_ACTION_PRIORITY_BUILD
        , false
        , true
        , ""
        , "
            _target isEqualTo vehicle _target
                && _target isEqualTo _originalTarget
                && ['Build'] call KPLIB_fnc_permission_checkPermission
                && (_target getVariable ['KPLIB_sectors_markerName', '']) in KPLIB_sectors_fobs
        "
        , -1
    ]
    , [["_varName", "KPLIB_build_buildID"]]
] call KPLIB_fnc_common_addPlayerAction;

true;
