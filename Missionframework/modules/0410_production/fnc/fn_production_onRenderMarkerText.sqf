/*
    KPLIB_fnc_production_onRenderMarkerText

    File: fn_production_onRenderMarkerText.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 14:54:08
    Last Update: 2021-02-04 14:54:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a newly minted '_production' tupler corresponding with the given
        'KPLIB_sectors_factory' '_markerName'.

    Parameter(s):
        _markerName - the marker name of the discovered 'KPLIB_sectors_factory' site [STRING, default: ""]

    Returns:
        A newly minted '_production' tuple corresponding to the '_markerName' input.
        When invalid returns empty, i.e. '[]'.

Dependencies:
    0015_linq
    0025_timers
*/

// A single _production element.
private _productionElem = _this;

_productionElem params [
    ["_ident", [], [[]]]
    , ["_timer", KPLIB_timers_default, [[]], 4]
    , ["_info", [], [[]]]
];

_ident params [
    ["_markerName", "", [""]]
    , ["_baseMarkerText", "", [""]]
];

_info params [
    ["_cap", [], [[]]]
];

// TODO: TBD: might need to refactor "SAF" to appropriate resources module...
private _renderCap = {

    private _labels = "SAF" splitString "";

    private _onRenderCap = {
        params [
            ["_g", "", [""]]
            , ["_current", false, [false]]
            , ["_i", -1, [0]]
        ];

        private _retval = if (_i < 0 || !_current) then {_g} else {
            _g + (_labels select _i);
        };

        _retval;
    };

    ["", _cap, _onRenderCap] call KPLIB_fnc_linq_aggregate;
};

// Should never need to tally the text itself, always recalculate from base name and cap
private _markerText = format ["%1 [%2]", _baseMarkerText, ([] call _renderCap)];

_markerName setMarkerText _markerText;

_productionElem;
