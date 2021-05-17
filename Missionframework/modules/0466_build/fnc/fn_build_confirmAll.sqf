#include "script_components.hpp"
/*
    KPLIB_fnc_build_confirmAll

    File: fn_build_confirmAll.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-28
    Last Update: 2021-02-12 10:41:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Confirms and builds every item in build queue.

    Parameter(s):
        NONE

    Returns:
        Items were built [BOOL]
*/

private _debug = [] call KPLIB_fnc_build_debug;

if (_debug) then {
    ["[fn_build_confirmAll] Entering...", "BUILD"] call KPLIB_fnc_common_log;
};

private _objectsInArea = LGVAR(buildQueue) select {
    _x getVariable ["KPLIB_build_isInArea", false];
};

// Removes the valid items from the queue prior to confirming them all
private _queue = LGVAR(buildQueue) - _objectsInArea;

LSVAR("buildQueue",_queue);

if (_debug) then {
    [format ["[fn_build_confirmAll] [count _queue (less invalid objects)]: %1"
        , str [count _queue]], "BUILD"] call KPLIB_fnc_common_log;
};

private _onEachObjectInArea = {
    [
        _x
        , typeOf _x
        , getPosATL _x
        , [vectorDir _x, vectorUp _x]
        // Gets a default build price when one does not yet exist
        , _x getVariable ["KPLIB_build_price", [0, 0, 0]]
    ] params [
        "_obj"
        , "_className"
        , "_pos"
        , "_dirAndUp"
        , "_price"
    ];

    if (_debug) then {
        [format ["[fn_build_confirmAll] [_className, _pos, _dirAndUp, _price]: %1"
            , str [_className, _pos, _dirAndUp, _price]], "BUILD"] call KPLIB_fnc_common_log;
    };

    deleteVehicle _obj;

    [[_className, _pos, 0, true], _dirAndUp, _price, player] remoteExecCall ["KPLIB_fnc_build_confirmSingle", 2];
};

_onEachObjectInArea forEach _objectsInArea;

if (_debug) then {
    ["[fn_build_confirmAll] Fini", "BUILD"] call KPLIB_fnc_common_log;
};

true;
