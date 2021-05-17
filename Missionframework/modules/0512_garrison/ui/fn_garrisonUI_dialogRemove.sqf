#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_garrisonUI_dialogRemove

    File: fn_garrisonUI_dialogRemove.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 14:23:30
    Last Update: 2021-04-16 14:23:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Spawns infantry/vehicle and removes it from garrison array.

    Parameter(s):
        _ctrl - the button control [CONTROL, defaults: controlNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_ctrl), controlNull, [controlNull]]
];

if (isNull _ctrl) exitWith {
    false;
};

// Dialog controls
private _dialog = findDisplay KPLIB_IDD_GARRISON_DIALOG;
private _ctrlLbSectors = _dialog displayCtrl KPLIB_IDC_GARRISON_GARRISONLIST;
private _ctrlInfBox = _dialog displayCtrl KPLIB_IDC_GARRISON_INFANTRYBOX;
private _ctrlInfButton = _dialog displayCtrl KPLIB_IDC_GARRISON_INFANTRYBUTTON;
private _ctrlLightList = _dialog displayCtrl KPLIB_IDC_GARRISON_LIGHTLIST;
private _ctrlLightButton = _dialog displayCtrl KPLIB_IDC_GARRISON_LIGHTBUTTON;
private _ctrlHeavyList = _dialog displayCtrl KPLIB_IDC_GARRISON_HEAVYLIST;
private _ctrlHeavyButton = _dialog displayCtrl KPLIB_IDC_GARRISON_HEAVYBUTTON;

// Initialize needed local variables
private _sector = _ctrlLbSectors lbData (lbCurSel _ctrlLbSectors);
private _sectorPos = [_sector] call KPLIB_fnc_common_getPos;
// TODO: TBD: ditto client/server
private _garrison = [_sector] call MFUNC(_getGarrison);
private _side = KPLIB_preset_sideF;

// Prevent button spam
_ctrl ctrlEnable false;

// Handle Infantry
if (_ctrl isEqualTo _ctrlInfButton) exitWith {

    // Get amount of soldiers
    private _amount = parseNumber (ctrlText _ctrlInfBox);

    // Only continue, if the amount of infantry is available
    if ((_garrison select 2) >= _amount) then {
        // Request server to adjust the garrison infantry amount
        [_sector, -_amount] remoteExecCall [QMFUNC(_addInfantry), 2];

        // Get array of soldier classnames
        private _soldierArray = [_side] call KPLIB_fnc_common_getSoldierArray;
        private _squads = [];

        // Prepare infantry squads for spawning
        while {_amount > 0} do {
            private _currentSoldiers = _amount min 6;
            private _classnames = [];
            for "_i" from 1 to _currentSoldiers do {
                _classnames pushBack (selectRandom _soldierArray);
            };
            _squads pushBack _classnames;
            _amount = _amount - _currentSoldiers;
        };

        // Schedule spawning
        {
            private _spawnPos = [_sectorPos] call MFUNC(_getVehSpawnPos);
            [{ _this call KPLIB_fnc_common_createGroup; }, [_x, _spawnPos, _side], _forEachIndex] call CBA_fnc_waitAndExecute;
        } forEach _squads;

        // Reload sector details after a small sync delay
        [{ _this call MFUNC(_dialogSelectSector); }, [lbCurSel _ctrlLbSectors], 2] call CBA_fnc_waitAndExecute;
        true;

    } else {

        // Notify player that there are not enough infantry units at the sector
        [localize "STR_KPLIB_HINT_NOTATGARRISON"] call KPLIB_fnc_notification_hint;
        _ctrlInfButton ctrlEnable true;
        false;
    };
};

// Handle vehicles
if (_ctrl isEqualTo _ctrlLightButton || _ctrl isEqualTo _ctrlHeavyButton) exitWith {
    // Light or heavy
    private _heavyVeh = _ctrl isEqualTo _ctrlHeavyButton;

    // Choose listbox
    private _listBox = [_ctrlLightList, _ctrlHeavyList] select _heavyVeh;

    // Get vehicle classname
    private _classname = _listBox lbData (lbCurSel _listBox);

    // Remove vehicle from Garrison
    [_sector, _classname, _heavyVeh] remoteExecCall [QMFUNC(_delVeh), 2];

    // Get spawnpos and spawn vehicle
    private _spawnPos = [_sectorPos] call MFUNC(_getVehSpawnPos);
    [_classname, _spawnPos, random 360, true, true, _side] call KPLIB_fnc_common_createVehicle;

    // Reload sector details after a small sync delay
    [{ _this call MFUNC(_dialogSelectSector); }, [lbCurSel _ctrlLbSectors], 2] call CBA_fnc_waitAndExecute;

    true;
};

false;
