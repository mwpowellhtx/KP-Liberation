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
        _createParams   - Parameters for common_createVehicle           [ARRAY, defaults to nil]
        _vectorDirAndUp - Vector dir and up for created object          [ARRAY, defaults to nil]
        _price          - Supplies price                                [ARRAY, defaults to nil]
        _player         - Player that initiated the building of object  [OBJECT, defaults to objNull]

    Returns:
        Function reached the end [BOOL]
*/
params [
    ["_createParams", nil, [[]]],
    ["_vectorDirAndUp", nil, [[]], 2],
    ["_price", nil, [[]], 3],
    ["_player", objNull, [objNull]]
];
_createParams params ["_className", "_pos", "_dir", "_justBuild"];

private _markerName = [] call KPLIB_fnc_common_getPlayerFob;

if !(([_markerName] + _price) call KPLIB_fnc_resources_pay) exitWith {
    [format ["Not enough resources to build: %1 at: '%2', price: %3", _className, _markerName, _price], "BUILD"] call KPLIB_fnc_common_log;
    ["KPLIB_build_not_enough_resources", [_className], _player] call CBA_fnc_targetEvent;
};

private ["_obj"];

switch (true) do {
    case (_className isKindOf "Man"): {
        _obj = [createGroup KPLIB_preset_sideF, _className] call KPLIB_fnc_common_createUnit;
        _obj setPosATL _pos;
        _obj setVectorDirAndUp _vectorDirAndUp;

        // Set watching direction
        if (_obj isEqualTo formLeader _obj) then {
            _obj setFormDir getDir _obj;
        };
    };

    default {
        _obj = _createParams call KPLIB_fnc_common_createVehicle;
        _obj setVectorDirAndUp _vectorDirAndUp;

        if (unitIsUAV _obj) then {
            [_obj, KPLIB_preset_sideF] call KPLIB_fnc_common_createCrew;
        };
    };
};

["KPLIB_build_item_built", [_obj, _markerName]] call CBA_fnc_globalEvent;
["KPLIB_build_item_built_local", [_obj, _markerName], _player] call CBA_fnc_targetEvent;
