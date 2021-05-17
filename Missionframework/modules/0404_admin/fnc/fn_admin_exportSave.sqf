#inclde "..\ui\defines.hpp"
/*
    KPLIB_fnc_admin_exportSave

    File: fn_admin_exportSave.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-07-27
    Last Update: 2019-04-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Stores the current save data of the running Liberation campaign in the profile vars of the player.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

if (isServer) then {
    // If it's local hosted we can directly access the save data
    profileNamespace setVariable [KPLIB_save_key + "_export", KPLIB_save_data];
    saveProfileNamespace;

    // Hint output
    [localize "STR_KPLIB_DIALOG_ADMIN_EXP_NOTE"] call KPLIB_fnc_notification_hint;
} else {
    // Otherwise request it from the server
    KPLIB_save_data = nil;
    ["KPLIB_save_data"] remoteExecCall ["publicVariable", 2];

    // Wait until we have the data from the server, store it, show a hint and remove the hint after 3 seconds
    [
        {!isNil "KPLIB_save_data"},
        {
            profileNamespace setVariable [KPLIB_save_key + "_export", KPLIB_save_data];
            saveProfileNamespace;
            [localize "STR_KPLIB_DIALOG_ADMIN_EXP_NOTE"] call KPLIB_fnc_notification_hint;
        }
    ] call CBA_fnc_waitUntilAndExecute;
};

// Enable the import and delete button in the admin dialog
findDisplay KPLIB_IDD_ADMIN displayCtrl KPLIB_IDC_ADMIN_CTRL_IMPORTBUTTON ctrlEnable true;
findDisplay KPLIB_IDD_ADMIN displayCtrl KPLIB_IDC_ADMIN_CTRL_DELETEBUTTON ctrlEnable true;

true
