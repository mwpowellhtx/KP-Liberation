#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_plm_openDialog

    File: fn_plm_openDialog.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-08-03
    Last Update: 2019-04-23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Opens the player menu dialog.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Create player options dialog
createDialog "KP_playerMenu";
disableSerialization;

// Dialog controls
private _dialog = findDisplay KPLIB_IDD_PLAYERMENU;
private _ctrlLabelRank = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRLBG_TEXTRANK;
private _ctrlRank = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_PLAYERRANK;
private _ctrlLabelScore = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRLBG_TEXTSCORE;
private _ctrlScore = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_PLAYERSCORE;
private _ctrlLabelPlaytime = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRLBG_PLAYTIME;
private _ctrlPlaytime = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_PLAYERTIME;
private _ctrlNoRanks = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRLBG_NORANKS;
private _ctrlGroupList = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_GROUPLIST;
private _ctrlViewFoot = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_BOXVIEWFOOT;
private _ctrlViewVic = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_BOXVIEWVIC;
private _ctrlViewAir = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_BOXVIEWAIR;
private _ctrlTerrain = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_COMBOTERRAIN;
private _ctrlTpv = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_COMBOTPV;
private _ctrlRadio = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_COMBORADIO;
private _ctrlValueSound = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_TEXTSOUNDVAL;
private _ctrlSliderSound = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_SLIDERSOUND;

// Display KP Ranks data or hide the player menu entries for the data
if (KPLIB_kpr_enabled) then {
    [] call KPLIB_fnc_plm_showRankData;
} else {
    {
        _x ctrlShow false;
    } forEach [_ctrlLabelRank, _ctrlRank, _ctrlLabelScore, _ctrlScore, _ctrlLabelPlaytime, _ctrlPlaytime];
};

// Fill group list with all groups leaded by players
{
    if (player in units _x) then {
        _ctrlGroupList lbSetCurSel (_ctrlGroupList lbAdd format [">> %1 - %2 (%3)", groupId _x, name leader _x, count units _x]);
    } else {
        _ctrlGroupList lbAdd format ["%1 - %2 (%3)", groupId _x, name leader _x, count units _x];
    };

} forEach KPLIB_plm_groups;

// Set initial values for view distances
_ctrlViewFoot ctrlSetText str KPLIB_plm_viewFoot;
_ctrlViewVic ctrlSetText str KPLIB_plm_viewVeh;
_ctrlViewAir ctrlSetText str KPLIB_plm_viewAir;

// Fill density, auto tpv and radio dropdowns. Also preselect the saved values
_ctrlTerrain lbAdd localize "STR_KPLIB_DIALOG_PLAYER_TERRAINLOW"; // 50
_ctrlTerrain lbAdd localize "STR_KPLIB_DIALOG_PLAYER_TERRAINSTANDARD"; // 25
_ctrlTerrain lbAdd localize "STR_KPLIB_DIALOG_PLAYER_TERRAINHIGH"; // 12.5
_ctrlTerrain lbAdd localize "STR_KPLIB_DIALOG_PLAYER_TERRAINVHIGH"; // 6.25
_ctrlTerrain lbAdd localize "STR_KPLIB_DIALOG_PLAYER_TERRAINULTRA"; // 3.125
_ctrlTerrain lbSetCurSel KPLIB_plm_terrain;

_ctrlTpv lbAdd localize "STR_KPLIB_DISABLED";
_ctrlTpv lbAdd localize "STR_KPLIB_DIALOG_PLAYER_TPVAIR";
_ctrlTpv lbAdd localize "STR_KPLIB_DIALOG_PLAYER_TPVLAND";
_ctrlTpv lbAdd localize "STR_KPLIB_DIALOG_PLAYER_TPVALL";
_ctrlTpv lbSetCurSel KPLIB_plm_tpv;

_ctrlRadio lbAdd localize "STR_KPLIB_NO";
_ctrlRadio lbAdd localize "STR_KPLIB_DIALOG_PLAYER_RADIOVOICE";
_ctrlRadio lbAdd localize "STR_KPLIB_DIALOG_PLAYER_RADIOALL";
_ctrlRadio lbSetCurSel KPLIB_plm_radio;

// Initialize sound slider range, position and speed
_ctrlSliderSound sliderSetRange [0, 100];
_ctrlSliderSound sliderSetPosition (KPLIB_plm_soundVeh * 100);
_ctrlSliderSound sliderSetSpeed [1, 1];

// Set sound value output to initial sound slider value
_ctrlValueSound ctrlSetText format ["%1%2", round sliderPosition _ctrlSliderSound, "%"];

true
