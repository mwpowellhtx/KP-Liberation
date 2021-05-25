#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_onLoadData

    File: fn_fobs_onLoadData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-18 12:19:00
    Last Update: 2021-05-20 16:37:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Perofrms post 'KPLIB_doLoad' event handling assuming PERSISTANCE OBJECTS
        have been properly restored.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
 */

private _debug = MPARAM(_onLoadData_debug);

if (_debug) then {
    [format ["[fn_fobs_onLoadData] Loading: [count KPLIB_persistence_objects]: %1"
        , str [count KPLIB_persistence_objects]], "FOBS", true] call KPLIB_fnc_common_log;
};

// Ensures that we have ALL BUILDINGS identified and properly SORTED
private _allBuildings = [Q(ascend), KPLIB_persistence_objects select {
    typeOf _x isEqualTo KPLIB_preset_fobBuildingF;
}] call MFUNC(_getBuildings);

MVAR(_allBuildings) = _allBuildings;
[_allBuildings] call MFUNC(_resequence);

if (_debug) then {

    // Isolate the bits for debugging purposes
    private _allIndexedMilitaryAlphas = MVAR(_allBuildings) apply {
        [
            _x getVariable [QMVAR(_fobIndex), -1]
            , toUpper (_x getVariable [QMVAR(_militaryAlpha), ""])
        ];
    };

    [format ["[fn_fobs_onLoadData] Loaded: [count _allBuildings, _allIndexedMilitaryAlphas]: %1"
        , str [count _allBuildings, _allIndexedMilitaryAlphas]], "FOBS", true] call KPLIB_fnc_common_log;
};

/* Initiate the process of the STARTING BOX|TRUCK one time and one time only. Every
 * other follow on through this callback occurs when assets of these type(s) are
 * 'MPKilled' (see the event handler). */

[] spawn MFUNC(_onVerifyStartingBoxOrTruck);

// No need to do anything else here, i.e. UPDATE MARKERS, happens naturally later on
if (_debug) then {
    ["[fn_fobs_onLoadData] Fini", "FOBS", true] call KPLIB_fnc_common_log;
};

true;
