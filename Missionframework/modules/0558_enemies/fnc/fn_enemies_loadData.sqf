#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_loadData

    File: fn_enemies_loadData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-05-25 22:28:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads the bundle of module data.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
 */

private _debug = KPLIB_param_debug;

if (_debug) then {
    ["[fn_enemies_loadData] Loading...", "SAVE"] call KPLIB_fnc_common_log;
};

private _moduleData = ["enemy"] call KPLIB_fnc_init_getSaveData;

// Check if there is a new campaign
if (_moduleData isEqualTo []) then {
    if (_debug) then {
        ["[fn_enemies_loadData] Initializing data...", "SAVE"] call KPLIB_fnc_common_log;
    };
    MVAR(_strength) = MPARAM(_defaultStrength);
    MVAR(_awareness) = MPARAM(_defaultAwareness);
    MVAR(_civRep) = MPARAM(_defaultCivRep);
} else {
    // Otherwise start applying the saved data
    if (_debug) then {
        ["[fn_enemies_loadData] Applying data...", "SAVE"] call KPLIB_fnc_common_log;
    };

    _moduleData params [
        [Q(_strength), MPARAM(_defaultStrength)]
        , [Q(_awareness), MPARAM(_defaultAwareness)]
        , [Q(_civRep), MPARAM(_defaultCivRep)]
    ];

    MVAR(_strength) = _strength;
    MVAR(_awareness) = _awareness;
    MVAR(_civRep) = _civRep;
};

publicVariable QMVAR(_strength);
publicVariable QMVAR(_awareness);
publicVariable QMVAR(_civRep);

if (_debug) then {
    ["[fn_enemies_loadData] Loaded", "SAVE"] call KPLIB_fnc_common_log;
};

true;
