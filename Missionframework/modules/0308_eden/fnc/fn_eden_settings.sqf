#include "script_component.hpp"
/*
    KPLIB_fnc_eden_settings

    File: fn_eden_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-15 10:45:23
    Last Update: 2021-05-21 01:04:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges for module settings.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

// TODO: TBD: refactor in the settings to proper "start base" or "eden" section...
// TODO: TBD: also identify other settings that may be the same or similar, i.e. "start base radius"
// Some assets may be moved to the flight deck using this parameter
[
    QMPARAM(_assetMoveRange)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_GENERAL_ASSET_MOVE_RANGE"
        , localize "STR_KPLIB_SETTINGS_GENERAL_ASSET_MOVE_RANGE_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_GENERAL"
    , [10, 100, 20, 0] // range: [10, 100], default: 20
    , 2
    , {}
] call CBA_fnc_addSetting;

// KPLIB_param_opsRange
// Operational buffer zone around the Operations base
// Default: 500 meters
[
    QMPARAM(_startbaseRadius)
    , "SLIDER"
    , [localize "STR_KPLIB_SETTINGS_GENERAL_STARTBASE_RADIUS", localize "STR_KPLIB_SETTINGS_GENERAL_STARTBASE_RADIUS_TT"]
    , localize "STR_KPLIB_SETTINGS_GENERAL"
    , [100, 1000, 500, 0]
    , 1
    , {}
] call CBA_Settings_fnc_init;

[
    QMPARAM(_flightDeckRadius)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_GENERAL_FLIGHT_DECK_RADIUS"
        , localize "STR_KPLIB_SETTINGS_GENERAL_FLIGHT_DECK_RADIUS_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_GENERAL"
    , [10, 30, 15, 0] // range: [10, 30], default: 15
    , 2
    , {}
] call CBA_fnc_addSetting;

/*
 The Eden markerType is the mil_start icon.
 23. Start / "mil_start"
 https://community.bistudio.com/wiki/CfgMarkers#Arma_3
*/
MPRESET(_markerType)                        = Q(mil_start);

//// TODO: TBD: assumes only one such marker...
//// TODO: TBD: what happens when there are several mobile respawn assets in play?
//// TODO: TBD: should at least be a function, possibly returning an array (?)
//// TODO: TBD: will have to investigate usage...

// Respawn position shortcut
MVAR(_respawnPos)                           = markerPos Q(respawn);

if (isServer) then {

    MPARAM(_onPreInit_debug)                = false;
    MPARAM(_onPostInit_debug)               = false;
    MPARAM(_getSectorIcon_debug)            = false;
};

true;
