#include "script_component.hpp"
/*
    KPLIB_fnc_assets_getMobileAssets

    File: fn_assets_getMobileAssets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-25 23:44:24
    Last Update: 2021-05-25 23:44:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Unlike their STATIC cousins, MOBILE ASSETS do not necessarily need to be acquired
        in proximity to any MARKER NAMES. Rather, we probe the VEHICLES array for them.

    Parameter(s):
        _classNames - the CLASS NAMES to consider [STRING|ARRAY, default: []]

    Returns:
        An ARRAY of the MOBILE ASSETS aligned to the request [ARRAY]
 */

params [
    [Q(_classNames), [], ["", []]]
];

private _assets = [];

// Flattens the CLASS NAMES out regardless of the shape
_classNames = flatten [_classNames];

private _assets = vehicles select { typeOf _x in _classNames; };

_assets select { [_x] call MFUNC(_shouldBeCounted); };
