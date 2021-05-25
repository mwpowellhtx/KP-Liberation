#include "script_components.hpp"
/*
    KPLIB_fnc_build_validatePosition

    File: fn_build_validatePosition.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-04
    Last Update: 2021-05-19 12:24:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Validates object placement and sets variable on it accordingly.

    Parameter(s):
        _object - an OBJECT to validate [OBJECT, default: objNull]

    Returns:
        Placement is valid [BOOL]
 */

// TODO: TBD: may also need old/new position args... perhaps surface (i.e. water/land), etc...
params [
    ["_object", objNull, [objNull]]
];

private _inBuildArea = _object inArea [LGVAR(center), LGVAR(radius), LGVAR(radius), 0, false];

// TODO: TBD: only 'that' (?) is in area (?)
_object setVariable ["KPLIB_build_isInArea", _inBuildArea];

// Which is to say, allow the move...
if (_inBuildArea) then {
    ["KPLIB_build_item_moveValidated", [_object]] call CBA_fnc_localEvent;
};

_inBuildArea;
