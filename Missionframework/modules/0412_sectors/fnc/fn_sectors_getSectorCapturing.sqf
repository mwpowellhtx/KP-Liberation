#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getSectorCapturing

    File: fn_sectors_getSectorCapturing.sqf
    Author: Michael W. Powell [22nd MSU SOC]
    Created: 2021-04-21 16:20:50
    Last Update: 2021-04-25 19:59:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether SECTOR may begin CAPTURING process. Should support CAPTURING
        when SECTOR was OPFOR, as well as when SECTOR was BLUFOR.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        Whether SECTOR may begin CAPTURING process [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAM(_getSectorCapturing_debug)
    || (_namespace getVariable [QMVAR(_getSectorCapturing_debug), false]);

[
    _namespace getVariable [QMVAR(_markerName), ""]
    , _namespace getVariable [QMVAR(_blufor), false]
    , _namespace getVariable [QMVAR(_opfor), false]
    , _namespace getVariable [QMVAR(_opforUnitCountAct), 0]
    , _namespace getVariable [QMVAR(_opforUnitCountCap), 0]
    , _namespace getVariable [QMVAR(_opforTankCountAct), 0]
    , _namespace getVariable [QMVAR(_opforTankCountCap), 0]
    , _namespace getVariable [QMVAR(_bluforUnitCountAct), 0]
    , _namespace getVariable [QMVAR(_bluforUnitCountCap), 0]
    , _namespace getVariable [QMVAR(_bluforTankCountAct), 0]
    , _namespace getVariable [QMVAR(_bluforTankCountCap), 0]
] params [
    Q(_markerName)
    , Q(_blufor)
    , Q(_opfor)
    , Q(_opforUnitCountAct)
    , Q(_opforUnitCountCap)
    , Q(_opforTankCountAct)
    , Q(_opforTankCountCap)
    , Q(_bluforUnitCountAct)
    , Q(_bluforUnitCountCap)
    , Q(_bluforTankCountAct)
    , Q(_bluforTankCountCap)
];

// // TODO: TBD: investigating the adoption of capture ratios, bias, etc
// private _unitRatio = _bluforUnitCountCap / _opforUnitCountCap;

if (_debug) then {
    [format ["[fn_sectors_getSectorCapturing] Entering: [_markerName, markerText _markerName, _blufor, _opfor]: %1"
        , str [_markerName, markerText _markerName, _blufor, _opfor]], "SECTORS", true] call KPLIB_fnc_common_log;
};

private _retval = switch (true) do {

    case (_opfor): {
        if (_debug) then {
            [format ["[fn_sectors_getSectorCapturing] OPFOR: [_markerName, _opforTankCountCap, _bluforUnitCountCap, _opforUnitCountCap]: %1"
                , str [_markerName, _opforTankCountCap, _bluforUnitCountCap, _opforUnitCountCap]], "SECTORS", true] call KPLIB_fnc_common_log;
        };
        _opforTankCountCap == 0 && _bluforUnitCountCap > _opforUnitCountCap;
    };

    case (_blufor): {
        if (_debug) then {
            [format ["[fn_sectors_getSectorCapturing] BLUFOR: [_markerName, _bluforTankCountCap, _opforUnitCountCap, _bluforUnitCountCap]: %1"
                , str [_markerName, _bluforTankCountCap, _opforUnitCountCap, _bluforUnitCountCap]], "SECTORS", true] call KPLIB_fnc_common_log;
        };
        _bluforTankCountCap == 0 && _opforUnitCountCap > _bluforUnitCountCap;
    };

    default { false; }
};

if (_debug) then {
    [format ["[fn_sectors_getSectorCapturing] Fini: [_markerName, markerText _markerName, _retval]: %1"
        , str [_markerName, markerText _markerName, _retval]], "SECTORS", true] call KPLIB_fnc_common_log;
};

_retval;