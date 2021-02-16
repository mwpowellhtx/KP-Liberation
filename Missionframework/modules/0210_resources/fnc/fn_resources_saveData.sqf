/*
    KPLIB_fnc_resources_saveData

    File: fn_resources_saveData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-12-13
    Last Update: 2019-04-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Fetches data which is bound to this module and send it to the global save data array.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

private _debug = KPLIB_param_savedebug;

if (_debug) then {
    ["Resources module saving...", "SAVE"] call KPLIB_fnc_common_log;
};

/* Effectively from this point forward we ignore this bit... Instead we will depend on serialized
 * variables to relay the summary for each object. This much as been entirely refactored in terms
 * of persistent objects (i.e. storage containers), and 'KPLIB_resources_storageValue' persistent
 * variables. */

// TODO: TBD: may eventually just drop this, but for now will leave it in for 'compatibility' reasons with on going dev testing...
private _storageContainerStorageValueState = [];

// Set module data to save and send it to the global save data array
["resources",
    [
        _storageContainerStorageValueState,
        KPLIB_resources_intel
    ]
] call KPLIB_fnc_init_setSaveData;

true
