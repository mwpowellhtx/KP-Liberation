/*
    KPLIB_fnc_build_confirmSingle

    File: fn_build_confirmSingle.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-29
    Last Update: 2021-01-27 21:59:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Confirms single item from build queue.

    Parameters:
        _createParams   - Parameters for common_createVehicle           [ARRAY, default: nil]
        _vectorDirAndUp - Vector dir and up for created object          [ARRAY, default: nil]
        _price          - Supplies price                                [ARRAY, default: nil]
        _player         - Player that initiated the building of object  [OBJECT, default: objNull]

    Returns:
        Function reached the end [BOOL]
 */

private _debug = [] call KPLIB_fnc_build_debug;

params [
    ["_createParams", nil, [[]]],
    ["_vectorDirAndUp", nil, [[]], 2],
    ["_price", +KPLIB_resources_storageValueDefault, [[]], 3],
    ["_player", objNull, [objNull]]
];
_createParams params ["_className", "_pos", "_dir", "_justBuild"];

private _markerName = [] call KPLIB_fnc_common_getPlayerFob;

// Debit when we have a debit to contend with
if (!(([_markerName] + _price) call KPLIB_fnc_resources_pay)) exitWith {
    [format ["Not enough resources to build: %1 at: '%2', price: %3", _className, _markerName, str _price], "BUILD"] call KPLIB_fnc_common_log;
    ["KPLIB_build_not_enough_resources", [_className], _player] call CBA_fnc_targetEvent;
    false;
};

private ["_obj"];

/* The core issue here was observed when building a FOB building. During the build
 * process, could move the object about, rotate, reposition, etc, and it would adhere
 * to terrain accordingly. Upon acknowledgment and completion of that process, would
 * suddenly forget about that terrain adherence. After much troubleshooting and chasing
 * after the up and direction vectors, determined the issue was most likely one of timing,
 * and possibly object availability. Spawning here is key to ensuring that the bits are set
 * correctly when the object is subsequently available for them to be set. */

switch (true) do {
    case (_className isKindOf "Man"): {
        _obj = [createGroup KPLIB_preset_sideF, _className] call KPLIB_fnc_common_createUnit;

        [_obj, _pos, _vectorDirAndUp] spawn {
        //                            ^^^^^
            params ["_obj", "_pos", "_vectorDirAndUp"];

            _obj setPosATL _pos;
            _obj setVectorDirAndUp _vectorDirAndUp;

            // Set watching direction
            if (_obj isEqualTo formLeader _obj) then {
                _obj setFormDir getDir _obj;
            };
        };
    };

    default {

        if (_debug) then {
            [format ["[fn_build_confirmSingle] [_className, _pos, _vectorDirAndUp]: %1"
                , str [_className, _pos, _vectorDirAndUp]], "BUILD"] call KPLIB_fnc_common_log;
        };

        _obj = _createParams call KPLIB_fnc_common_createVehicle;

        // Spawning appears to be the right approach for the subsequent bits being correct.
        [_obj, _vectorDirAndUp] spawn {
        //                      ^^^^^
            params ["_obj", "_vectorDirAndUp"];

            _obj setVectorDirAndUp _vectorDirAndUp;

            if (unitIsUAV _obj) then {
                [_obj, KPLIB_preset_sideF] call KPLIB_fnc_common_createCrew;
            };
        };
    };
};

["KPLIB_build_item_built", [_obj, _markerName]] call CBA_fnc_globalEvent;
["KPLIB_build_item_built_local", [_obj, _markerName], _player] call CBA_fnc_targetEvent;
