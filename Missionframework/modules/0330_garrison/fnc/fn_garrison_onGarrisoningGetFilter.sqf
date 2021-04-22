#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onGarrisoningGetFilter

    File: fn_garrison_onGarrisoningGetFilter.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-17 22:28:11
    Last Update: 2021-04-21 11:28:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the specified GARRISON SPEC FILTER.

    Parameter(s):
        _ceil - whether the CEIL primitive is requested; otherwise ROUND [BOOl, default: true]

    Returns:
        The desired functional primitive [CODE]
 */

params [
    [Q(_ceil), true, [true]]
];

if (_ceil) exitWith {
    { ceil _this; };
};

{ round _this; };
