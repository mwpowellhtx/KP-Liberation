#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onRegimentOpforUnits

    File: fn_garrison_onRegimentOpforUnits.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-04 15:00:52
    Last Update: 2021-06-14 17:12:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Further REGIMENTS the UNITS during the 'annuals' phase. The classes will
        have already been identified, as well as the grouping. Here we divide them
        into arrays that can more easily be relayed to create the groups of units.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _regimentMap - the REGIMENT HASHMAP [ARRAY, default: []]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_regimentMap), createHashMap, [emptyHashMap]]
];

private _debug = MPARAM(_onRegimentOpforUnits_debug)
    || (_sector getVariable [QMVAR(_onRegimentOpforUnits_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
// private _ratioBundle = _regimentMap get QMVAR(_ratioBundle);

if (_debug) then {
    [format ["[fn_garrison_onRegimentOpforUnits] Entering: [_markerName, markerText _markerName]"
        , str [_markerName, markerText _markerName]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _unitClasses = _regimentMap get QMVAR(_unitClasses);
private _grpAllocation = _regimentMap get QMVAR(_grpAllocation);

private _unitsPerGrp = (count _unitClasses) / (count _grpAllocation);

private _grpClasses = [];

while { _unitClasses isNotEqualTo []; } do {

    if (_debug) then {
        [format ["[fn_garrison_onRegimentOpforUnits] Grouping: [count _unitClasses, count _grpAllocation, _unitsPerGrp, count _grpClasses]"
            , str [count _unitClasses, count _grpAllocation, _unitsPerGrp, count _grpClasses]], "GARRISON", true] call KPLIB_fnc_common_log;
    };

    private _classes = if (count _unitClasses <= _unitsPerGrp) then {
        _unitClasses;
    } else {
        _unitClasses select [0, _unitsPerGrp];
    };

    _unitClasses = _unitClasses select [
        count _classes
        , (count _unitClasses) - (count _classes)
    ];

    _grpClasses pushBack _classes;
};

_regimentMap set [QMVAR(_unitClasses), _grpClasses];

if (_debug) then {
    ["[fn_garrison_onRegimentOpforUnits] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
