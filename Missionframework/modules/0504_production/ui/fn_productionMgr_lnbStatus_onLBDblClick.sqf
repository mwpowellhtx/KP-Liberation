#include "defines.hpp"
/*
    KPLIB_fnc_productionMgr_lnbStatus_onLBDblClick

    File: fn_productionMgr_lnbStatus_onLBDblClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-11 17:32:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        The status list box 'onLBDblClick' event relays to the handler for the button 'onButtonClick' event.

    Parameter(s):
        _lnbStatus - the list box control [CONTROL]
        _selectedIndex - the selected index [SCALAR, default: -1]

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLBDblClick
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
*/

params [
    ["_lnbStatus", controlNull, [controlNull]]
    , ["_selectedIndex", -1, [0]]
];

if (_selectedIndex <= 0) exitWith {
    true;
};

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _btnEnqueueIdcs = [
    KPLIB_IDC_PRODUCTIONMGR_BTNENQSUP
    , KPLIB_IDC_PRODUCTIONMGR_BTNENQAMM
    , KPLIB_IDC_PRODUCTIONMGR_BTNENQFUE
];

private _resourceIndex = _selectedIndex - 1;

private _btnEnqueue = _display displayCtrl (_btnEnqueueIdcs#_resourceIndex);

// Spawn the callback in this instance do not call it
[_btnEnqueue,       [_resourceIndex]] spawn KPLIB_fnc_productionMgr_btnEnqueue_onButtonClick;
// _resourceIndex:   ^^^^^^^^^^^^^^ (careful of the nested arrays here)
//     _args:       ^^^^^^^^^^^^^^^^ (revisit KPLIB_productionMgr.hpp for those examples)

true;
