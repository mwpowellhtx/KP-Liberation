#include "script_component.hpp"
/*
    KPLIB_fnc_triggers_verifyActivationType

    File: fn_triggers_verifyActivationType.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 15:49:38
    Last Update: 2021-05-08 15:49:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Verifies the ACTIVATION BY component.

    Parameter(s):
        _type - the TYPE component [SIDE|BOOL|STRING, default: true]

    Returns:
        The verified ACTIVATION TYPE component [STRING]

    References:
        https://community.bistudio.com/wiki/setTriggerActivation
 */

params [
    [Q(_type), true, [sideEmpty, true, ""]]
];

if (_type isEqualType true) then {
    _type = [_type] call MFUNC(_boolToPresenceType);
};

if (_type isEqualType sideEmpty) then {
    _type = [_type] call MFUNC(_sideToDetectionType);
};

_type;
