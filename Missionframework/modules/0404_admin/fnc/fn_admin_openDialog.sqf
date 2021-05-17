#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_admin_openDialog

    File: fn_admin_openDialog.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-07-27
    Last Update: 2019-04-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Opens the admin menu dialog and enables/disables certain buttons if conditions for their usage aren't met.
        For example the import button, if there is no saved liberation data in the player profile.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Create admin dialog
private _ok = createDialog "KPLIB_admin";

// TODO: TBD: should go in an on-load... for the display, for the controls...
// Disable the import and delete button in the admin dialog, when there is no exported data in the players profileNamespace
if (profileNamespace getVariable [KPLIB_save_key + "_export", []] isEqualTo []) then {
    findDisplay KPLIB_IDD_ADMIN displayCtrl KPLIB_IDC_ADMIN_CTRL_IMPORTBUTTON ctrlEnable false;
    findDisplay KPLIB_IDD_ADMIN displayCtrl KPLIB_IDC_ADMIN_CTRL_DELETEBUTTON ctrlEnable false;
};

true;
