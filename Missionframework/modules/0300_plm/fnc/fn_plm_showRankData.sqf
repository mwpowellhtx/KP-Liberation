#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_plm_showRankData

    File: fn_plm_showRankData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-08-05
    Last Update: 2021-02-06 13:05:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Reads the KP Ranks data of the current player and displays it in the player menu dialog.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KPLIB_IDD_PLAYERMENU;
private _ctrlRank = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_PLAYERRANK;
private _ctrlScore = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_PLAYERSCORE;
private _ctrlPlaytime = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_PLAYERTIME;
private _ctrlNoRanks = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRLBG_NORANKS;

// Disable no ranks hint
_ctrlNoRanks ctrlShow false;

// Show data in dialog
_ctrlRank ctrlSetText ([] call KPR_fnc_getRankName);
if (KPR_levelSystem) then {
    _ctrlScore ctrlSetText str ([] call KPR_fnc_getScore);
} else {
    _ctrlScore ctrlSetText (localize "STR_KPLIB_DIALOG_PLAYER_NOLVLSYSTEM");
};
_ctrlPlaytime ctrlSetText ([] call KPR_fnc_getPlaytime);

true
