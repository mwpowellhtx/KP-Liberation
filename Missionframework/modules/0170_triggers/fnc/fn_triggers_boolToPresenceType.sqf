#include "script_component.hpp"
/*
    KPLIB_fnc_triggers_boolToPresenceType

    File: fn_triggers_boolToPresenceType.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 15:18:45
    Last Update: 2021-05-08 15:18:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the TRIGGER ACTIVATION PRESENCE TYPE corresponding to the value.

    Parameter(s):
        _value - converted to ACTIVATION PRESENCE TYPE [BOOL, default: false]

    Returns:
        The TRIGGER ACTIVATION PRESENCE TYPE corresponding to the value [STRING]

    References:
        https://community.bistudio.com/wiki/setTriggerActivation
 */

params [
    [Q(_present), false, [false]]
];

if (_present) then {
    MPRESET(_typePresent);
} else {
    MPRESET(_typeNotPresent);
};
