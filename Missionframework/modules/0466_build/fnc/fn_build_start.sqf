#include "script_components.hpp"
/*
    KPLIB_fnc_build_start

    File: fn_build_start.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-09-09
    Last Update: 2021-01-27 23:00:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Starts KP Liberation building mode

    Parameters:
        _center - Center of building area [POSITION, default: position player]
        _radius - Allowed building radius [NUMBER, default: KPLIB_param_fobRange]

    Returns:
        Building logic object [LOCATION]
*/

params [
    ["_center", position player, [[]], 3]
    , ["_radius", KPLIB_param_fobRange, [0]]
];

// Animate player
player playActionNow "gear";

private _logic = [] call KPLIB_fnc_namespace_create;
KPLIB_buildLogic = _logic;

// General
_logic setVariable ["selectedCategoryIdx", nil];

// Initialize all variables used by logic
[_logic, [
    // General
    ["buildMode", KPLIB_build_buildMode_move]
    , ["upVectorMode", KPLIB_build_upVectorMode_terrain]
    , ["buildItem", []]
    , ["buildQueue", []]
    , ["buildables", KPLIB_build_categoryItems]
    , ["center", _center]
    , ["radius", _radius]
    , ["areaIndicators", [_center, _radius] call KPLIB_fnc_build_markArea]
    , ["camera", [_center, _radius] call KPLIB_fnc_build_camCreate]
    , ["display", displayNull]
    , ["selection", []]
    , ["cursorObject", objNull]
    , ["dragAnchorObject", objNull]
    , ["rotationAnchorObject", objNull]
    // States
    , ["isDragging", false]
    , ["isRotating", false]
    // Keys
    , ["altKey", false]
    , ["ctrlKey", false]
    , ["shiftKey", false]
    , ["heldKeys", [] resize 255]
    , ["mouseLeft", false]
    , ["mouseRight", false]
    , ["mousePos", [0.5, 0.5]]
]] call KPLIB_fnc_namespace_setVars;

// Draw bounding boxes for objects in queue
[] call KPLIB_fnc_build_boundingBoxPFH;

// Draw icons for objects in queue
[] call KPLIB_fnc_build_drawIconsPFH;

// TODO: TBD: loathe hard coded resource ids ... without at least declaring the variable ...
(findDisplay 46) createDisplay "KPLIB_build";

["KPLIB_build_start", [_logic, _center, _radius]] call CBA_fnc_localEvent;

_logic;
