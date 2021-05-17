#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_setDefaultLoadout

    File: fn_arsenal_setDefaultLoadout.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-11-22
    Last Update: 2019-05-04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Stores the selected loadout as default loadout.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KPLIB_IDC_ARSENAL_DIALOG;
private _ctrlLoadoutList = _dialog displayCtrl KPLIB_IDC_ARSENAL_LOADOUTLIST;

// Get the selected loadout name
private _index = lbCurSel _ctrlLoadoutList;
private _loadout = _ctrlLoadoutList lbText _index;

// Save the default loadout name to player profile
if !(_loadout isEqualTo "----------") then {
    profileNamespace setVariable ["KPLIB_defaultLoadout", _loadout];
    saveprofilenamespace;
};

true
