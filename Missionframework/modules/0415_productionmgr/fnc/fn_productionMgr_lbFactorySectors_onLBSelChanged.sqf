#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_lbFactorySectors_onLBSelChanged

    File: fn_productionMgr_lbFactorySectors_onLBSelChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-06 12:56:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module lbFactorySectors onLBSelChanged event handler.

    Parameter(s):
        _lbFactorySectors - the list box control [CONTROL]
        _selectedIndex - the selected index [SCALAR, default: -1]

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLBSelChanged
*/

params [
    ["_lbFactorySectors", controlNull, [controlNull]]
    , ["_selectedIndex", -1, [0]]
];

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

["we are here"] call KPLIB_fnc_notification_hit;

// TODO: TBD: which refreshes the entire display...
