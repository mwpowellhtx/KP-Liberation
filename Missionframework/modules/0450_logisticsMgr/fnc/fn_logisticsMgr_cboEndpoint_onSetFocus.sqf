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
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onSetFocus
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_cboEndpoint_onSetFocus_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_cboEndpoint", controlNull, [controlNull]]    
];

private _selectedLine = uiNamespace getVariable ["KPLIB_logisticsMgr_selectedLine", []];

_selectedLine params [
    ["_lineUuid", "", [""]]
    , ["_status", KPLIB_logistics_status_standby, [0]]
];

// When not in STANDBY then exit early
if (_status > KPLIB_logistics_status_standby) exitWith {
    uiNamespace setVariable ["KPLIB_logisticsMgr_cboEndpoint", controlNull];
    false;
};

[] call {
    uiNamespace setVariable ["KPLIB_logisticsMgr_cboEndpoint", _cboEndpoint];

    private _selectedIndex = lbCurSel _cboEndpoint;

    if (_selectedIndex < 1) exitWith { false; };

    private _endpointMarker = _cboEndpoint lbData _selectedIndex;

    // Repositions the map, etc, when the control focus is (re-)set
    [markerPos _endpointMarker] call KPLIB_fnc_logisticsMgr_ctrlMap_onReload;

    true;
};
