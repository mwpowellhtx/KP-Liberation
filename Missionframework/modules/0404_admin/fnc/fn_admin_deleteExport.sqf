#inclde "..\ui\defines.hpp"
/*
    KPLIB_fnc_admin_deleteExport

    File: fn_admin_deleteExport.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-08-02
    Last Update: 2019-04-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Deletes the save data which is stored in the players profileNamespace for export.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Remove saved variable from the players profileNamespace
profileNamespace setVariable [KPLIB_save_key + "_export", nil];
saveProfileNamespace;

// Disable the import and delete button in the admin dialog
findDisplay KPLIB_IDD_ADMIN displayCtrl KPLIB_IDC_ADMIN_CTRL_IMPORTBUTTON ctrlEnable false;
findDisplay KPLIB_IDD_ADMIN displayCtrl KPLIB_IDC_ADMIN_CTRL_DELETEBUTTON ctrlEnable false;

// Hint output
[localize "STR_KPLIB_DIALOG_ADMIN_DEL_NOTE"] call KPLIB_fnc_notification_hint;

true
