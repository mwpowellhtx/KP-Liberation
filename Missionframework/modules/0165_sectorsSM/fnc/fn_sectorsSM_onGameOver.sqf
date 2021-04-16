#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onGameOver

    File: fn_sectorsSM_onGameOver.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-12 17:12:21
    Last Update: 2021-04-12 17:12:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        GAME OVER 'onState' event handler.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAMSM(_onGameOver_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

true;
