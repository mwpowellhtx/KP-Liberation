#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_getSelectedMarkerName

    File: fn_productionMgr_getSelectedMarkerName.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-09 21:27:15
    Last Update: 2021-02-09 21:27:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the currently selected production manager marker name, if possible.

    Parameter(s):
        NONE

    Returns:
        The currently selected marker name, if possible [STRING, default: ""]
*/

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _lnbSectors = _display displayCtrl KPLIB_IDC_PRODUCTIONMGR_LNBSECTORS;

private _i = lnbCurSelRow _lnbSectors;

// Yes, we are looking up the marker name from the additional text data
if (_i >= 0) exitWith {
    _lnbSectors lnbData [_i, 0];
};

"";
