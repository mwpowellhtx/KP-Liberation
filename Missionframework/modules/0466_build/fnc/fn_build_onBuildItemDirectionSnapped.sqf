#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_build_onBuildItemDirectionSnapped

    File: fn_build_onBuildItemDirectionSnapped.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-14 19:02:11
    Last Update: 2021-02-14 19:02:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets the heading control text to the already '_snappedDir' in the number of '_places'.

    Parameter(s):
        _ctrl - optional heading control, defaults to the build dialog and heading control [CONTROL, default: controlNull]
        _snappedDir - an already snapped direction; really any direction is accepted, however [SCALAR, default: nil]
        _places - the number of places toFixed should use to format [SCALAR, default: KPLIB_param_build_degreePlaces]

    Returns:
       When the callback has completed [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/toFixed
 */

params [
    ["_ctrl", controlNull, [controlNull]]
    , "_snappedDir"
    , ["_places", KPLIB_param_build_degreePlaces, [0]]
];

if (_ctrl isEqualTo controlNull) then {
    _ctrl = (findDisplay KPLIB_IDD_BUILD_DIALOG) displayCtrl KPLIB_IDC_BUILD_TOOLBOX_HEADING;
};

private _format = localize "STR_KPLIB_DIALOG_BUILD_HEADING_FORMAT";

private _rendered = if (isNil "_snappedDir") then {
    format [_format, localize "STR_KPLIB_DIALOG_BUILD_HEADING_FORMAT_NIL"];
} else {
    _snappedDir = (_snappedDir max 0) min 360;
    format [_format, _snappedDir toFixed _places];
};

_ctrl ctrlSetText _rendered;

true;