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

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_addPlayerAction-sqf.html
        https://community.bistudio.com/wiki/addAction
 */

// Actions available LOCALLY to player
if (hasInterface) then {

    // Redeploy player action
    [] call {
        private _condition = '
            _target isEqualTo _originalTarget
            && ([_target, KPLIB_param_fobs_range, KPLIB_sectors_fobs] call KPLIB_fnc_common_getTargetMarkerInRange
                || [_target, KPLIB_param_edenRange, KPLIB_sectors_edens] call KPLIB_fnc_common_getTargetMarkerInRange)
        ';

        private _args = [
            localize "STR_KPLIB_ACTION_REDEPLOY"
            , {["KPLIB_respawn_requested", _this] call CBA_fnc_localEvent}
            , nil
            , KPLIB_ACTION_PRIORITY_REDEPLOY
            , false
            , true
            , ""
            , _condition
            , -1
        ];

        [_args] call CBA_fnc_addPlayerAction;
    };

    {
        // Repackage FOB player actions
        _x call {
            params [
                ["_key", "", [""]]
                , ["_args", [], [[]]]
                , ["_priority", -1, [0]]
            ];

            // TODO: TBD: also consider permissions, commander? logistics? build?
            private _condition = '
                _target isEqualTo _originalTarget
                    && !("" isEqualTo ([] call KPLIB_fnc_common_getPlayerFob))
            ';

            private _args = [
                localize _key
                , { _this call KPLIB_fnc_core_onRepackageFob; }
                , _args
                , _priority
                , false
                , true
                , ""
                , _condition
                , -1
            ];

            [_args] call CBA_fnc_addPlayerAction;
        };

    } forEach [
        [
            "STR_KPLIB_ACTION_REPACKAGE_FOB_BOX"
            , [KPLIB_preset_fobBoxF]
            , KPLIB_ACTION_PRIORITY_REPACKAGE_FOB_BOX
        ]
        , [
            "STR_KPLIB_ACTION_REPACKAGE_FOB_TRUCK"
            , [KPLIB_preset_fobTruckF]
            , KPLIB_ACTION_PRIORITY_REPACKAGE_FOB_TRUCK
        ]
    ];
};

true;
