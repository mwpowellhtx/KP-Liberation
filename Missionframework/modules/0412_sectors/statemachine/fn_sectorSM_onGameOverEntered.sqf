#include "script_component.hpp"
/*
    KPLIB_fnc_sectorSM_onGameOverEntered

    File: fn_sectorSM_onGameOverEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-12 17:12:21
    Last Update: 2021-06-14 16:57:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        GAME OVER 'onStateEntered' event handler.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAMSM(_onGameOverEntered_debug);

params [
    [Q(_sector), locationNull, [locationNull]]
];

true;
