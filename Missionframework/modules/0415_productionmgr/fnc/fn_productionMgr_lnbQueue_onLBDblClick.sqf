#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_lnbQueue_onLBDblClick

    File: fn_productionMgr_lnbQueue_onLBDblClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-09 16:48:20
    Last Update: 2021-02-11 17:54:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module queue list box onLBDblClick event handler.

    Parameter(s):
        _lnbQueue - the list box control [CONTROL]
        _selectedIndex - the selected index [SCALAR, default: -1]

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLBDblClick
*/

params [
    ["_lnbQueue", controlNull, [controlNull]]
    , ["_selectedIndex", -1, [0]]
];

if (_selectedIndex <= 0) exitWith {
    true;
};

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _btnDequeue = _display displayCtrl KPLIB_IDD_PRODUCTIONMGR_BTNDEQ;

// Also, as with other control alias event handlers, spawn, not call
[_btnDequeue] spawn KPLIB_fnc_productionMgr_btnDequeue_onButtonClick;

true;
