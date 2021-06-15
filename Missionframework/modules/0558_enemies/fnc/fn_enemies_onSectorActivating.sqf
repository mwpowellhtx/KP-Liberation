#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_onSectorActivating

    File: fn_enemies_onSectorActivating.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 15:54:21
    Last Update: 2021-06-14 17:17:22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to SECTOR ACTIVATING event with ENEMY module related bits.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: [locationNull]]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/typeOf
        https://community.bistudio.com/wiki/configOf
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorActivating_debug)
    || (_sector getVariable [QMVAR(_onSectorActivating_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];

if (_debug) then {
    [format ["[fn_enemies_onSectorActivating] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "ENEMIES", true] call KPLIB_fnc_common_log;
};

/* Set the CIVILIAN REPUTATION REWARD afresh with every ACTIVATION; thereby allowing
 * for CBA settings to have been updated since the last life cycle.
 */
private _capReward = [_sector] call MFUNC(_getSectorCaptureReward);
_sector setVariable [QMVAR(_civRepReward), _capReward];

if (_debug) then {
    [format ["[fn_enemies_onSectorActivating] Fini: [_capReward]: %1"
        , str [_capReward]], "ENEMIES", true] call KPLIB_fnc_common_log;
};

true;
