#include "script_components.hpp"
/*
    KPLIB_fnc_build_objectUnderCursor

    File: fn_build_objectUnderCursor.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-07
    Last Update: 2021-01-29 12:17:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns object from build queue that is currently under the cursor

    Parameter(s):
        NONE

    Returns:
       Object that is currently under the cursor [OBJECT]
 */

// TODO: TBD: need to update the BUILD debug function with additional support...
private _debug = [
    [
        {KPLIB_param_build_objectUnderCursor_debug}
    ]
] call KPLIB_fnc_debug_debug;

private _camera = LGVAR(camera);
private _cursorPos = LGVAR(mousePos);
private _queue = LGVAR(buildQueue);

private _target = objNull;

if (_queue isEqualTo []) exitWith {
    if (_debug) then {
        ["[fn_build_objectUnderCursor] Queue items required", "BUILD", true] call KPLIB_fnc_common_log;
    };
    [] spawn KPLIB_fnc_build_onBuildItemDirectionSnapped;
    // See return below
    vehicle _target;
};

if (_debug) then {
    [format ["[fn_build_objectUnderCursor] %1 queue items: %2", count _queue, str (_queue apply {typeOf _x})], "BUILD", true] call KPLIB_fnc_common_log;
};

private _cursorWorldPosAGL = (screenToWorld _cursorPos);
private _cursorWorldPosASL = AGLtoASL _cursorWorldPosAGL;
private _camPos = getPosASLVisual _camera;

private _objects = lineIntersectsSurfaces [
    _camPos
    , _cursorWorldPosASL
    , _camera
    , objNull
    , true
    , 5
];

if (!(_objects isEqualTo [])) then {
    {
        private _obj = _x select 2;

        if (_obj in _queue) exitWith {
            _target = _obj;
        };

    } forEach _objects;
};

// If we were not able to find any item directly under cusror try to get one nearest to
if (isNull _target) then {
    private _nearest = (nearestObjects [_cursorWorldPosAGL, ["All"], 1]) arrayIntersect _queue;

    if (!(_nearest isEqualTo [])) then {
        _target = _nearest select 0;
    };
};

/* Which still may be null, vehicle of null is null, which is fine. But to not intersect
 * anything because we had no queue, that is incorrect in the first place. */

[nil, getDir vehicle _target] spawn KPLIB_fnc_build_onBuildItemDirectionSnapped;

vehicle _target
