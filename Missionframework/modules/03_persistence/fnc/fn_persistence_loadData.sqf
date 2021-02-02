/*
    KPLIB_fnc_persistence_loadData

    File: fn_persistence_loadData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell
    Date: 2019-02-02
    Last Update: 2021-02-02 18:39:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads data which is bound to persistence module from the given save data or initializes needed data for a new campaign.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

if (KPLIB_param_debug) then {
    ["Persistence module loading...", "SAVE"] call KPLIB_fnc_common_log;
};

private _moduleData = ["persistence"] call KPLIB_fnc_init_getSaveData;

// Check if there is a new campaign
if (_moduleData isEqualTo []) then {
    if (KPLIB_param_debug) then {
        ["Persistence module data empty, creating new data...", "SAVE"] call KPLIB_fnc_common_log;
    };
} else {
    // Otherwise start applying the saved data
    if (KPLIB_param_debug) then {
        ["Persistence module data found, applying data...", "SAVE"] call KPLIB_fnc_common_log;
    };

    // TODO: TBD: this is one way of doing it...
    // TODO: TBD: but we think there is a reason why there were data tuples being created in the legacy framework...
    // TODO: TBD: especially that include not only position, but also direction, up, etc...
    private _onSelectNotNull = {!isNull _x};

    // Filter out any targets that fell outside the boundaries of a known FOB.
    private _onFobFilter = {
        params [
            ["_target", objNull, [objNull]]
        ];
        if (!(([_target, KPLIB_fnc_eden_callback_onWithinRange] call KPLIB_fnc_eden_select) isEqualTo [])) then {
            if (!(_target isKindOf "Man")) then {
                {deleteVehicle _x} forEach ((crew _target) select {!(isNull _x || _x isEqualTo _target)});
            };
            deleteVehicle _target;
            _target = objNull;
        };
        _target
    };

    // Load objects
    KPLIB_persistence_objects = (_moduleData#0) apply {
        _x params [
            "_serialized", ["_variables", []]
        ];

        private _object = _serialized call KPLIB_fnc_persistence_deserializeObject;
        // Apply saved variables
        {
            _x params [["_var", nil], ["_val", nil], ["_global", false]];
            if (!isNil "_var") then {
                _object setVariable [_var, _val, _global];
                // Add var to persistence so even if module that added it originaly is not preset the data won't be lost
                _var call KPLIB_fnc_persistence_addPersistentVar;
            };
        } forEach _variables;

        [_object] call _onFobFilter;

    } select _onSelectNotNull;

    // Load units
    KPLIB_persistence_units = (_moduleData#1) apply {
        _x params [
            "_serialized", ["_variables", []]
        ];

        private _unit = _serialized call KPLIB_fnc_persistence_deserializeUnit;
        // Apply saved variables
        {
            _x params [["_var", nil], ["_val", nil], ["_global", false]];
            if (!isNil "_var") then {
                _unit setVariable [_var, _val, _global];
                // Add var to persistence so even if module that added it originaly is not preset the data won't be lost
                _var call KPLIB_fnc_persistence_addPersistentVar;
            };
        } forEach _variables;

        [_unit] call _onFobFilter;

    } select _onSelectNotNull;
};

true
