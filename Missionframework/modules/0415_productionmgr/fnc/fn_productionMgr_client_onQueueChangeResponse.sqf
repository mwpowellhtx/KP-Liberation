#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_client_onQueueChangeResponse

    File: fn_productionMgr_client_onQueueChangeResponse.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 21:24:27
    Last Update: 2021-02-10 21:24:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Client module 'onChangeQueueResponse' event handler, responds to the
        'KPLIB_productionMgr_onQueueChangeResponse' CBA owner event.

    Parameter(s):
        _productionElem - _this, corresponds with the production element that
            got updated in response to the change request [ARRAY, default: []]

    Returns:
        Event handler finished [BOOL]

    References:
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

private _productionElem = _this;

if (_debug) then {
    ["[fn_productionMgr_client_onQueueChangeResponse] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
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

// Re-set the display production array and reload the sectors list box
_display setVariable ["_production", _production];

[_lnbSectors] spawn KPLIB_fnc_productionMgr_lnbSectors_onLoad;

if (_debug) then {
    ["[fn_productionMgr_client_onQueueChangeResponse] Finished", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
