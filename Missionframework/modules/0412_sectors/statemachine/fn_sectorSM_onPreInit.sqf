#include "script_component.hpp"
/*
    KPLIB_fnc_sectorSM_onPreInit

    File: fn_sectorSM_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 13:33:30
    Last Update: 2021-06-14 16:56:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/createHashMapFromArray
        https://community.bistudio.com/wiki/Category:Function_Group:_Bitwise
        https://community.bistudio.com/wiki/a_%5E_b (a ^ b)
 */

if (isServer) then {
    ["[fn_sectorSM_onPreInit] Initializing...", "PRE] [SECTORSM", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */


/*
    ----- Module Initialization -----
 */

// Process CBA Settings, must be processed first
[] call MFUNCSM(_settings);

if (isServer) then {
    // Server section (dedicated and player hosted)

    // Anticipating STATE MACHINE config and the object itself
    MVARSM(_configSM)                                               = configNull;
    MVARSM(_objSM)                                                  = locationNull;
    MVARSM(_defaultConfigClassName)                                 = Q(KPLIB_sectorSM);
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_sectorSM_onPreInit] Initialized", "PRE] [SECTORSM", true] call KPLIB_fnc_common_log;
};

true;
