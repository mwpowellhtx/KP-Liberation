#include "script_components.hpp"
/*
    KPLIB_fnc_build_displayPlaceObject

    File: fn_build_displayPlaceObject.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-09-09
    Last Update: 2021-02-12 09:47:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates local object for the build queue

    Parameter(s):
        _className      - Classname of object to place  [STRING, default: ""]
        _priceSupplies   - Supplies price                [NUMBER, default: 0]
        _priceAmmo       - Ammo price                    [NUMBER, default: 0]
        _priceFuel       - Fuel price                    [NUMBER, default: 0]

    Returns:
        Object was placed [BOOL]
 */

private _debug = ["KPLIB_param_builddebug"] call KPLIB_fnc_build_debug;

params [
    ["_className", "", [""]]
    , ["_priceSupplies", 0, [0]]
    , ["_priceAmmo", 0, [0]]
    , ["_priceFuel", 0, [0]]
];

private _price = [_priceSupplies, _priceAmmo, _priceFuel];

// TODO: TBD: verify class name... may also verify cost...
if (_className isEqualTo "") exitWith {
    false;
};

// TODO: TBD: this is when we create an object to place it...
// TODO: TBD: could we also "ghost it" then? i.e. so the queue is more apparent (?)
private _obj = _className createVehicleLocal KPLIB_zeroPos;

_obj enableSimulation false;

([] call KPLIB_fnc_build_surfaceUnderCursor) params ["_cursorWorldPosASL", "_cursorSurfaceNormal"];

if (LGVAR(upVectorMode) == KPLIB_build_upVectorMode_true) then {
    _cursorSurfaceNormal = +KPLIB_build_upVector_true;
};

_obj setPosASL _cursorWorldPosASL;
// TODO: TBD: we have some sort of up vector comprehension right here... to start with anyway...
// TODO: TBD: also having build a FOB, we know that the "up" stays consistent during the build sequence...
_obj setVectorUp _cursorSurfaceNormal;

// TODO: TBD: for future reference... rename "price" to "cost" ...
// TODO: TBD: also the whole transactional system... cost, payment, credit, debit, etc...
_obj setVariable ["KPLIB_build_price", _price];

LGVAR(buildQueue) pushBack _obj;

// TODO: TBD: in an effort to isolate the moment(s) when we have a FOB building, for instance, and any vector issues at hand...
if (_debug) then {
    [format ["[fn_build_displayPlaceObject] [_className, typeOf _obj, getPos _obj, vectorUp _obj]: %1"
        , str [_className, typeOf _obj, getPos _obj, vectorUp _obj]], "BUILD"] call KPLIB_fnc_common_log;
};

// Clear current item upon placement
if (!LGVAR(ctrlKey)) then {
    LSVAR("buildItem",[]);
};

// Notify that item needs position validity check
["KPLIB_build_item_moved", _obj] call CBA_fnc_localEvent;

true;
