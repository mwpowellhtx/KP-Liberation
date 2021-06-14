#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_garrisonUI_dialogSelectUnit

    File: fn_garrisonUI_dialogSelectUnit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 14:10:19
    Last Update: 2021-06-14 17:14:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles selection of a unit in the garrison unit list.

    Parameter(s):
        _ctrl - the LISTNBOX control [CONTROL, default: controlNull]
        _selectedIndex - the selected index [NUMBER, default: -1]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_ctrl), controlNull, [controlNull]]
    , [Q(_selectedIndex), -1, [0]]
];

// Exit if no parameters passed
if (_selectedIndex isEqualTo -1) exitWith {
    false;
};

// Dialog controls
private _dialog = findDisplay KPLIB_IDD_GARRISON_DIALOG;
private _ctrlUnitButton = _dialog displayCtrl KPLIB_IDC_GARRISON_UNITBUTTON;

// Get selected unit
MVAR(_dialogSelUnit) = (MVAR(_dialogSelGroup) select 1) select _selectedIndex;

// Enable unit button
_ctrlUnitButton ctrlEnable true;

true;
