/*
    KPLIB_fnc_resources_storeCrate

    File: fn_resources_storeCrate.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-15
    Last Update: 2021-02-23 13:50:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Stores the crate in the '_targetStorage' or nearby storage area.

    Parameter(s):
        _crate - Crate which should be stored [OBJECT, default: objNull]
        _targetStorage - the target storage container or transport used to receive the '_crate' [OOBJECT, default: objNull]
        _cid - client identifier for purposes of notifying the player [SCALAR, default: -1]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_crate", objNull, [objNull]]
    , ["_targetStorage", objNull, [objNull]]
    , ["_cid", -1, [0]]
];

// Exit if we have no valid crate object
if (!((typeOf _crate) in KPLIB_resources_crateClasses)) exitWith {
    false;
};

if (isNull _targetStorage) then {
    // Check for near storages
    private _nearStorage = nearestObjects [_crate, KPLIB_resources_storageClasses, KPLIB_param_resources_loadRange];

    // Exit if no storages near
    if (_cid >= 0 && (_nearStorage isEqualTo [])) exitWith {
        [localize "STR_KPLIB_HINT_NOSTORAGENEAR"] call KPLIB_fnc_notification_hint;
        false;
    };

    // Select nearest storage
    _targetStorage = _nearStorage#0;
};

// Get storage position array depending on storage type
private _attachPosition = [typeOf _targetStorage] call KPLIB_fnc_resources_getAttachArray;
// Get number of already stored crates
private _attachedCrates = [_targetStorage] call KPLIB_fnc_resources_getAttachedCrates;

// Exit if the nearest storage has no more space
if ((count _attachedCrates) >= (count _attachPosition)) exitWith {

    // TODO: TBD: this was fine, but it may be interesting to also report storage sitrep with that...
    if (_cid >= 0) then {
        [localize "STR_KPLIB_HINT_NOSTORAGESPACE"] call KPLIB_fnc_notification_hint;

        //[format [localize "STR_KPLIB_HINT_STORAGE_CONTAINER_NO_SPACE"
        //    , _attachedCrates, count _attachPosition]] call KPLIB_fnc_notification_hint;
    };

    false
};

// Get the correct attachTo position from the array, tricky to remember also count here
_attachPosition = _attachPosition select (count _attachedCrates);

// TODO: TBD: can probably do a similar thing re: "load" vs. "store"...
// TODO: TBD: and then I think we consolidate the nature of it...
// Attach crate to storage
_crate attachTo [_targetStorage, [
    (_attachPosition#0)
    , (_attachPosition#1)
    , [typeOf _crate] call KPLIB_fnc_resources_getCrateZ
]];

[_targetStorage] call KPLIB_fnc_resources_onAttachedCratesChanged;

// TODO: TBD: yes, it is necessary to attach the crate... and to disable attaching ropes to attached crates...
// TODO: TBD: We need to test, if this on/off is really necessary.
// [_crate, false] remoteExecCall ["enableRopeAttach", true];

true;
