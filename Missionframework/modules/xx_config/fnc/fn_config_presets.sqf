/*
    KPLIB_fnc_config_presets

    File: fn_config_presets.sqf
    Author: Michael W. Powell [22nd MEU SOD]
    Created: 2021-01-28 15:24:28
    Last Update: 2021-01-28 15:24:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initializes some preset settings.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// All preset variable names as collection for processing
KPLIB_preset_allVariables = [];
// Civilian side color
KPLIB_preset_colorC = "ColorCIV";
// Civilian side color (active)
KPLIB_preset_colorActC = "ColorPink";
// Enemy side color
KPLIB_preset_colorE = "ColorEAST";
// Enemy side color (active)
KPLIB_preset_colorActE = "ColorRed";
// Friendly side color
KPLIB_preset_colorF = "ColorWEST";
// Friendly side color (active)
KPLIB_preset_colorActF = "ColorBlue";
// Resistance side color
KPLIB_preset_colorR = "ColorGUER";
// Resistance side color (active)
KPLIB_preset_colorActR = "ColorGreen";
// Civilian side
KPLIB_preset_sideC = civilian;
// Enemy side
KPLIB_preset_sideE = east;
// Player side
KPLIB_preset_sideF = west;
// Resistance side
KPLIB_preset_sideR = resistance;

true
