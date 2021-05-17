#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onLoadData

    File: fn_sectors_onLoadData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 11:58:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Deserializes the module NAMESPACES during load events. We also reconcile
        the loaded namespaces with current sector names.

    Parameters:
        NONE

    Returns:
        NONE
 */

private _debug = MPARAM(_onLoadData_debug);

if (_debug) then {
    ["[fn_sectors_onLoadData] Loading...", "SECTORS"] call KPLIB_fnc_common_log;
};

private _moduleData = +(["sectors"] call KPLIB_fnc_init_getSaveData);
private _namespaces = [];

// Check if there is a new campaign
if (_moduleData isEqualTo []) then {
    if (_debug) then {
        ["[fn_sectors_onLoadData] Initializing...", "SECTORS"] call KPLIB_fnc_common_log;
    };
} else {
    // Otherwise start applying the saved data
    if (_debug) then {
        ["[fn_sectors_onLoadData] Loading...", "SECTORS"] call KPLIB_fnc_common_log;
    };

    _moduleData params [
        [Q(_data), [], [[]]]
    ];

    // Loading up the saved CBA SECTOR NAMESPACES
    _namespaces = _data apply { [_x] call KPLIB_fnc_namespace_deserialize; };
};

private _reconciled = [_namespaces] call MFUNC(_onReconcileSectors);

MVAR(_namespaces) = _reconciled;

if (_debug) then {
    [format ["[fn_sectors_onLoadData] Fini: [count _namespaces, count _reconciled]: %1"
        , str [count _namespaces, count _reconciled]], "SECTORS"] call KPLIB_fnc_common_log;
};

true;
