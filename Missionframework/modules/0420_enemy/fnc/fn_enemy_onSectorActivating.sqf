#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_onSectorActivating

    File: fn_enemy_onSectorActivating.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 15:54:21
    Last Update: 2021-04-26 13:28:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to SECTOR ACTIVATING event with ENEMY module related bits.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: [locationNull]]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/typeOf
        https://community.bistudio.com/wiki/configOf
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAM(_onRegisterBuildings_debug)
    || (_namespace getVariable [QMVAR(_onRegisterBuildings_debug), false]);

[
    _namespace getVariable [Q(KPLIB_sectors_markerName), ""]
] params [
    Q(_markerName)
];

if (_debug) then {
    [format ["[fn_enemy_onSectorActivating] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "ENEMY", true] call KPLIB_fnc_common_log;
};

// Note the buildings in the namespace for future reference
_namespace setVariable [QMVAR(_civRepReward), 0];

if (_debug) then {
    [format ["[fn_enemy_onSectorActivating] Fini: [_markerName, markerText _markerName, count _buildings]: %1"
        , str [_markerName, markerText _markerName, count _buildings]], "ENEMY", true] call KPLIB_fnc_common_log;
};

true;
