#include "script_component.hpp"
/*
    KPLIB_fnc_aidWoundedCivs_onSectorCaptured

    File: fn_aidWoundedCivs_onSectorCaptured.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 15:07:30
    Last Update: 2021-04-26 15:07:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        SECTOR CAPTURED event handler, may kick off an AID WOUNDED CIVILIANS mission.

    Parameter(s):
        _namespace - the CBA SECTOR namespace which was captured [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorCaptured_debug)
    || (_namespace getVariable [QMVAR(_onSectorCaptured_debug), false]);

[
    MPARAM(_aidCount)
    , MPARAM(_aidReward)
    , _namespace getVariable [Q(KPLIB_sectors_markerName), ""]
    , _namespace getVariable [Q(KPLIB_enemy_civRepReward), 0]
] params [
    Q(_aidCount)
    , Q(_aidReward)
    , Q(_markerName)
    , Q(_civRepReward)
];

if (_debug) then {
    [format ["[fn_aidWoundedCivs_onSectorCaptured] Entering: [_markerName, markerText _markerName, _aidReward, _aidCount, _civRepReward]: %1"
        , str [_markerName, markerText _markerName, _aidReward, _aidCount, _civRepReward]], "AIDWOUNDEDCIVS", true] call KPLIB_fnc_common_log;
};

// Do not evaluate for other than CITY+METROPOLIS sectors
if (!(_markerName in (KPLIB_sectors_city + KPLIB_sectors_metropolis))) exitWith {
    if (_debug) then {
        [format ["[fn_aidWoundedCivs_onSectorCaptured] No wounded to aid: [_markerName, markerText _markerName]: %1"
            , str [_markerName, markerText _markerName]], "AIDWOUNDEDCIVS", true] call KPLIB_fnc_common_log;
    };
    true;
};

private _netReward = _civRepReward + (_aidReward * _aidCount);

// Unable to AID CIVILIANS when prohibited by lack of REWARD+PENALTY EQUITY
if ((_aidReward == 0 && _civRepReward < 0) || (_aidReward > 0 && _netReward > 0)) exitWith {
    if (_debug) then {
        [format ["[fn_aidWoundedCivs_onSectorCaptured] Disqualified: [_markerName, markerText _markerName, _aidCount, _aidReward, _civRepReward, _netReward]: %1"
            , str [_markerName, markerText _markerName, _aidCount, _aidReward, _civRepReward, _netReward]], "AIDWOUNDEDCIVS", true] call KPLIB_fnc_common_log;
    };
    true;
};

switch (true) do {

    // Zero the COUNT when necessary
    case (_civRepReward < 0 && _aidReward == 0): {
        _aidCount = 0;
    };

    // Normalize the COUNT based on the NET REWARD
    case (_aidReward > 0 && _netReward > _civRepReward): {
        _aidCount = _aidCount min (floor ((_netReward max 0) / _aidReward));
    };
};

// TODO: TBD: generate the wounded civs...
// TODO: TBD: should also come up with a refactor icon for it...
// TODO: TBD: this also affords us an opportunity to consider how to schedule missions
// TODO: TBD: allowing for multiple missions, singleton missions, etc

if (_debug) then {
    [format ["[fn_aidWoundedCivs_onSectorCaptured] Fini: [_markerName, markerText _markerName, _aidCount]: %1"
        , str [_markerName, markerText _markerName, _aidCount]], "AIDWOUNDEDCIVS", true] call KPLIB_fnc_common_log;
};

true;
