#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_fobs_setupRespawnActions

    File: fn_fobs_setupRespawnActions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-28
    Last Update: 2021-05-25 10:50:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameters:
        _object - the OBJECT receiving the actions [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_addPlayerAction-sqf.html
        https://community.bistudio.com/wiki/addAction
 */

params [
    [Q(_object), objNull, [objNull]]
];

[
    _object
    , [
        "STR_KPLIB_ACTION_REDEPLOY"
        , { [Q(KPLIB_respawn_requested), _this] call CBA_fnc_localEvent; }
        , []
        , KPLIB_ACTION_PRIORITY_REDEPLOY
        , false
        , true
        , ""
        , "
            _this isEqualTo vehicle _this
                && !([KPLIB_sectors_startbases, { (markerPos _x distance _target) <= KPLIB_param_eden_startbaseRadius; }] call KPLIB_fnc_linq_any)
                && !isNull ([_target, KPLIB_param_fobs_range] call KPLIB_fnc_fobs_getNearestBuilding)
                && ([_target] call KPLIB_fnc_common_getMomentum) <= 5
                && ([_target] call KPLIB_fnc_common_getAltitudeDelta) <= 5
        "
        , 10
    ]
    , [["_varName", QMVAR(_redeployID)]]
] call KPLIB_fnc_common_addAction;

true;
