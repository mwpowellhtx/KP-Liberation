#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_ctrlMap_onUnload

    File: fn_productionMgr_ctrlMap_onUnload.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-16 00:14:12
    Last Update: 2021-02-16 00:14:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Map control 'onUnload' event handler.

    Parameters:
        _ctrlMap - the map control being unloaded [CONTROL, default: controlNull]
        _exitCode - the exit code at the time of unloading [SCALAR, default: -1]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
 */

params [
    ["_ctrlMap", controlNull, [controlNull]]
    , ["_exitCode", -1, [0]]
];

if (isNull _ctrlMap) then {
   private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;
    _ctrlMap = _display displayCtrl KPLIB_IDC_PRODUCTIONMGR_CTRLMAP;
};

private _storageMarkerNames = uiNamespace getVariable ["KPLIB_productionMgr_storageMarkerNames", []];

[_storageMarkerNames] call {
    params [
        ["_storageMarkerNames", [], [[]]]
    ];
    _storageMarkerNames select {
        deleteMarkerLocal _x;
        true;
    };
};

true;
