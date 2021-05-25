#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_presets

    File: fn_fobs_presets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-18 11:31:16
    Last Update: 2021-05-23 14:03:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges the module presets.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAM(_presets_debug);

if (_debug) then {
    ["[fn_fobs_presets] Entering...", "FOBS", true] call KPLIB_fnc_common_log;
};

MPRESET(_boxClassNames)                             = [
    KPLIB_preset_fobBoxF
    , KPLIB_preset_fobTruckF
];

if (isServer) then {
    // Server side presets
    MPRESET(_markerType)                            = Q(b_hq);
    MPRESET(_markerSize)                            = [1.5, 1.5];
    MPRESET(_markerColor)                           = Q(ColorYellow);
    MPRESET(_hudColor)                              = [0.85, 0.85, 0, 1];
    MPRESET(_markerPath)                            = "\a3\ui_f\data\map\markers\nato\b_hq.paa";
    MPRESET(_markerPrefix)                          = QMVAR(_marker_);
    MPRESET(_boxOrTruckVectorOffset)                = [0, 0, 0.1];
};

if (_debug) then {
    ["[fn_fobs_presets] Fini", "FOBS", true] call KPLIB_fnc_common_log;
};

true;
