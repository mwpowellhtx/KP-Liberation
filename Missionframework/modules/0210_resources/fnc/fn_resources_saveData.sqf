#include "script_component.hpp"
/*
    KPLIB_fnc_resources_saveData

    File: fn_resources_saveData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-13
    Last Update: 2021-04-26 12:15:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Relays a bundle of module data for saving.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAM(_saveData_debug);

if (_debug) then {
    ["[fn_resources_saveData] Saving...", "SAVE"] call KPLIB_fnc_common_log;
};

/* Effectively from this point forward we ignore this bit... Instead we will depend on serialized
 * variables to relay the summary for each object. This much as been entirely refactored in terms
 * of persistent objects (i.e. storage containers), and 'KPLIB_resources_storageValue' persistent
 * variables. */

// TODO: TBD: may eventually just drop this, but for now will leave it in for 'compatibility' reasons with on going dev testing...
private _storageContainerStorageValueState = [];

// Set module data to save and send it to the global save data array
["resources"
    , [
        _storageContainerStorageValueState
        , MVAR(_intel)
    ]
] call KPLIB_fnc_init_setSaveData;

if (_debug) then {
    ["[fn_resources_saveData] Saved", "SAVE"] call KPLIB_fnc_common_log;
};

true;
