#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_getNearPlayers

    File: fn_arsenal_getNearPlayers.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-11-18
    Last Update: 2019-05-04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Lists all near players in a predefined radius.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

disableSerialization;

// Dialog controls
private _dialog = findDisplay KPLIB_IDC_ARSENAL_DIALOG;
private _ctrlNearPlayer = _dialog displayCtrl KPLIB_IDC_ARSENAL_COMBONEAR;

// Clear controls
lbClear _ctrlNearPlayer;

private _index = 0;

{
    if !(_x isEqualTo player) then {
        _index = _ctrlNearPlayer lbAdd (name _x);
        _ctrlNearPlayer lbSetData [_index, [_x] call BIS_fnc_objectVar];
    };
} forEach (allPlayers select {(_x distance2D player) < KPLIB_param_copyDistance});

true
