#include "script_component.hpp"
/*
    KPLIB_fnc_eden_onPreInit

    File: fn_eden_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 11:20:25
    Last Update: 2021-04-15 11:10:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAM(_onPreInit_debug);

if (_debug) then {
    ["[fn_eden_onPreInit] Initializing...", "PRE] [EDEN", true] call KPLIB_fnc_common_log;
};

// Apply some module settings
[] call MFUNC(_settings);

//// TODO: TBD: we think this is unnecessary after all...
//// TODO: TBD: our aim then is to make a best, good faith effort to utilize the markers with maximum effect...
// /* DeployType enumerated:
//  *
//  * -1: Deploy type unknown, 'nil'
//  * 10: Operations start base
//  * 11: Forward operating base
//  * 20: Radio tower
//  * 30: Township
//  * 31: Metropolis
//  * 40: Factory
//  * 50: Enemy military base
//  * 99: Mobile respawn
//  *
//  * Note, we do not expect that all of the possible sector types will be relayed for
//  * player, but that disposition could change depending how requirements mature.
//  *
//  * Additionally, although we do not expect the set of sector types to grow, we will
//  * leave room just the same.
//  *
//  * Ordinarily bits such as these should go in the 'init' module, but we need them
//  * during Eden initialization.
//  */
// KPLIB_sectorType_nil     = -1;
// KPLIB_sectorType_eden    = 10;
// KPLIB_sectorType_fob     = 11;
// KPLIB_sectorType_tower   = 20;
// KPLIB_sectorType_town    = 30;
// KPLIB_sectorType_metro   = 31;
// KPLIB_sectorType_factory = 40;
// KPLIB_sectorType_mil     = 50;
// KPLIB_sectorType_mob     = 99;
//// TODO: TBD: excepting possibly for mobile respawn identification...
//// TODO: TBD: and then I think we simply identify a UUID variable on these assets indicating it is "respawn" and get the ID...

if (isServer) then {
    // Server side init
    [Q(KPLIB_updateMarkers), MFUNC(_onUpdateMarkers)] call CBA_fnc_addEventHandler;
};

if (_debug) then {
    ["[fn_eden_onPreInit] Initialized", "PRE] [EDEN", true] call KPLIB_fnc_common_log;
};

true;