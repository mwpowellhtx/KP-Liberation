#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_renderSimple

    File: fn_hudFob_renderSimple.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 11:49:03
    Last Update: 2021-05-26 11:49:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Renders the SIMPLE values as a STRING.

    Parameters:
        _this - in this case, usually one or more elements contributing to the format [ARRAY, default: []]

    Returns:
        Rendered SIMPLE [STRING]
 */

_this apply { format ["%1", _x toFixed 0]; };
