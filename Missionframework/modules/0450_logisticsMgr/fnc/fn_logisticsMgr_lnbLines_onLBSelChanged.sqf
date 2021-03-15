/*
    KPLIB_fnc_logisticsMgr_lnbLines_onLBSelChanged

    File: fn_logisticsMgr_lnbLines_onLBSelChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-27 15:14:45
    Last Update: 2021-03-15 01:17:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Responds to the 'onLBSelChanged' event

    Parameters:
        _lnbLines - the logistics LINES LISTNBOX control [CONTROL, default: controlNull]
        _selectedIndex - the logistics LINES LISTNBOX selected index [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLBSelChanged
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_lnbLines_onLBSelChanged_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_lnbLines", controlNull, [controlNull]]
    , ["_selectedIndex", -1, [0]]
];

if (_debug) then {
    [format ["[fn_logisticsMgr_lnbLines_onLBSelChanged] Entering: [isNull _lnbLines, _selectedIndex]: %1"
        , str [isNull _lnbLines, _selectedIndex]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

private _lines = uiNamespace getVariable ["KPLIB_logisticsMgr_lines", []];

if (_selectedIndex < 0 || (_selectedIndex + 1) > count _lines) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsMgr_lnbLines_onLBSelChanged] Index out of range: [count _lines, _selectedIndex]: %1"
            , str [count _lines, _selectedIndex]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
    };

    uiNamespace setVariable ["KPLIB_logisticsMgr_selectedLine", nil];

    // Clear the TELEMETRY data, obtain a zeroed HASHMAP report, and refresh
    uiNamespace setVariable ["KPLIB_logisticsMgr_telemetry", nil];
    [true] call KPLIB_fnc_logisticsMgr_lnbTelemetry_onUpdateReport;
    [] call KPLIB_fnc_logisticsMgr_lnbTelemetry_onRefresh;

    uiNamespace setVariable ["KPLIB_logisticsMgr_convoy", []];
    [] call KPLIB_fnc_logisticsMgr_lnbConvoy_onReload;

    false;
};

private _line = _lines select _selectedIndex;

if (_debug) then {
    [format ["[fn_logisticsMgr_lnbLines_onLBSelChanged] Line selected: [_selectedIndex, _line]: %1"
        , str [_selectedIndex, _line]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

uiNamespace setVariable ["KPLIB_logisticsMgr_selectedLine", _line];

// This is where we dissect the tuple and stage the bits for the rest of the dialog
_line params [
    ["_lineUuid", "", [""]]
    , ["_status", KPLIB_logistics_status_standby, [0]]
    , ["_timer", +KPLIB_timers_default, [[]], 4]
    , ["_endpoints", [], [[]]]
    , ["_convoy", [], [[]]]
    , ["_telemetry", [], [[]]]
];

/* Inject the actual TELEMETRY, obtain status and timer HASHMAP report, and refresh. Remember, now, however,
 * "telemetry" published by the server to the client are now associative key/value pairs; mapping string names
 * to primitive values. */

uiNamespace setVariable ["KPLIB_logisticsMgr_telemetry", _telemetry];
[false, [_status, _timer]] call KPLIB_fnc_logisticsMgr_lnbTelemetry_onUpdateReport;
[] call KPLIB_fnc_logisticsMgr_lnbTelemetry_onRefresh;

uiNamespace setVariable ["KPLIB_logisticsMgr_convoy", _convoy];
[] call KPLIB_fnc_logisticsMgr_lnbConvoy_onReload;

if (_status > KPLIB_logistics_status_standby) then {

    // Yes but only do this when the line is actually running, i.e. >STANDBY
    _endpoints params [
        ["_alpha", [], [[]]]
        , ["_bravo", [], [[]]]
    ];

    [_alpha, "alpha"] call KPLIB_fnc_logisticsMgr_cboEndpoint_setViewData;
    [_bravo, "bravo"] call KPLIB_fnc_logisticsMgr_cboEndpoint_setViewData;

    private _ctrlMap = uiNamespace getVariable ["KPLIB_logisticsMgr_ctrlMap", controlNull];
    [nil, nil, _ctrlMap] spawn  KPLIB_fnc_logisticsMgr_ctrlMap_onReload;
};

if (_debug) then {
    ["[fn_logisticsMgr_lnbLines_onLBSelChanged] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
