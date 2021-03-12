#include "script_components.hpp"
#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_build_lblUpVector_onButtonClick

    File: fn_build_lblUpVector_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-11 18:53:51
    Last Update: 2021-03-11 18:53:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Toggles the up vector mode when clicked.

    Parameter(s):
        _ctrl - the control being clicked [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_ctrl", controlNull, [controlNull]]
];

// TODO: TBD: preserve and restore current build queue
switch (LGVAR_D(upVectorMode,KPLIB_build_upVectorMode_terrain)) do {

    case KPLIB_build_upVectorMode_terrain: {
        _ctrl ctrlSetText localize "STR_KPLIB_DIALOG_UP_VECTOR_MODE_TRUE";
        LSVAR("upVectorMode",KPLIB_build_upVectorMode_true);
    };

    case KPLIB_build_upVectorMode_true: {
        _ctrl ctrlSetText localize "STR_KPLIB_DIALOG_UP_VECTOR_MODE_TERRAIN";
        LSVAR("upVectorMode",KPLIB_build_upVectorMode_terrain);
    };
};

{
    // TODO: TBD: does any of this need to pass up to the server?
    // TODO: TBD: rather that gets deferred to when the objects have been "accepted" by the player building...

    // Apply the appropriate up vector to the current build queue
    switch (LGVAR_D(upVectorMode,KPLIB_build_upVectorMode_terrain)) do {

        case KPLIB_build_upVectorMode_terrain: {
            private _surfaceNormalUpVector = surfaceNormal getPos _x;
            _x setVectorUp _surfaceNormalUpVector;
        };

        case KPLIB_build_upVectorMode_true: {
            _x setVectorUp +KPLIB_build_upVector_true;
        };
    };
} forEach (LGVAR_D(buildQueue,[]));

true;
