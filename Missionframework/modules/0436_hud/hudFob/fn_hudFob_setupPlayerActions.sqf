#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_hudFob_setupPlayerActions

    File: fn_hudFob_setupPlayerActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-26 19:00:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets up the FOB HUD PLAYER actions.

    Parameters:
        NONE

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_addPlayerAction-sqf.html
        https://community.bistudio.com/wiki/addAction
        https://community.bistudio.com/wiki/setUserActionText
 */

// Default view is FOB, i.e. we then 'TOGGLE TO ALL' resources
[[
    "STR_KPLIB_HUD_ACTION_MENU_VIEW_ALL_RESOURCES"
    , {
        params [
            Q(_target)
            , Q(_caller)
            , Q(_actionId)
            , Q(_args)
        ];

        private _reportAllResources = _target getVariable [QMVAR(_reportAllResources), false];

        private _text = localize (if (_reportAllResources) then {
            "STR_KPLIB_HUD_ACTION_MENU_VIEW_ALL_RESOURCES";
        } else {
            "STR_KPLIB_HUD_ACTION_MENU_VIEW_FOB_RESOURCES";
        });

        // 'Toggle' by (re-)setting the user action text accordingly
        _target setUserActionText [_actionId, _text];

        // Then (re-)set the variable, must publish this everywhere, but for SERVER especially to see it
        _target setVariable [QMVAR(_reportAllResources), !_reportAllResources, true];
        //                        This is how we toggle: ^^^^^^^^^^^^^^^^^^^^
        //                 But this is critical as well:                       ^^^^
    }
    , []
    , KPLIB_ACTION_PRIORITY_REPORT_RESOURCES
    , false
    , true
    , ""
    , "
        (_target getVariable ['KPLIB_sectors_markerName', '']) in KPLIB_sectors_fobs
    "
    , -1
]] call KPLIB_fnc_common_addPlayerAction;

true;
