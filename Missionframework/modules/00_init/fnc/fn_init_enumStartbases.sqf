/*
    KPLIB_fnc_init_enumStartbases

    File: fn_init_enumStartbases.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-24 20:22:14
    Last Update: 2021-01-24 20:22:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the start bases enumerated aligned with the _basename.
        Indexed bases are indexed consistent with asset creation algorithm, i.e. 0+ until there is a break

    Parameter(s):
        _basename - The base base name, defaults to "startbase"
            i.e. KPLIB_eden_[_basename]
            i.e. KPLIB_eden_[_basename][_[_i]], where _i is a zero based index

    Returns:
        The enumerated start bases
*/

params [
    ["_basename", "startbase"]
    , ["_startIndex", 0]
];

private _retval = [];

private _getStartAtNameAndIndex = {
    params [
        "_name"
        , "_i"
    ];

    if (isNil "_i") then {
        format ["KPLIB_eden_%1", _name];
    } else {
        format ["KPLIB_eden_%1_%2", _name, str _i];
    };
};

private _onAppendStart = {
    params [
        ["_x", ""]
    ];

    private _startbase = missionNamespace getVariable [_x, objNull];

    private _appended = false;

    if (!isNil "_startbase") then {
        if (!(isNull _startbase)) then {
            _retval pushBack [_x, _startbase];
            _appended = true;
        };
    };

    _appended;
};

// Append the default start base name if possible.
[[_basename] call _getStartAtNameAndIndex] call _onAppendStart;

private _i = _startIndex;

// Then iterate the sequence of start bases while available.
while {[[_basename, _i] call _getStartAtNameAndIndex] call _onAppendStart} do {
    _i = _i + 1;
};

_retval
