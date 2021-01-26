/*
    KPLIB_fnc_init_startbaseMarkers

    File: fn_init_startbaseMarkers.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-24 22:04:56
    Last Update: 2021-01-24 22:04:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates the map markers for the enumerated start bases.

    Reference:
        https://community.bistudio.com/wiki/setMarkerType
        https://community.bistudio.com/wiki/setMarkerColor
        https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
*/

params [
    ["_startbases", []]
];

waitUntil {!isNil "KPLIB_preset_colorF"};
waitUntil {!isNil "KPLIB_startbase_markerType"};

// Start by building tuple: [name, proxy, markerName]
private _startbasesWithMarkers = _startbases apply {
    [
        _x select 0
        , _x select 1
        , format ["%1_marker", _x select 0]
    ]
};

// Extend that tuple: [name, proxy, markerName, marker]
_startbasesWithMarkers = _startbasesWithMarkers apply {
    _x params ["_name", "_proxy", "_markerName"];
    [
        _name
        , _proxy
        , _markerName
        , createMarker [_markerName, _proxy]
    ];
};

private _onSetTypeTextAndColor = {
    _x params ["_0", "_proxy", "_markerName"];
    _markerName setMarkerType KPLIB_startbase_markerType;
    /* The 'timing' is fine... It was the syntax that was the issue.
     * 'this' is the keyword, and use tick marks ("'") instead of quotes ('"'). */
    private _proxyMarkerText = _proxy getVariable ["KPLIB_eden_markerText", localize "STR_KPLIB_MAINBASE"];
    _markername setMarkerText _proxyMarkerText;
    _markerName setMarkerColor KPLIB_preset_colorF;
};

_onSetTypeTextAndColor forEach _startbasesWithMarkers;

_startbasesWithMarkers
