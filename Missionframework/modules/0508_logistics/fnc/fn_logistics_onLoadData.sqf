/*
    KPLIB_fnc_logistics_onLoadData

    File: fn_logistics_onLoadData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 11:58:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        NONE

    Returns:
        NONE
 */

private _debug = [] call KPLIB_fnc_logistics_debug;

if (_debug) then {
    ["[fn_logistics_onLoadData] Loading...", "LOGISTICS"] call KPLIB_fnc_common_log;
};

private _moduleData = +(["logistics"] call KPLIB_fnc_init_getSaveData);
private _logistics = [];

// Check if there is a new campaign
if (_moduleData isEqualTo []) then {
    if (_debug) then {
        ["[fn_logistics_onLoadData] Initializing data...", "LOGISTICS"] call KPLIB_fnc_common_log;
    };

} else {
    // Otherwise start applying the saved data
    if (_debug) then {
        ["[fn_logistics_onLoadData] Loading data...", "LOGISTICS"] call KPLIB_fnc_common_log;
    };

    // TODO: TBD: might be worth introducing mini-wipes for easily corrupted areas such as these...
    // This is the most important bit, but we can also easily reset when we need to...
    _logistics = (_moduleData#0);

    // Ensures that we allow only verified data through
    _logistics = _logistics select {
        if (isNil "_x") then {false} else {
            [_x] call KPLIB_fnc_logistics_verifyArray;
        };
    };

    if (_debug) then {
        ["[fn_logistics_onLoadData] Loaded", "LOGISTICS"] call KPLIB_fnc_common_log;
    };
};

if (_debug) then {
    [format ["[fn_logistics_onLoadData] [count _logistics, _logistics]"
        , str [count _logistics, _logistics]], "LOGISTICS"] call KPLIB_fnc_common_log;
};

// Convert the serialized arrays to CBA namespaces...
private _namespaces = _logistics apply {
    private _namespace = [_x] call KPLIB_fnc_logistics_arrayToNamespace;
    // Yes, "should rebase" loading LOGISTICS LINES...
    [_namespace, [
        ["KPLIB_logistics_shouldRebase", true]
    ]] call KPLIB_fnc_namespace_setVars;
    _namespace;
};

// TODO: TBD: keeping hold of this for debuging purposes...
KPLIB_logistics_loadedData = (+_logistics);

// Nothing to sort in this instance, accept as-is
KPLIB_logistics_namespaces = (+_logistics);

if (_debug) then {
    ["[fn_logistics_onLoadData] Loaded", "LOGISTICS"] call KPLIB_fnc_common_log;
};

true;
