#include "..\ui\defines.hpp"
#include "script_components.hpp"
/*
    KPLIB_fnc_build_handleMouse

    File: fn_build_handleMouse.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-09-09
    Last Update: 2019-04-23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handle build display mouse movement events

    Parameter(s):
        _mode   - Mouse event name              [STRING, defaults to nil]
        _args   - Additonal event parameters    [ARRAY, defaults to nil]

    Returns:
        NOTHING

    References:
        https://community.bistudio.com/wiki/surfaceNormal
 */

private _debug = [
    [
        {KPLIB_param_build_handleMouse_debug}
    ]
] call KPLIB_fnc_debug_debug;

private _debugSystemChat = [
    [
        {KPLIB_param_build_handleMouse_debugSystemChat}
    ]
] call KPLIB_fnc_debug_debug;

params [
    ["_mode", nil, [""]]
    , ["_args", nil, [[]]]
];

private _logic = KPLIB_buildLogic;

private _lblUpVector = LGVAR(lblUpVector);

switch (toLower _mode) do {
    case "onmousebuttondown": {
        _args params ["_targetCtrl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

        if (_debugSystemChat) then {
            systemChat format ["[fn_build_handleMouse::onMouseButtonDown] [_button, _xPos, _yPos, _shift, _ctrl, _alt]: %1"
                , str [_button, _xPos, _yPos, _shift, _ctrl, _alt]];
        };

        private _buttonName = ["mouseLeft", "mouseRight"] select _button;
        LSVAR(_buttonName, true);

        if (_button isEqualTo 0) then {
            // If item is selected try to place it, handle selection/dragging otherwise
            if (!(LGVAR(buildItem) call KPLIB_fnc_build_displayPlaceObject)) then {
                // Delay selection a bit to allow for mouse dragging
                [{
                    if (!LGVAR(isDragging) && !LGVAR(isRotating)) then {
                        [LGVAR(cursorObject)] call KPLIB_fnc_build_addToSelection;
                    };
                }, [], 0.1] call CBA_fnc_waitAndExecute;
            };
        };
    };

    case "onmousebuttonup": {
        _args params ["_targetCtrl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

        if (_debugSystemChat) then {
            systemChat format ["[fn_build_handleMouse::onMouseButtonUp] [_button, _xPos, _yPos, _shift, _ctrl, _alt]: %1"
                , str [_button, _xPos, _yPos, _shift, _ctrl, _alt]];
        };

        private _buttonName = ["mouseLeft", "mouseRight"] select _button;
        LSVAR(_buttonName, false);

        if (LGVAR(isDragging)) then {
            // Move dragged objects to destination position
            [LGVAR(dragAnchorObject), true] call KPLIB_fnc_build_handleDrag;
        };

        if (LGVAR(isRotating)) then {
            // Rotate dragged objects
            [LGVAR(rotationAnchorObject), true] call KPLIB_fnc_build_handleRotation;
        };
    };

    case "onmousebuttonclick": {
        // TODO: TBD: so this is unfortunate, does not appear to suppose a middle mouse button click event...
        _args params ["_targetCtrl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

        if (_debugSystemChat) then {
            systemChat format ["[fn_build_handleMouse::onMouseButtonClick]: [_button, _xPos, _yPos, _shift, _ctrl, _alt]: %1"
                , str [_button, _xPos, _yPos, _shift, _ctrl, _alt]];
        };

        // if (_button == KPLIB_build_mouseButton_middle && [_shift, _ctrl, _alt] isEqualTo [false, false, false]) exitWith {
        //     //[_lblUpVector] spawn KPLIB_fnc_build_lblUpVector_onButtonClick;
        //     //false;
        // };

        if (true) exitWith { true; };
    };

    case "onmousezchanged": {
        // TODO: TBD: add a response here to determine what other key gestures are in play:
        // TODO: TBD: one response is to toggle the up vector, true vertical, or using surface normals terrain alignment, i.e. mousewheel
        // TODO: TBD: another response might be to raise or lower the object being placed: i.e. ctrl+mousewheel
        _args params ["_targetCtrl", "_zChange"];

        if (_debugSystemChat) then {
            systemChat format ["[fn_build_handleMouse::onMouseZChanged] [_zChange]: %1"
                , str [_zChange]];
        };

        private _modKeys = [
            LGVAR(shiftKey)
            , LGVAR(ctrlKey)
            , LGVAR(altKey)
        ];

        // TODO: TBD: does not behave quite like we would like, so we will try with a middle mouse button instead
        switch (true) do {

            // 1. toggle up vector alignment
            case (_modKeys isEqualTo [false, true, false]): {
                [_lblUpVector] spawn KPLIB_fnc_build_lblUpVector_onButtonClick;
                false;
            };

            // // TODO: TBD: 2. possibly also raising and lowering the object...
            // // TODO: TBD: 3. and by course (alt) or fine (shift+alt) deltas...
            // case (_modKeys isEqualTo [false, false, true]): {
            //     false;
            // };
            // case (_modKeys isEqualTo [true, false, true]): {
            //     false;
            // };

            default {
                true;
            };
        };

        if (true) exitWith { true; };
    };

    case "onmousemoving": {
        _args params ["_targetCtrl", "_xPos", "_yPos", "_mouseOver"];;

        if (_debugSystemChat) then {
            systemChat format ["[fn_build_handleMouse::onMouseMoving] [_xPos, _yPos, _mouseOver]: %1"
                , str [_xPos, _yPos, _mouseOver]];
        };

        // Enable camera movement when cursor not over dialog
        LGVAR(camera) camCommand "manual on";

        private _xyPos = [_xPos, _xPos];
        LSVAR("mousePos", _xyPos);

        LSVAR("cursorObject", [] call KPLIB_fnc_build_objectUnderCursor);

        if (LGVAR(isDragging) ||
            (!isNull LGVAR(cursorObject) && {(LGVAR(mouseLeft)) && {!LGVAR(shiftKey)} && !LGVAR(ctrlKey)})
        ) then {
            [LGVAR(dragAnchorObject)] call KPLIB_fnc_build_handleDrag;
        };

        // Handle rotation
        if (LGVAR(isRotating) ||
            (!isNull LGVAR(cursorObject) && {(LGVAR(mouseLeft)) && {LGVAR(shiftKey)} && !LGVAR(ctrlKey)})
        ) then {
            [LGVAR(rotationAnchorObject)] call KPLIB_fnc_build_handleRotation;
        };
     };

    case "onmouseholding": {
        _args params ["_targetCtrl", "_xPos", "_yPos", "_mouseOver"];;

        if (_debugSystemChat) then {
            systemChat format ["[fn_build_handleMouse::onMouseHolding] [_xPos, _yPos, _mouseOver]: %1"
                , str [_xPos, _yPos, _mouseOver]];
        };

        private _xyPos = [_xPos, _yPos];
        LSVAR("mousePos", _xyPos);

        LSVAR("cursorObject", [] call KPLIB_fnc_build_objectUnderCursor);

        if !(isNull LGVAR(dragAnchorObject)) then {
            [LGVAR(dragAnchorObject)] call KPLIB_fnc_build_handleDrag;
        };

        // Handle rotation
        if !(isNull LGVAR(rotationAnchorObject)) then {
            [LGVAR(rotationAnchorObject)] call KPLIB_fnc_build_handleRotation;
        };
    };

    case "onmousezchanged_buildcategorylist";
    case "onmousezchanged_buildlist": {
        // Disable camera movement when scrolling over build dialog
        // !TODO! is there any better solution?
        LGVAR(camera) camCommand "manual off";

        [{
            LGVAR(camera) camCommand "manual on";
        }] call CBA_fnc_execNextFrame;
    };

    default {
        [format ["Incorrect mode passed to handleMouse: %1", _mode], "BUILD"] call KPLIB_fnc_common_log
    };

};
