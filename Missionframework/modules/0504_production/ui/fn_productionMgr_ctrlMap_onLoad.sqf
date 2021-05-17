#include "defines.hpp"
/*
    KPLIB_fnc_productionMgr_ctrlMap_onLoad

    File: fn_productionMgr_ctrlMap_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-16 00:14:03
    Last Update: 2021-02-16 00:14:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Common defines for cratefiller module UI elements

    Parameters:
        _ctrlMap - the map control being unloaded [CONTROL, default: controlNull]
        _exitCode - the exit code at the time of unloading [SCALAR, default: -1]

    Returns:
        The event handler has finished [BOOL]
 */

// TODO: TBD: may better define KPLIB_sector_markerName variable on the map itself...
params [
    ["_ctrlMap", controlNull, [controlNull]]
];

if (isNull _ctrlMap) then {
    private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;
    _ctrlMap = _display displayCtrl KPLIB_IDC_PRODUCTIONMGR_CTRLMAP;
};

[_ctrlMap] call KPLIB_fnc_productionMgr_ctrlMap_onUnload;

private _sectorMarkerName = _ctrlMap getVariable ["KPLIB_sector_markerName", ""];

if (_sectorMarkerName isEqualTo "") exitWith {
    true;
};

private _i = 0;

private _storageContainers = [_sectorMarkerName] call KPLIB_fnc_resources_getFactoryStorages;

private _storageMarkerNames = _storageContainers apply {

    private _storageMarkerName = format ["%1_storage_%2", _sectorMarkerName, str _i];

    if (!(_storageMarkerName in allMapMarkers)) then {
        createMarkerLocal [_storageMarkerName, getPosATL _x];

        _i = _i + 1;

        // TODO: TBD: add string table entry...
        _storageMarkerName setMarkerTextLocal "Storage";
        _storageMarkerName setMarkerTypeLocal KPLIB_productionMgr_storageMarkerType;
        _storageMarkerName setMarkerColorLocal KPLIB_productionMgr_storageMarkerColor;

        _storageMarkerName;
    } else {
        "";
    };
    
} select { !(_x isEqualTo "") };

private _existingMarkerNames = uiNamespace getVariable ["KPLIB_productionMgr_storageMarkerNames", []];
uiNamespace setVariable ["KPLIB_productionMgr_storageMarkerNames", _existingMarkerNames + _storageMarkerNames];

true;
