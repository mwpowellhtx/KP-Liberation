#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getSide

    File: fn_sectors_getSide.sqf
    Author: Michael W. Powell [22nd MSU SOC]
    Created: 2021-05-03 13:25:27
    Last Update: 2021-05-03 13:25:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Enumerates the STATUS bits by decomposing the flags and translating into
        human readable text.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        An array of decomposed human readable flags [ARRAY]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAM(_getSide_debug)
    || (_namespace getVariable [QMVAR(_getSide_debug), false]);

[
    _namespace getVariable [QMVAR(_opfor), false]
    , _namespace getVariable [QMVAR(_blufor), false]
] params [
    Q(_opfor)
    , Q(_blufor)
];

// May be BLUFOR
if (_blufor) exitWith {
    KPLIB_preset_sideF;
};

// Assumes OPFOR
KPLIB_preset_sideE;
