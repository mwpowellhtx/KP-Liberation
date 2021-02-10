#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_lnbSectors_onLBSelChanged

    File: fn_productionMgr_lnbSectors_onLBSelChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-06 12:56:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module sectors list box onLBSelChanged event handler.

    Parameter(s):
        _lnbSectors - the list box control [CONTROL]
        _selectedIndex - the selected index [SCALAR, default: -1]

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLBSelChanged
*/

params [
    ["_lnbSectors", controlNull, [controlNull]]
    , ["_selectedIndex", -1, [0]]
];

// While we could use the index, etc, this also affords us an opportunity to verify introspection
private _markerName = [_lnbSectors] call KPLIB_fnc_productionMgr_getSelectedMarkerName;

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _productionElem = [_display, _markerName] call KPLIB_fnc_productionMgr_getProductionElement;

// Set the production element variable then spawn some UI refresh event handlers
_display setVariable ["_productionElem", _productionElem];

{
    [_display displayCtrl (_x#0)] spawn (_x#1);
[_display displayCtrl KPLIB_IDC_PRODUCTIONMGR_LNBSTATUS] spawn KPLIB_fnc_productionMgr_lnbStatus_onLoad;
} forEach [
    [KPLIB_IDC_PRODUCTIONMGR_LNBSTATUS, KPLIB_fnc_productionMgr_lnbStatus_onLoad]
    , [KPLIB_IDC_PRODUCTIONMGR_LNBQUEUE, KPLIB_fnc_productionMgr_lnbQueue_onLoad]
    , [KPLIB_IDC_PRODUCTIONMGR_LBLTIMEREMAININGFORMATTED, KPLIB_fnc_productionMgr_lbTimeRemainingFormatted_onLoad]
];
