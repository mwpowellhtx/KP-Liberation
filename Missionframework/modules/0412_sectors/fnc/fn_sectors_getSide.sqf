#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getSide

    File: fn_sectors_getSide.sqf
    Author: Michael W. Powell [22nd MSU SOC]
    Created: 2021-05-03 13:25:27
    Last Update: 2021-06-14 16:51:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Enumerates the STATUS bits by decomposing the flags and translating into
        human readable text.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        An array of decomposed human readable flags [ARRAY]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_getSide_debug)
    || (_sector getVariable [QMVAR(_getSide_debug), false])
    ;

private _blufor = _sector getVariable [QMVAR(_blufor), false];

[KPLIB_preset_sideE, KPLIB_preset_sideF] select _blufor;
