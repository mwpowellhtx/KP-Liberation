#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_onSectorCaptured

    File: fn_enemies_onSectorCaptured.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 15:50:12
    Last Update: 2021-04-26 14:19:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to SECTOR CAPTURED event with ENEMY module related bits. Marks buildings
        as ALREADY COUNTED, which, although is a module object variable, should only affect
        this function. This is important to avoid double counting buildings that may land
        within overlapping sector ranges.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: [locationNull]]

    Returns:
        The event handler finished [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorCaptured_debug)
    || (_namespace getVariable [QMVAR(_onSectorCaptured_debug), false]);

[
    _namespace getVariable [Q(KPLIB_sectors_markerName), ""]
    , _namespace getVariable [QMVAR(_civRepReward), 0]
] params [
    Q(_markerName)
    , Q(_civRepReward)
];

if (_debug) then {
    [format ["[fn_enemies_onSectorCaptured] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "ENEMIES", true] call KPLIB_fnc_common_log;
};

[[_markerName] call MFUNC(_getSectorCaptureReward)] call {
    params [
        [Q(_sectorReward), 0, [0]]
    ];

    if (_debug) then {
        [format ["[fn_enemies_onSectorCaptured::call] Reward: [_markerName, markerText _markerName, _civRepReward, _sectorReward]: %1"
            , str [_markerName, markerText _markerName, _civRepReward, _sectorReward]], "ENEMIES", true] call KPLIB_fnc_common_log;
    };

    [_sectorReward] call MFUNC(_addCivRep);

    _namespace setVariable [QMVAR(_civRepReward), _civRepReward + _sectorReward];
};

if (_debug) then {
    [format ["[fn_enemies_onSectorCaptured] Fini: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "ENEMIES", true] call KPLIB_fnc_common_log;
};

true;
