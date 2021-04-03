#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_onGetList

    File: fn_hudDispatchSM_onGetList.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns with the next iteration of the HUD DISPATCH state machine list to be processed.

    Parameters:
        NONE

    Returns:
        The next iteration of the HUD DISPATCH state machine list to be processed [ARRAY]
 */

private _objSM = MVAR(_objSM);

// Probably do not need to set the variable on the statemachine object
private _players = _objSM getVariable [QMVAR(_players), allPlayers];

// Do not refresh timers etc at this moment
_players;
