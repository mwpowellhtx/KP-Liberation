#include "script_components.hpp"
/*
    KPLIB_fnc_build_validatePosition

    File: fn_build_validatePosition.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-11-04
    Last Update: 2019-04-23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Validates object placement and sets variable on it accordingly

    Parameter(s):
        _object - Object to validate [OBJECT, defaults to objNull]

    Returns:
        Placement is valid [BOOL]
*/

params [
    ["_object", objNull, [objNull]]
];

private _inBuildArea = _this inArea [LGVAR(center), LGVAR(radius), LGVAR(radius), 0, false];

// TODO: TBD: only 'that' (?) is in area (?)
_object setVariable ["KPLIB_build_isInArea", _inBuildArea];

_inBuildArea;
