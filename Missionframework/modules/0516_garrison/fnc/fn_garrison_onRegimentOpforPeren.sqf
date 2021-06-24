#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onRegimentOpforPeren

    File: fn_garrison_onRegimentOpforPeren.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-27 11:31:44
    Last Update: 2021-06-24 12:47:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Callback REGIMENTS the 'perennial', not unlike the botanical definition.
        Meaning, garrison which grows once forever and ever more, AMEN. In other
        words, once they are regimented, they are never to be recalculated. The
        goal of any REGIMENT is to simply select the actual classes that fulfill
        the previously determined SECTOR ACTIVATION ALLOCATION.

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

private _debug = MPARAM(_onRegimentOpforPeren_debug)
    || (_sector getVariable [QMVAR(_onRegimentOpforPeren_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
// private _ratioBundle = _sector getVariable [QMVAR(_ratioBundle), []];

if (_debug) then {
    [format ["[fn_garrison_onRegimentOpforPeren] Entering: [_markerName, markerText _markerName]"
        , str [_markerName, markerText _markerName]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// Expecting either a NIL placeholder or a COEFFICIENT used to select the CLASS
private _onRegiment = {
    params [
        Q(_coefficient)
        , [Q(_classes), [], [[]]]
    ];

    switch (true) do {

        // Just randomize any selection
        case (isNil {_coefficient}): { selectRandom _classes; };

        // Allowing for coefficient throttled maximums
        case (_coefficient isEqualType 0): {
            private _index = floor (random 1 * _coefficient * (count _classes));
            _classes select _index;
        };

        default { ""; };
    };
};

// Make sure we are bridging the ALLOCATION to the actual selected CLASSES
private _elements = +[
    [
        QMVAR(_intelAllocation)
        , QMVAR(_intelClasses)
        , KPLIB_preset_resources_intelClassNames
    ]
    , [
        QMVAR(_resourceAllocation)
        , QMVAR(_resourceClasses)
        , KPLIB_resources_crateClassesF
    ]
    , [
        QMVAR(_mineAllocation)
        , QMVAR(_mineClasses)
        , KPLIB_preset_ieds_mineClassNames
    ]
];

// Bypass when GARRISON has already happened for the PERENNIALS
private _elementsToRegiment = _elements select { !((_x select 1) in _garrisonMap); };

{
    private _allocationKey = _x select 0;
    private _regimentKey = _x select 1;
    private _classes = _x select 2;
    private _allocation = _regimentMap get _allocationKey;
    private _regimentation = _allocation apply { [_x, _classes] call _onRegiment; };

    if (_debug) then {
        [format ["[fn_garrison_onRegimentOpforPeren] Regimenting: [_forEachIndex, _allocationKey, _regimentKey, _classes, _allocation, _regimentation]"
            , str [_forEachIndex, _allocationKey, _regimentKey, _classes, _allocation, _regimentation]], "GARRISON", true] call KPLIB_fnc_common_log;
    };

    _regimentMap set [_regimentKey, _regimentation];
} forEach _elementsToRegiment;

if (_debug) then {
    ["[fn_garrison_onRegimentOpforPeren] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
