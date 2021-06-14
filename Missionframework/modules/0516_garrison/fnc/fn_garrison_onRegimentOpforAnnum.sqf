#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onRegimentOpforAnnum

    File: fn_garrison_onRegimentOpforAnnum.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-27 11:31:44
    Last Update: 2021-06-14 17:12:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Callback REGIMENTS the 'annuals', not unlike the botanical definition.
        Meaning, garrison which grows one and only one time, must be re-grown
        with every SECTOR ACTIVATION. The goal of any REGIMENT is to simply select
        the actual classes that fulfill the previously determined SECTOR ACTIVATION
        ALLOCATION.

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

private _debug = MPARAM(_onRegimentOpforAnnum_debug)
    || (_sector getVariable [QMVAR(_onRegimentOpforAnnum_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
//private _ratioBundle = _regimentMap get QMVAR(_ratioBundle);

if (_debug) then {
    [format ["[fn_garrison_onRegimentOpforAnnum] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// This is the moment when we filter, either regiment, or allow to passthrough
private _onRegiment = {
    params [
        [Q(_class), nil, [nil, ""]]
        , [Q(_classes), [], [[]]]
    ];
    selectRandom _classes;
};

private _elements = [
    [
        QMVAR(_unitAllocation)
        , QMVAR(_unitClasses)
        , [KPLIB_preset_sideE] call KPLIB_fnc_common_getSoldierArray
    ]
    , [
        QMVAR(_lightVehicleAllocation)
        , QMVAR(_lightVehicleClasses)
        , [] call MFUNC(_getLightVehiclePresets)
    ]
    , [
        QMVAR(_heavyVehicleAllocation)
        , QMVAR(_heavyVehicleClasses)
        , [] call MFUNC(_getHeavyVehiclePresets)
    ]
];

private _elementsToRegiment = +_elements;

{
    private _allocationKey = _x select 0;
    private _regimentKey = _x select 1;
    private _classes = _x select 2;
    private _allocation = _regimentMap get _allocationKey;
    private _regimentation = _allocation apply { [_x, _classes] call _onRegiment; };

    if (_debug) then {
        [format ["[fn_garrison_onRegimentOpforAnnum] Regimenting: [_forEachIndex, _allocationKey, _regimentKey, _allocation, _regimentation]"
            , str [_forEachIndex, _allocationKey, _regimentKey, _allocation, _regimentation]], "GARRISON", true] call KPLIB_fnc_common_log;
    };

    _regimentMap set [_regimentKey, _regimentation];

} forEach _elementsToRegiment;

if (_debug) then {
    ["[fn_garrison_onRegimentOpforAnnum] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
