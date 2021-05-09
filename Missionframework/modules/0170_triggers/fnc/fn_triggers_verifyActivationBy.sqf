#include "script_component.hpp"
/*
    KPLIB_fnc_triggers_verifyActivationBy

    File: fn_triggers_verifyActivationBy.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 15:51:28
    Last Update: 2021-05-08 15:51:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Verifies the ACTIVATION BY component.

    Parameter(s):
        _by - the BY component [SIDE|STRING, default: sideEmpty]

    Returns:
        The verified ACTIVATION BY component [STRING]

    References:
        https://community.bistudio.com/wiki/setTriggerActivation
 */

params [
    [Q(_by), sideEmpty, [sideEmpty, ""]]
];

if (_by isEqualType sideEmpty) then {
    _by = [_by] call MFUNC(_sideToBy);
};

_by;
