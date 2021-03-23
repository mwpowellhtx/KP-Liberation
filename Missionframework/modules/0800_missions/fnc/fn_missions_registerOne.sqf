#include "script_component.hpp"
/*
    KPLIB_fnc_missions_registerOne

    File: fn_missions_registerOne.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 17:28:36
    Last Update: 2021-03-22 12:51:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Registers ONE either MISSION TEMPLATE or RUNNING MISSION, it matters not which.
        Uses the same UUID in either instance, but be careful to always also discern
        the corresponding STATUS, and sometimes also TEMPLATE UUID, depending upon the
        situation.

    Parameter(s):
        _mission - a CBA MISSION namespace to register [LOCATION, default: locationNull]

    Returns:
        Whether the MISSION was successfully registered [SCALAR]

    References:
        https://community.bistudio.com/wiki/in
        https://community.bistudio.com/wiki/keys
        https://community.bistudio.com/wiki/set
        https://community.bistudio.com/wiki/getOrDefault
        https://community.bistudio.com/wiki/Category:Command_Group:_HashMap
 */

params [
    [Q(_mission), locationNull, [locationNull]]
];

// Always register according to MISSION UUID
private _targetUuid = _mission getVariable [QMVAR(_uuid), ""];

// Already registered so return early
if (!isNull (MSVAR(_registry) getOrDefault [_targetUuid, locationNull])) exitWith {
    true;
};

// Or register when not already registered
MSVAR(_registry) set [_targetUuid, _mission];

// Verify afterwards
_targetUuid in (keys MSVAR(_registry));
