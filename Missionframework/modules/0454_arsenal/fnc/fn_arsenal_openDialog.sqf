#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_arsenal_openDIalog

    File: fn_arsenal_openDialog.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-11-14
    Last Update: 2019-05-04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Opens the arsenal dialog and enables/disables certain buttons if conditions for their usage aren't met.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Create dialog
createDialog "KPLIB_arsenal";
disableSerialization;

// Dialog controls
private _dialog = findDisplay KPLIB_IDC_ARSENAL_DIALOG;
private _ctrlLoadoutList = _dialog displayCtrl KPLIB_IDC_ARSENAL_LOADOUTLIST;
private _ctrlNearPlayer = _dialog displayCtrl KPLIB_IDC_ARSENAL_COMBONEAR;

// Get the default loadout name from player profile
private _loadout = profileNamespace getVariable ["KPLIB_defaultLoadout", ""];

// Get Loadout names
private _loadouts = profileNamespace getVariable ["bis_fnc_saveInventory_data", []];
private _loadoutNames = [];

if (_loadouts isEqualTo []) then {
    _loadoutNames pushback "----------";
} else {
    {
        if (_x isEqualType "") then {
            _loadoutNames pushBack _x;
        };
    } forEach _loadouts;
    _loadoutNames sort true;
};

private _index = 0;

// Fill controls
{
    _index = _ctrlLoadoutList lbAdd _x;
    if (_x isEqualTo _loadout) then {
        _ctrlLoadoutList lbSetCurSel _index;
    };
} forEach _loadoutNames;

[] call KPLIB_fnc_arsenal_getNearPlayers;

true
