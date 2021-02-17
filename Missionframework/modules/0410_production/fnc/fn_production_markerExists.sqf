/*
    KPLIB_fnc_production_markerExists

    File: fn_production_markerExists.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 14:50:41
    Last Update: 2021-02-17 12:30:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the CBA production namespace '_markerName' exists in alignment
        with the current 'KPLIB_sectors_factory'. Callers may provide a single '_markerName'
        to the function. Callers should more typically provide the full '_production' tuple,
        i.e. '_this call KPLIB_fnc_production_markerExists'.

    Parameter(s):
        _this - one of several form factors;
            - _markerName - the actual marker name [STRING, default: ""]
            - _productiom - a production array [ARRAY, default: []]
            - _namespace - a CBA production namespace [LOCATION, default: objNull]

    Returns:
        Whether the '_markerName' exists in the currently known 'KPLIB_sectors_factory' array [BOOL]
*/

private _debug = [] call KPLIB_fnc_production_debug;

private _target = _this;

if (_debug) then {
    [format ["[fn_production_markerExists] [typeName _target]: %1"
        , str [typeName _target]], "PRODUCTION"] call KPLIB_fnc_common_log;
};

private _markerName = switch (typeName _target) do {
    case "STRING": {
        _target;
    };
    case "ARRAY": {
        (_target#0#0); // (_target#_identIndex#_markerNameIndex)
    };
    case "LOCATION": {
        _target getVariable ["_markerName", KPLIB_production_markerNameDefault];
    };
    default {
        _defaultMarker;
    };
};

private _i = KPLIB_sectors_factory findIf {
    _x isEqualTo _markerName;
};

if (_debug) then {
    [format ["[fn_production_markerExists] [_markerName, _i]: %1"
        , str [_markerName, _i]], "PRODUCTION"] call KPLIB_fnc_common_log;
};

_i >= 0;
