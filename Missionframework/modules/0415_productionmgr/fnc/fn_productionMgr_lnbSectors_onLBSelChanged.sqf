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

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _markerName = _lnbSectors lnbData [_selectedIndex, 0];

// TODO: TBD: perchance to notification_system ...
systemChat format ["[fn_productionMgr_lnbSectors_onLBSelChanged] [_selectedIndex, _markerName]: %1", str [_selectedIndex, _markerName]];

// TODO: TBD: which refreshes the entire display...
