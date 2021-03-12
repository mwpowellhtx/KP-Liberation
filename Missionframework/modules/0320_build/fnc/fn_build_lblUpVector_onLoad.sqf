#include "script_components.hpp"
#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_build_lblUpVector_onLoad

    File: fn_build_lblUpVector_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-11 19:31:11
    Last Update: 2021-03-11 19:31:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when loading the control for the first time.

    Parameter(s):
        _ctrl - the control being loaded [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_ctrl", controlNull, [controlNull]]
];

LSVAR("lblUpVector",_ctrl);

true;
