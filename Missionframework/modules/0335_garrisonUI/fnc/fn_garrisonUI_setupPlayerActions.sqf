#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_garrisonUI_setupPlayerActions

    File: fn_garrisonUI_setupPlayerActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 15:01:44
    Last Update: 2021-04-16 15:01:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets up the player actions.

    Parameters:
        NONE

    Returns:
        The callback has finished [BOOL]
 */

if (isServer) then {
    ["[fn_garrisonUI_setupPlayerActions] Entering...", "GARRISON", true] call KPLIB_fnc_common_log;
};

if (hasInterface) then {
    // Player section

    // TODO: TBD: ditto helper functions...
    private _garrisonCondition = '
        _target isEqualTo _originalTarget
            && !(KPLIB_sectors_blufor isEqualTo [])
            && ["GarrisonDialogAccess"] call KPLIB_fnc_permission_checkPermission
            && [_target, KPLIB_param_fobRange, KPLIB_sectors_fobs] call KPLIB_fnc_common_getTargetMarkerInRange
    ';

    // TODO: TBD: should really go in a proper "setup player actions" file...
    // Action to open the dialog
    private _actionArray = [
        localize "STR_KPLIB_ACTION_GARRISON_MANAGEMENT"
        , { [] call MFUNCUI(_openDialog); }
        , nil
        , KPLIB_ACTION_PRIORITY_GARRISON_MANAGEMENT
        , false
        , true
        , ""
        , _garrisonCondition
        , -1
    ];

    [_actionArray] call CBA_fnc_addPlayerAction;
};

if (isServer) then {
    ["[fn_garrisonUI_setupPlayerActions] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
