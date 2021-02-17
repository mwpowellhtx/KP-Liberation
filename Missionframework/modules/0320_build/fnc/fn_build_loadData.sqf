/*
    KPLIB_fnc_build_loadData

    File: fn_build_loadData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-04
    Last Update: 2021-01-27 22:16:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads build module data.

    Parameters:
        NONE

    Returns:
        Data was loaded [BOOL]
*/

if (KPLIB_param_debug) then {
    ["Build module loading...", "SAVE"] call KPLIB_fnc_common_log;
};

private _moduleData = ["build"] call KPLIB_fnc_init_getSaveData;

// DEPRECATED, persistence is handled by dedicated module
// TODO remove later. For now this function is left for save compatiblity.
// Check if there is any saved data
if (!(_moduleData isEqualTo [])) then {

    // Otherwise start applying the saved data
    if (KPLIB_param_debug) then {
        ["Build module data found, migrating data to persistence module...", "SAVE"] call KPLIB_fnc_common_log;
    };

    // Deserialize data for every FOB
    {
        // UUID for the FOB at which loading of module data occurs
        _x params ["_markerName", "_items"];

        // Convert serialized objects into real objects
        {
            _x params ["_className", "_posWorld", "_vectorDirAndUp"];

            private ["_object"];

            // TODO: TBD: proper deserialization/serialization with groups and vehicle crews handling
            switch {true} do {
                case (_className isKindOf "Man"): {
                    _object = [createGroup KPLIB_preset_sideF, _className] call KPLIB_fnc_common_createUnit;

                    [_object, _posWorld, _vectorDirAndUp] spawn {
                        params ["_object", "_posWorld", "_vectorDirAndUp"];
                        _object setPosWorld _posWorld;
                        _object setVectorDirAndUp _vectorDirAndUp;

                        // Set watching direction
                        if (_object isEqualTo formLeader _object) then {
                            _object setFormDir getDir _object;
                        };
                    };
                };

                default {
                    // TODO: TBD: this looks similar to persistence, doesn't that handle it (?)
                    _object = [_className] call KPLIB_fnc_common_createVehicle;

                    [_object, _posWorld, _vectorDirAndUp] spawn {
                        params ["_object", "_posWorld", "_vectorDirAndUp"];
                        _object setPosWorld _posWorld;
                        _object setVectorDirAndUp _vectorDirAndUp;
                    };
                };
            };

        } forEach _items;

    } forEach _moduleData;
};

true;
