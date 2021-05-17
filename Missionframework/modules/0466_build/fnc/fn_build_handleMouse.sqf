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

// This seems like a lot, but we really do need to get this kind of granular in order to vet what goes on
[
    [[{KPLIB_param_build_handleMouse_debug}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseButtonDown_debug}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseButtonUp_debug}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseButtonClick_debug}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseZChanged_debug}]] call KPLIB_fnc_debug_debug 
    , [[{KPLIB_param_build_handleMouse_onMouseMoving_debug}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseHolding_debug}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseZChanged_buildCategoryList_debug}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseZChanged_buildList_debug}]] call KPLIB_fnc_debug_debug
] params [
    "_debug"
    , "_debug_onMouseButtonDown"
    , "_debug_onMouseButtonUp"
    , "_debug_onMouseButtonClick"
    , "_debug_onMouseZChanged"
    , "_debug_onMouseMoving"
    , "_debug_onMouseHolding"
    , "_debug_onMouseZChanged_buildCategoryList"
    , "_debug_onMouseZChanged_buildList"
];

[
    [[{KPLIB_param_build_handleMouse_debugSystemChat}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseButtonDown_debugSystemChat}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseButtonUp_debugSystemChat}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseButtonClick_debugSystemChat}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseZChanged_debugSystemChat}]] call KPLIB_fnc_debug_debug 
    , [[{KPLIB_param_build_handleMouse_onMouseMoving_debugSystemChat}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseHolding_debugSystemChat}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseZChanged_buildCategoryList_debugSystemChat}]] call KPLIB_fnc_debug_debug
    , [[{KPLIB_param_build_handleMouse_onMouseZChanged_buildList_debugSystemChat}]] call KPLIB_fnc_debug_debug
] params [
    "_debugSystemChat"
    , "_debugSystemChat_onMouseButtonDown"
    , "_debugSystemChat_onMouseButtonUp"
    , "_debugSystemChat_onMouseButtonClick"
    , "_debugSystemChat_onMouseZChanged"
    , "_debugSystemChat_onMouseMoving"
    , "_debugSystemChat_onMouseHolding"
    , "_debugSystemChat_onMouseZChanged_buildCategoryList"
    , "_debugSystemChat_onMouseZChanged_buildList"
];

params [
    ["_mode", nil, [""]]
    , ["_args", nil, [[]]]
];

private _logic = KPLIB_buildLogic;

private _lblUpVector = LGVAR(lblUpVector);

switch (toLower _mode) do {
    case "onmousebuttondown": {
        _args params ["_targetCtrl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

        if (_debugSystemChat || _debugSystemChat_onMouseButtonDown) then {
            systemChat format ["[fn_build_handleMouse::onMouseButtonDown] [_button, _xPos, _yPos, _shift, _ctrl, _alt]: %1"
                , str [_button, _xPos, _yPos, _shift, _ctrl, _alt]];
        };

        private _buttonName = ["mouseLeft", "mouseRight"] select _button;
        LSVAR(_buttonName, true);

        if (_button == KPLIB_build_mouseButton_left) then {

            private _obj = [] call KPLIB_fnc_build_objectUnderCursor;

            // If item is selected try to place it, handle selection/dragging otherwise
            if (!(LGVAR(buildItem) call KPLIB_fnc_build_displayPlaceObject)) then {
                // Delay selection a bit to allow for mouse dragging
                [{
                    if (!(LGVAR(isDragging) || LGVAR(isRotating))) then {
                        [LGVAR(cursorObject)] call KPLIB_fnc_build_addToSelection;
                    };
                }, [], 0.1] call CBA_fnc_waitAndExecute;
            };
        };
    };

    case "onmousebuttonup": {
        _args params ["_targetCtrl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

        if (_debugSystemChat || _debugSystemChat_onMouseButtonUp) then {
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

        // // TODO: TBD: probably do not need much of a mouse button click after all...
        // // TODO: TBD: it might be interesting to modify the selection, but that's about it (?)
        // if (_button == KPLIB_build_mouseButton_left) then {

        //     private _obj = [] call KPLIB_fnc_build_objectUnderCursor;
        //     private _typeOfObj = if (isNull _obj) then { "objNull"; } else { typeOf _obj; };

        //     if (_debugSystemChat || _debugSystemChat_onMouseButtonClick) then {
        //         systemChat format ["[fn_build_handleMouse::onMouseButtonClick]: [isNull _obj, _typeOfObj, _button, _xPos, _yPos, _shift, _ctrl, _alt]: %1"
        //             , str [isNull _obj, _typeOfObj, _button, _xPos, _yPos, _shift, _ctrl, _alt]];
        //     };
        //     // TODO: TBD: and with scenarios to add more, remove them from, or simply replace selection, Ftomove)etc...
        //     [_obj] call KPLIB_fnc_build_addToSelection;
        // };

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

        if (_debugSystemChat || _debugSystemChat_onMouseZChanged) then {
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

        if (_debugSystemChat || _debugSystemChat_onMouseMoving) then {
            systemChat format ["[fn_build_handleMouse::onMouseMoving] [_xPos, _yPos, _mouseOver]: %1"
                , str [_xPos, _yPos, _mouseOver]];
        };

        // Enable camera movement when cursor not over dialog
        LGVAR(camera) camCommand "manual on";

        private _xyPos = [_xPos, _yPos];
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

        if (_debugSystemChat || _debugSystemChat_onMouseHolding) then {
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
