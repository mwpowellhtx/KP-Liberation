#include "script_component.hpp"
/*
    KPLIB_fnc_triggers_sideToDetectionType

    File: fn_triggers_sideToDetectionType.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 15:23:58
    Last Update: 2021-05-08 15:24:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Converts the SIDE to the ACTIVATION DETECTION TYPE. Defaults to
        KPLIB_preset_triggers_typePresent.

    Parameter(s):
        _side - converted to TRIGGER ACTIVATION DETECTION TYPE [SIDE, default: sudeEmpty]

    Returns:
        The ACTIVATION DETECTION TYPE [STRING]

    References:
        https://community.bistudio.com/wiki/setTriggerActivation
 */

params [
    [Q(_side), sideEmpty, [sideEmpty]]
];

switch (_side) do {
    case (east):        { MPRESET(_typeEastDetection);  };
    case (west):        { MPRESET(_typeWestDetection);  };
    case (resistance):  { MPRESET(_typeGuerDetection);  };
    case (civilian):    { MPRESET(_typeCivDetection);   };
    default             { MPRESET(_typePresent);        };
};
