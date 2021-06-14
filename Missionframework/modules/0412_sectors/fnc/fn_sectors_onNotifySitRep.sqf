#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onNotifySitRep

    File: fn_sectors_onNotifySitRep.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-29 19:13:10
    Last Update: 2021-06-14 16:51:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Orders the NAMESPACES by proximity to the PLAYER and notifies that PLAYER
        of the nearest possible SITREP.

    Parameter(s):
        _player - a PLAYER object [OBJECT, default: objNull]
        _namespaces - an array of the CBA SECTOR namespaces [ARRAY, default: KPLIB_sectors_namespaces]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/position
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_targetEvent-sqf.html
 */

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_namespaces), MVAR(_namespaces), []]
];

private _nearestSector = _player getVariable [QMVAR(_nearestSector), ""];

private _nearestNamespaces = _namespaces select {
    _nearestSector == (_x getVariable [QMVAR(_markerName), ""]);
};

_nearestNamespaces params [
    [Q(_nearestNamespace), locationNull, [locationNull]]
];

private _debug = MPARAM(_onNotifySitRep_debug)
    || (_player getVariable [QMVAR(_onNotifySitRep_debug), false])
    || (_nearestNamespace getVariable [QMVAR(_onNotifySitRep_debug), false])
    ;

if (_debug) then {
    [format ["[fn_sectors_onNotifySitRep] Entering: [isNull _player, count _namespaces, isNull _nearestNamespace]: %1"
        , str [isNull _player, count _namespaces, isNull _nearestNamespace]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// Get the SECTOR SITREP and install it in terms of the SECTOR HUD for delivery purposes
private _sitRep = [_nearestNamespace] call MFUNC(_getSectorSitRep);

// Set the PLAYER SECTOR HUD SITREP one way or another
if (_sitRep isEqualTo []) then {
    _player setVariable [Q(KPLIB_hudSector_sitRep), nil, true];
} else {
    _player setVariable [Q(KPLIB_hudSector_sitRep), _sitRep, true];
};

if (_debug) then {
    [format ["[fn_sectors_onNotifySitRep] Fini: [_sitRep]: %1"
        , str [_sitRep]], "SECTORS", true] call KPLIB_fnc_common_log;
};

true;
