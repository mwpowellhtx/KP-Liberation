#include "..\ui\defines.hpp"
#include "script_components.hpp"
/*
    KPLIB_fnc_build_handleRotation

    File: fn_build_handleRotation.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-10-07
    Last Update: 2019-04-23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles object rotation dragging

    Parameter(s):
        _anchorObject   - Rotation dragging anchor object                   [OBJECT, defaults to objNull]
        _updatePos      - Rotation should be finished and positions updated [BOOL, defaults to false]

    Returns:
        Is rotating [BOOL]
*/

params [
    ["_anchorObject", objNull, [objNull]]
    , ["_updateRot", false, [false]]
];

// Exit rotation drag and set direction of objects
if (_updateRot) exitWith {

    LSVAR("isRotating", false);

    // Move all selected objects to target positions
    {
        private _rotDir = _x getVariable ["KPLIB_rotationDir", []];

        if (!(_rotDir isEqualTo [])) then {
            _x setDir _rotDir;
        };

        // Notify that item needs position validity check
        ["KPLIB_build_item_moved", [_x]] call CBA_fnc_localEvent;

    } forEach LGVAR(selection);

    // Reset state variables
    LSVAR("rotationAnchorObject", objNull);

    // Return val
    false
};

// Can't rotate while dragging
if (LGVAR(isDragging)) exitWith {false};

// Rotation start
if (isNull _anchorObject) then {
    LSVAR("isRotating", true);

    // If selection is empty or currently dragged object not in selection
    if (LGVAR(selection) isEqualTo [] || !(LGVAR(cursorObject) in LGVAR(selection))) then {
        [LGVAR(cursorObject)] call KPLIB_fnc_build_addToSelection;
    };

    LSVAR("rotationAnchorObject", LGVAR(cursorObject));

} else {

    private _mouseWorldPos = AGLToASL screenToWorld LGVAR(mousePos);
    private _anchorPos = getPosASL LGVAR(rotationAnchorObject);

    {
        private _posASL = getPosASL _x;
        private _rotDir = _posASL getDir _mouseWorldPos;

        _rotDir = [_rotDir] call KPLIB_fnc_build_getSnappedDirection;

        _x setVariable ["KPLIB_rotationDir", _rotDir];

        // TODO: TBD: should reflect snap in the drawn line as well...
        // TODO: TBD: need distance of the original line
        // TODO: TBD: then calculate new point from the origin that distance and heading
        private _lineStartPos = _x modelToWorldVisual [0,0,0];
        private _lineEndPos = (ASLtoAGL _mouseWorldPos);
        _lineEndPos set [2, (_lineStartPos select 2)];

        drawLine3D [
            _lineStartPos,
            _lineEndPos,
            [1,1,0,1] // Yellow
        ];

        [nil, _rotDir] spawn KPLIB_fnc_build_onBuildItemDirectionSnapped;

    } forEach LGVAR(selection);
};

// Return val
true
