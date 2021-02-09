#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_lnbQueue_onLBSelChanged

    File: fn_productionMgr_lnbQueue_onLBSelChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-09 16:46:35
    Last Update: 2021-02-09 16:46:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module queue list box onLBSelChanged event handler.

    Parameter(s):
        _lnbQueue - the list box control [CONTROL]
        _selectedIndex - the selected index [SCALAR, default: -1]

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLBSelChanged
*/

params [
    ["_lnbQueue", controlNull, [controlNull]]
    , ["_selectedIndex", -1, [0]]
];

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

// TODO: TBD: perchance to notification_system ...
systemChat format ["fn_productionMgr_lnbQueue_onLBSelChanged: %1", _selectedIndex];

// Leaving room for a header row, which we do not want to engage.
if (_selectedIndex < 0) exitWith {};

if (_selectedIndex == 0) exitWith {
    _lnbQueue lnbSetCurSelRow -1;
};

// TODO: TBD: which refreshes the entire display...
