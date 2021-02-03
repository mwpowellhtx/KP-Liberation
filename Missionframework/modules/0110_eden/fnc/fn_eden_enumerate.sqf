/*
    KPLIB_fnc_eden_enumerate

    File: fn_eden_enumerate.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 12:28:54
    Last Update: 2021-01-28 12:28:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the enumerated Eden bits aligned with the _basename. Indexed Eden bits
        consistent with asset creation algorithm, i.e. 0+ until there is a break.

    Parameters:
        _basename - The base base name, defaults to "startbase"
            i.e. KPLIB_eden_[_basename]
            i.e. KPLIB_eden_[_basename][_[_i]], where _i is a zero based index

    Returns:
        The enumerated start bases
*/

// TODO: TBD: do not know what's falling over here, but something is falling over...
// TODO: TBD: so, will start with a simple "create ops" that takes the "known" marker for the time being...
// TODO: TBD: then cook up a proto function bit by bit and verify each step...

["[fn_eden_enumerate] Entering...", "EDEN", true] call KPLIB_fnc_common_log;

//private _dep = [
//    "KPLIB_sectorType_eden"
//    , "KPLIB_preset_sideF"
//];

//waitUntil {
//    _dep = _dep select {isNil _x};
//    _dep isEqualTo [];
//};

params [
    ["_basename", "startbase", [""]]
];

// TODO: TBD: reconsider the shape of startbases... uses the proxy as the start, but that's it...
// [uuid, est, pos, markerName, markerText, proxyName]
// which proxyName is still useful when looking up variables...
private _retval = [];
private _defaultVarName = [] call KPLIB_fnc_eden_getNameAtIndex;

private _tryOnAppend = {

    params [
        ["_varName", _defaultVarName, [""]]
    ];

    private _count = count _retval;

    private _eden = [_varName] call KPLIB_fnc_eden_create;

    // TODO: TBD: this verification may be oversimplified
    if (!(_eden isEqualTo [])) then {
        _retval pushBack _eden;
    };

    count _retval > _count;
};

[format ["[fn_eden_enumerate] _tryOnAppend default proxy"], "EDEN", true] call KPLIB_fnc_common_log;

// Remember to also enumerate the default one.
[[] call KPLIB_fnc_eden_getNameAtIndex] call _tryOnAppend;

private _i = 0;
private _enumerating = true;

// Then we can pick up any others...
while {_enumerating} do {

    [format ["[fn_eden_enumerate] proxy[%1] call _tryOnAppend", _i], "EDEN", true] call KPLIB_fnc_common_log;

    _enumerating = [[_i] call KPLIB_fnc_eden_getNameAtIndex] call _tryOnAppend;
    _i = _i + 1;
};

{[_x] call KPLIB_fnc_eden_createOrUpdateMarker} forEach _retval;

["[fn_eden_enumerate] Fini", "EDEN", true] call KPLIB_fnc_common_log;

_retval
