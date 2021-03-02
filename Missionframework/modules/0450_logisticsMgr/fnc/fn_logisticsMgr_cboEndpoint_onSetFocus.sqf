/*
    KPLIB_fnc_logisticsMgr_cboEndpoint_onSetFocus

    File: fn_logisticsMgr_cboEndpoint_onSetFocus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 22:17:48
    Last Update: 2021-03-01 22:17:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _cboEndpoint - [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    References:
        ...
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_cboEndpoint_onSetFocus_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_cboEndpoint", controlNull, [controlNull]]    
];

private _selectedIndex = lbCurSel _cboEndpoint;

if (_selectedIndex < 0) exitWith {
    false;
};

private _endpointMarker = _cboEndpoint lbData _selectedIndex;

// Repositions the map, etc, when the control focus is (re-)set
[markerPos _endpointMarker] call KPLIB_fnc_logisticsMgr_ctrlMap_onReload;

true;
