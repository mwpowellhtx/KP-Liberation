#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onRefreshSide

    File: fn_sectors_onRefreshSide.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-28 23:39:55
    Last Update: 2021-06-14 16:52:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        REFRESH key bits of the CBA SECTOR namespace. One of the first things we need
        to do is determine which SIDE the sector is still on. This ought to be naturally
        updated vis-a-vis the 'KPLIB_sectors_blufor' ARRAY, but we will verify that here.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [BOOL]

    References:
        https://en.wikipedia.org/wiki/Maginot_Line
        https://en.wikipedia.org/wiki/Line_in_the_sand
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _markerName = _sector getVariable [QMVAR(_markerName), ""];

private _blufor = _markerName in MVAR(_blufor);
private _side = MPRESET(_sides) select _blufor;

{ _sector setVariable _x; } forEach [
    [QMVAR(_side), _side]
    , [QMVAR(_blufor), _blufor]
    , [QMVAR(_opfor), !_blufor]
];

true;
