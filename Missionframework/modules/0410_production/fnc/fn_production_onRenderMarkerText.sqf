/*
    KPLIB_fnc_production_onRenderMarkerText

    File: fn_production_onRenderMarkerText.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 14:54:08
    Last Update: 2021-02-17 12:02:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Operates on the expected '_this' CBA production namespace, renders the corresponding
        marker text appropriately, and returns with the same namespace object.

    Parameter(s):
        _this - a CBA production namespace [LOCATION]

    Returns:
        The CBA production namespace following marker text rendering [LOCATION]

Dependencies:
    0015_linq
    0025_timers
*/

params [
    ["_namespace", locationNull, [locationNull]]
];

if (!(_namespace call KPLIB_fnc_production_verifyNamespace)) exitWith {
    _namespace;
};

private _markerName = _namespace getVariable ["_markerName", ""];
private _baseMarkerText = _namespace getVariable ["_baseMarkerText", ""];
private _capability = +(_namespace getVariable ["_capability", (+KPLIB_resources_capDefault)]);

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

    ["", _capability, _onRenderCap] call KPLIB_fnc_linq_aggregate;
};

// Should never need to tally the text itself, always recalculate from base name and cap
private _markerText = format ["%1 [%2]", _baseMarkerText, ([] call _renderCap)];

_markerName setMarkerText _markerText;

_namespace;
