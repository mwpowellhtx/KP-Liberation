/*
    KPLIB_fnc_logisticsMgr_lnbLines_onLoadDummyData

    File: fn_logisticsMgr_lnbLines_onLoadDummyData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-27 15:14:51
    Last Update: 2021-02-27 15:14:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _lnbLines - the logistics lines LISTNBOX control [CONTROL, default: controlNull]
        _config - the config [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_lnbLines", controlNull, [controlNull]]
    , ["_config", configNull, [configNull]]
];

private _lines = [];

// TODO: TBD: may refactor this to server side for test purposes, and a full-fledged tuple, including telemetry, convoy, etc...
while {count _lines < 100} do {
    private _line = +KPLIB_logistics_tupleTemplate;
    _line set [0, [] call KPLIB_fnc_uuid_create_string];
    _lines pushBack _line;
};

uiNamespace setVariable ["KPLIB_logistics_lines", _lines];

[_lnbLines, _config] call KPLIB_fnc_logisticsMgr_lnbLines_onLoad;

true;
