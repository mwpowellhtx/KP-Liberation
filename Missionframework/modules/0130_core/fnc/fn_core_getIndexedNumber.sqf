/*
    KPLIB_fnc_core_getIndexedNumber

    File: fn_core_getIndexedNumber.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-28 22:35:44
    Last Update: 2021-05-05 11:48:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns a selected TARGET corresponding to the INDEX RATIO. TARGETS
        may be a STRING of delimited values or an ARRAY.

    Parameter(s):
        _targets - an ARRAY or STRING of COMMA DELIMITED values from which to choose
            [STRING, default: ""]
        _indexRatio - range [0, 1] ratio used to index the targets [SCALAR, default: 0]
        _ascending - direction in which to sort [BOOL, default: true]
        _delim - delimiters for use during STRING splits [STRING, default: ', ']
        _default - a default value [SCALAR, default: _defaultDefault]

    Returns:
        The values for the target HASHMAP [ARRAY]

    Reference:
        https://en.wikipedia.org/wiki/Language_Integrated_Query
 */

private _defaultDefault = 0;

params [
    ["_targets", "", ["", []]]
    , ["_indexRatio", 0, [0]]
    , ["_ascending", true, [true]]
    , ["_delim", ", ", [""]]
    , ["_default", _defaultDefault, [0]]
];

// Nothing to return but the default value
if (_targets isEqualTo "" || _targets isEqualTo []) exitWith {
    _default;
};

// Translate in terms of either STRING or ARRAY
_targets = switch (true) do {
    case (_targets isEqualType ""): {
        _targets splitString _delim apply { parseNumber _x; } select { _x > 0; }
    };
    case (_targets isEqualType []);
    default { _targets; }
};

// No need to sort anything etc just return with it
if (count _targets == 1) exitWith {
    (_targets#0);
};

_targets sort _ascending;

_indexRatio = 0 max (_indexRatio min 1);

private _targetIndex = floor (_indexRatio * (count _targets));

private _target = _targets select _targetIndex;

_target;
