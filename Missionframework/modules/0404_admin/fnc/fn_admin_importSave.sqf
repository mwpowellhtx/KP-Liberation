/*
    KPLIB_fnc_admin_importSave

    File: fn_admin_importSave.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-07-27
    Last Update: 2019-04-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Imports the stored save data of a running Liberation campaign from the profile vars of the player.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

if (isServer) then {
    // If it's local hosted we can directly import the save data
    [profileNamespace getVariable [KPLIB_save_key + "_export", nil]] call KPLIB_fnc_admin_importSaveServer;
} else {
    // Otherwise send data for import to the server
    [profileNamespace getVariable [KPLIB_save_key + "_export", nil]] remoteExecCall ["KPLIB_fnc_admin_importSaveServer", 2];
};

[localize "STR_KPLIB_DIALOG_ADMIN_IMP_NOTE"] call KPLIB_fnc_notification_hint;

true
