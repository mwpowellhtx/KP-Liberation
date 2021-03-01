/*
    KPLIB_fnc_logisticsMgr_lnbConvoy_getSelectedTransportIndex

    File: fn_logisticsMgr_lnbConvoy_getSelectedTransportIndex.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 10:00:51
    Last Update: 2021-03-01 10:00:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns the actual selected transport index of the CONVOY LISTNBOX, taking
        into consideration the header row.

    Parameters:
        NONE

    Returns:
        The actual selected transport index [BOOL]

    References:
        https://community.bistudio.com/wiki/lnbCurSelRow
 */

private _lnbConvoy = uiNamespace getVariable ["KPLIB_logisticsMgr_lnbConvoy", controlNull];

private _defaultIndex = -1;

if (isNull _lnbConvoy) exitWith {
    _defaultIndex;
};

private _selectedIndex = lnbCurSelRow _lnbConvoy;

if (_selectedIndex < 1) exitWith {
    _defaultIndex;
};

_selectedIndex - 1;
