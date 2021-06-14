#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_presets

    File: fn_hudSector_presets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-28 10:55:46
    Last Update: 2021-06-14 17:02:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges for the nominal module preset variables.

    Parameters:
        NONE

    Returns:
        The callback has finished [BOOL]
 */

if (isServer) then {
    // Server section

    MPRESETUI(_meters)                                  = [
        "units"
        , Q(tanks)
        , Q(civres)
    ];

    publicVariable QMPRESETUI(_meters);

    MPRESETUI(_preserveVars)                            = [
        [Q(KPLIB_hud_reportUuid), ""]
        , [QMVAR(_ack), false]
    ];
};

if (hasInterface) then {
    // Client side section

    // // TODO: TBD: see usage of SUBSCRIBE during POST INIT
    // MPRESET(_reportUuid)                                = [] call KPLIB_fnc_uuid_create_string;
};

true;
