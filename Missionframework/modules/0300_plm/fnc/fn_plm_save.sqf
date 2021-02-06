#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_plm_save

    File: fn_plm_save.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-08-05
    Last Update: 2019-04-23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Saves the selected settings from the player menu dialog and calls the apply function.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KPLIB_IDD_PLAYERMENU;
private _ctrlViewFoot = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_BOXVIEWFOOT;
private _ctrlViewVic = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_BOXVIEWVIC;
private _ctrlViewAir = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_BOXVIEWAIR;
private _ctrlTerrain = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_COMBOTERRAIN;
private _ctrlTpv = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_COMBOTPV;
private _ctrlRadio = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_COMBORADIO;
private _ctrlSliderSound = _dialog displayCtrl KPLIB_IDC_PLAYERMENU_CTRL_SLIDERSOUND;

// Fetch all selected values
KPLIB_plm_viewFoot = round (parseNumber (ctrlText _ctrlViewFoot));
if (KPLIB_plm_viewFoot == 0) then {KPLIB_plm_viewFoot = 1600;};
KPLIB_plm_viewVeh = round (parseNumber (ctrlText _ctrlViewVic));
if (KPLIB_plm_viewVeh == 0) then {KPLIB_plm_viewVeh = 1600;};
KPLIB_plm_viewAir = round (parseNumber (ctrlText _ctrlViewAir));
if (KPLIB_plm_viewAir == 0) then {KPLIB_plm_viewAir = 1600;};
KPLIB_plm_terrain = lbCurSel _ctrlTerrain;
KPLIB_plm_tpv = lbCurSel _ctrlTpv;
KPLIB_plm_radio = lbCurSel _ctrlRadio;
KPLIB_plm_soundVeh = (round sliderPosition _ctrlSliderSound) / 100;

// Save settings in user profile
profileNamespace setVariable ["KPPLM_Settings", [KPLIB_plm_viewFoot, KPLIB_plm_viewVeh, KPLIB_plm_viewAir, KPLIB_plm_terrain, KPLIB_plm_tpv, KPLIB_plm_radio, KPLIB_plm_soundVeh]];
saveProfileNamespace;

// Apply settings
[] call KPLIB_fnc_plm_apply;

// Close the dialog
closeDialog 0;

true
