#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_client_onProductionElemResponse

    File: fn_productionMgr_client_onProductionElemResponse.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-11 09:13:11
    Last Update: 2021-02-11 09:13:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Client module 'onProductionElemResponse' event handler, responds to the
        'KPLIB_productionMgr_onProductionElemResponse' CBA owner event.

    Parameter(s):
        _productionElem - _this, corresponds with the production element that
            got updated in response to a server request [ARRAY, default: []]

    Returns:
        Event handler finished [BOOL]

    References:
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

private _productionElem = _this;

if (_debug) then {
    ["[fn_productionMgr_client_onProductionElemResponse] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _lnbSectors = _display displayCtrl KPLIB_IDC_PRODUCTIONMGR_LNBSECTORS;

private _production = _display getVariable ["_production", []];

private _i = _production findIf { (_x#0#0) isEqualTo (_productionElem#0#0); };

if (_i < 0) exitWith {
    // TODO: TBD: may log, notify error, etc...
    false;
};

// Re-place the element as quickly as possible and get out of the way of a subsequent re-load event
_production set [_i, +_productionElem];

// Re-set the display production array...
_display setVariable ["_production", _production];

// ...and re-select the current selection
_lnbSectors lnbSetCurSelRow (lnbCurSelRow _lnbSectors);

if (_debug) then {
    ["[fn_productionMgr_client_onProductionElemResponse] Finished", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
