#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_loadData

    File: fn_enemy_loadData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-04-05 21:17:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads data which is bound to this module from the given save data or initializes needed data for a new campaign.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
 */

private _debug = KPLIB_param_debug;

if (_debug) then {
    ["Enemy module loading...", "SAVE"] call KPLIB_fnc_common_log;
};

private _moduleData = ["enemy"] call KPLIB_fnc_init_getSaveData;
// TODO: TBD: if we were going to work with STATE at all...
// TODO: TBD: would be better to connect via de-con local var default values...
private _state = Q(unaware);

// Check if there is a new campaign
if (_moduleData isEqualTo []) then {
    if (_debug) then {
        ["Enemy module data empty, creating new data...", "SAVE"] call KPLIB_fnc_common_log;
    };
} else {
    // Otherwise start applying the saved data
    if (_debug) then {
        ["Enemy module data found, applying data...", "SAVE"] call KPLIB_fnc_common_log;
    };

    _moduleData params [
        [Q(_strength), MPARAM(_defaultStrength)]
        , [Q(_awareness), MPARAM(_defaultAwareness)]
        , [Q(_stateModuleDatum), Q(unaware)]
    ];

    MVAR(_strength) = _strength;
    MVAR(_awareness) = _awareness;

    // // TODO: TBD: we are walking away from this one...
    // // TODO: TBD: and toward sector-specific CBA state machine
    _state = _stateModuleDatum;
};

// // // TODO: TBD: transitioning to proper SECTORS based CBA state machine
// // Start commander FSM
// [_state] call MFUNC(_commanderLogic);

true;
