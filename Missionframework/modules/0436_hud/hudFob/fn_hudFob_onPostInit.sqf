#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_onPostInit

    File: fn_hudFob_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-25 17:11:49
    Last Update: 2021-05-25 17:11:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitUntilAndExecute-sqf.html
 */

if (hasInterface) then {
    // Client side section
    [{ KPLIB_campaignRunning; }, { [] call MFUNC(_onReport); }] call CBA_fnc_waitUntilAndExecute;
};

true;
