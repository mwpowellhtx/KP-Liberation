#include "script_component.hpp"
/*
    KPLIB_fnc_triggers_sideToBy

    File: fn_triggers_sideToBy.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 14:56:03
    Last Update: 2021-05-08 14:56:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the ACTIVATION component informing the TRIGGER BY configuration.

    Parameter(s):
        _side - returns the TRIGGER ACTIVATION BY component elements [SIDE, default: sudeEmpty]

    Returns:
        The ACTIVATION componeng informing the TRIGGER BY component [STRING]

    References:
        https://community.bistudio.com/wiki/setTriggerActivation
 */

params [
    [Q(_side), sideEmpty, [sideEmpty]]
];

switch (_side) do {
    case (east):        { MPRESET(_bySideEast);         };
    case (west):        { MPRESET(_bySideWest);         };
    case (resistance):  { MPRESET(_bySideGuer);         };
    case (civilian):    { MPRESET(_bySideCiv);          };
    case (sideLogic):   { MPRESET(_bySideLogic);        };
    default             { MPRESET(_bySideAnyPlayer);    };
};
