#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_garrisonUI_dialogAdd

    File: fn_garrisonUI_dialogAdd.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 14:27:33
    Last Update: 2021-04-16 14:27:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Despawns unit/group and adds it to the sector garrison.

    Parameter(s):
        _ctrl - the clicked button [CONTROL, default: controlNull]

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = KPLIB_param_debug;

params [
    [Q(_ctrl), controlNull, [controlNull]]
];

if (isNull _ctrl) exitWith {
    false;
};

// Dialog controls
private _dialog = findDisplay KPLIB_IDD_GARRISON_DIALOG;

private _ctrlLbSectors = _dialog displayCtrl KPLIB_IDC_GARRISON_GARRISONLIST;
private _ctrlLbGroups = _dialog displayCtrl KPLIB_IDC_GARRISON_GROUPLIST;
private _ctrlGroupButton = _dialog displayCtrl KPLIB_IDC_GARRISON_GROUPBUTTON;
private _ctrlLbUnits = _dialog displayCtrl KPLIB_IDC_GARRISON_UNITLIST;
private _ctrlUnitButton = _dialog displayCtrl KPLIB_IDC_GARRISON_UNITBUTTON;

// Disable add buttons
{ _x ctrlEnable false; } forEach [_ctrlGroupButton, _ctrlUnitButton];

// Get selected sector
private _sector = _ctrlLbSectors lbData (lbCurSel _ctrlLbSectors);

// Get the classname arrays
private _infantry = +KPLIB_preset_unitsPlF;
_infantry append KPLIB_preset_specOpsPlF;

private _lVehicles = +KPLIB_preset_vehLightUnarmedPlF;
_lVehicles append KPLIB_preset_vehLightArmedPlF;
_lVehicles append KPLIB_preset_vehTransPlF;

private _hVehicles = +KPLIB_preset_vehHeavyApcPlF;
_hVehicles append KPLIB_preset_vehHeavyPlF;
_hVehicles append KPLIB_preset_vehAntiAirPlF;
_hVehicles append KPLIB_preset_vehArtyPlF;

private _all = _infantry + _lVehicles + _hVehicles;

// Add unit vehicle to sector garrison
if (_ctrl isEqualTo _ctrlGroupButton) then {
    MVAR(_dialogSelGroup) params ["_group", "_units"];
    private _classnames = _units apply {typeOf _x};
    private _validClassnames = _classnames select {_x in _all};

    // Only proceed with a valid (buildable) units
    if ((count _classnames) isEqualTo (count _validClassnames)) then {
        if (_debug) then {
            [format ["Adding group to garrison of %1: %2 (%3)", markerText _sector, _group, _classnames], "GARRISON"] call KPLIB_fnc_common_log;
        };

        // Despawn group
        {
            private _veh = _x;
            {_veh deleteVehicleCrew _x;} forEach (crew _veh);
            deleteVehicle _veh;
        } forEach _units;
        deleteGroup _group;

        // Add classnames to garrison
        private _infamount = 0;
        {
            switch (true) do {
                case (_x in _hVehicles): {
                    [_sector, _x, true] remoteExecCall [QMFUNC(_addVeh), 2];
                };
                case (_x in _lVehicles): {
                    [_sector, _x] remoteExecCall [QMFUNC(_addVeh), 2];
                };
                case (_x in _infantry): {
                    _infamount = _infamount + 1;
                };
            };
        } forEach _classnames;

        // Add counted infantry to garrison
        if (_infamount > 0) then {
            [_sector, _infamount] remoteExecCall [QMFUNC(_addInfantry), 2];
        };
    } else {
        // Hint about invalid unit
        [localize "STR_KPLIB_DIALOG_GARRISON_INVALID_NOTE"] call KPLIB_fnc_notification_hint;
    };
} else {

    private _classname = typeOf MVAR(_dialogSelUnit);

    // Only proceed with a valid (buildable) unit
    if (_classname in _all) then {
        if (_debug) then {
            [format ["Adding unit to garrison of %1: %2 (%3)", markerText _sector, MVAR(_dialogSelUnit), _classname], "GARRISON"] call KPLIB_fnc_common_log;
        };

        // Remove selected unit
        {MVAR(_dialogSelUnit) deleteVehicleCrew _x;} forEach (crew MVAR(_dialogSelUnit));
        deleteVehicle MVAR(_dialogSelUnit);

        // Add unit to garrison
        switch (true) do {
            case (_classname in _hVehicles): {
                [_sector, _classname, true] remoteExecCall [QMFUNC(_addVeh), 2];
            };
            case (_classname in _lVehicles): {
                [_sector, _classname] remoteExecCall [QMFUNC(_addVeh), 2];
            };
            case (_classname in _infantry): {
                [_sector, 1] remoteExecCall [QMFUNC(_addInfantry), 2];
            };
        };
    } else {
        // Hint about invalid unit
        [localize "STR_KPLIB_DIALOG_GARRISON_INVALID_NOTE"] call KPLIB_fnc_notification_hint;
    };
};

// Refresh dialog after a small sync delay
[{ _this call MFUNC(_dialogSelectSector); }, [lbCurSel _ctrlLbSectors], 2] call CBA_fnc_waitAndExecute;

true;
