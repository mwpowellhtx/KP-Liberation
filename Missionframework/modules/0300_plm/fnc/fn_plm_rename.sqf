#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_plm_rename

    File: fn_plm_rename.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-08-05
    Last Update: 2019-04-23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
    Set the new name for the group which is selected in the group list.

    Parameter(s):
    NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KPLIB_IDD_PLAYERMENU;
private _ctrlGroupList = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_GROUPLIST;
private _ctrlEditName = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_RENAMEEDIT;
private _grp = KPLIB_plm_groups select (lbCurSel _ctrlGroupList);

// Only allow change, when player is leader
if (leader _grp == player) then {
    _grp setGroupIdGlobal [ctrlText _ctrlEditName];

    // Refresh Dialog
    closeDialog 0;
    [{!dialog}, {call KPLIB_fnc_plm_openDialog;}] call CBA_fnc_waitUntilAndExecute;
} else {
    [localize "STR_KPLIB_DIALOG_PLAYER_NOTLEADER_NOTE"] call KPLIB_fnc_notification_hint;
};

true
