/*
    KPLIB_fnc_production_onLoadData

    File: fn_production_onLoadData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 17:10:52
    Last Update: 2021-02-04 17:10:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads data which is bound to this module from the save data, or initializes
        the same, approaching the campaign.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

private _debug = [] call KPLIB_fnc_production_debug;

if (_debug) then {
    ["[fn_production_onLoadData] Loading...", "PRODUCTION"] call KPLIB_fnc_common_log;
};

/* Moment of truth, starting afresh every time works. Now we should also
 * allow for loading the saved data. The key with this one is that we are
 * not expecting _production _baseMarkerText to have been impacted. */
private _moduleData = +([KPLIB_production_moduleData_key] call KPLIB_fnc_init_getSaveData);
private _production = [];

// Check if there is a new campaign
if (_moduleData isEqualTo []) then {
    if (_debug) then {
        ["[fn_production_onLoadData] Initializing data...", "PRODUCTION"] call KPLIB_fnc_common_log;
    };

} else {
    // Otherwise start applying the saved data
    if (_debug) then {
        ["[fn_production_onLoadData] Loading data...", "PRODUCTION"] call KPLIB_fnc_common_log;
    };

    // TODO: TBD: might be worth introducing mini-wipes for easily corrupted areas such as these...
    // This is the most important bit, but we can also easily reset when we need to...
    _production = (_moduleData#0);

    // TODO: TBD: may need a more robust error detection, but for now let this one be
    // Do a health check on the data we load getting started in order to prevent snafus
    _production = _production select {
        if (isNil "_x") then {false} else {
            (typeName _x) isEqualTo "ARRAY";
        };
    };

    if (_debug) then {
        ["[fn_production_onLoadData] Loaded", "PRODUCTION"] call KPLIB_fnc_common_log;
    };
};

// TODO: TBD: let's make sure we are loading the data we think we are loading...
if (_debug) then {
    [format ["[fn_production_onLoadData] [count _production, _production]"
        , str [count _production, _production]], "PRODUCTION"] call KPLIB_fnc_common_log;
};

// Convert the serialized production arrays to CBA production namespaces...
private _namespaces = _production apply {
    [_x] call KPLIB_fnc_production_arrayToNamespace;
};

private _namespaceSortByCallback = {
    private _markerName = _x getVariable ["_markerName", ""];
    private _pos = markerPos _markerName;
    private _ref = mapGridPosition _pos;
    parseNumber _ref;
};

// TODO: TBD: added this for the time being for troubleshooting purposes..
// TODO: TBD: we keep this held aside while we work out SM and UI integration kinks...
// TODO: TBD: also so as not to damage the bits unduly while we do...
KPLIB_production_loadedData = [_namespaces, [], _namespaceSortByCallback] call BIS_fnc_sortBy;

// TODO: TBD: convert the reconciled production tuples to namespaces...
KPLIB_production_namespaces = [_namespaces] call KPLIB_fnc_production_onReconcile;

if (_debug) then {
    ["[fn_production_onLoadData] Loaded", "PRODUCTION"] call KPLIB_fnc_common_log;
};

true;
