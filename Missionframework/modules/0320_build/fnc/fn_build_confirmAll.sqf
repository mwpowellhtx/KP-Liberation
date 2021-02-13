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

private _validItems = LGVAR(buildQueue) select {
    _x getVariable ["KPLIB_validPos", true];
};

private _queue = LGVAR(buildQueue) - _validItems;

LSVAR("buildQueue",_queue);

{
    [
        _x
        , typeOf _x
        , getPosATL _x
        , [vectorDir _x, vectorUp _x]
        , _x getVariable "KPLIB_build_price"
    ] params [
        "_obj"
        , "_className"
        , "_pos"
        , "_dirAndUp"
        , "_price"
    ];

    deleteVehicle _obj;

    [[_className, _pos, 0, true], _dirAndUp, _price, player] remoteExecCall ["KPLIB_fnc_build_confirmSingle", 2];

} forEach _validItems;

true;
