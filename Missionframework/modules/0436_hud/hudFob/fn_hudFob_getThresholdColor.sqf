#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_getReport

    File: fn_hudFob_getReport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 00:59:45
    Last Update: 2021-05-26 22:33:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        We shall maintain a single CBA REPORT namespace instance for purposes
        of notifying FOB HUD elements.

    Parameters:
        _player - a PLAYER for whom to report the FOB HUD bits [OBJECT, default: objNull]
        _thresholds - an array of threshold pairs [ARRAY, default: []]

    Returns:
        An FOB HUD REPORT namespace [LOCATION]
 */

params [
    [Q(_value), 0, [0]]
    , [Q(_thresholds), [], [[]]]
];

private _selected = _thresholds select { _value >= (_x#0); };

private _colors = _selected apply { (_x#1); };

_colors params [
    [Q(_color), +MPRESET(_whiteColor), [[]], 4]
];

+_color;
