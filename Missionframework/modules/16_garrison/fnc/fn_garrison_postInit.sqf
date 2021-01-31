/*
    KPLIB_fnc_garrison_postInit

    File: fn_garrison_postInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Created: 2018-10-18
    Last Update: 2021-01-27 23:04:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The postInit function of a module takes care of starting/executing the modules functions or scripts.
        Basically it starts/initializes the module functionality to make all provided features usable.

    Parameters:
        NONE

    Returns:
        Module postInit finished [BOOL]
*/

if (isServer) then {
    ["Module initializing...", "POST] [GARRISON", true] call KPLIB_fnc_common_log;
};

// Server section
if (isServer) then {
    // Add Garrison Dialog access permission
    [
        "GarrisonDialogAccess",
        {}
    ] call KPLIB_fnc_permission_addPermissionHandler;
};

// Player section
if (hasInterface) then {

    //// TODO: TBD: was this...
    //private _garrisonCondition = '
    //    _target isEqualTo _originalTarget &&
    //    !(_originalTarget getVariable ["KPLIB_fob", ""] isEqualTo "") &&
    //    !(KPLIB_sectors_blufor isEqualTo []) &&
    //    ["GarrisonDialogAccess"] call KPLIB_fnc_permission_checkPermission
    //';

    // TODO: TBD: ditto helper functions...
    private _garrisonCondition = '
        _target isEqualTo _originalTarget
        && ([_originalTarget, {_this#2}] call KPLIB_fnc_common_getSectorInfo) in [KPLIB_sectorType_fob]
        && !(KPLIB_sectors_blufor isEqualTo [])
        && ["GarrisonDialogAccess"] call KPLIB_fnc_permission_checkPermission
    ';

    // Action to open the dialog
    private _actionArray = [
        localize "STR_KPLIB_ACTION_GARRISON_MENU"
        , {[] call KPLIB_fnc_garrison_openDialog;}
        , nil
        , -800
        , false
        , true
        , ""
        , _garrisonCondition
    ];
    [_actionArray] call CBA_fnc_addPlayerAction;
};

if (isServer) then {
    ["Module initialized", "POST] [GARRISON", true] call KPLIB_fnc_common_log;
};

true
