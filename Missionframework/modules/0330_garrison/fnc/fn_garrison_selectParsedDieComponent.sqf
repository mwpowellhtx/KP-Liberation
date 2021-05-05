// TODO: TBD: started here but should probably refactor this one to core or common modules
/*
    KPLIB_fnc_garrison_selectParsedDieComponent

    File: fn_garrison_selectParsedDieComponent.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-28 22:35:44
    Last Update: 2021-04-28 22:35:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns a TARGET value from the DELIMITED VALUES at the INDEX corresponding
        to the RATIO times the COUNT TARGETS.

    Parameter(s):
        _delimitedValues - COMMA DELIMITED values from which to choose [STRING, default: ""]
        _componentRatio - component ratio targeting the delimited values [SCALAR, default: 0]
        _ascending - direction in which to sort [BOOL, default: true]
        _default - a default value [SCALAR, default: _defaultDefault]

    Returns:
        The values for the target HASHMAP [ARRAY]

    Reference:
        https://en.wikipedia.org/wiki/Language_Integrated_Query
 */

// TODO: TBD: this one should not be in LINQ per se...
// TODO: TBD: rather should be in garrison...
// TODO: TBD: also 'naming' is hard... 
private _defaultDefault = 0;

params [
    ["_delimitedValues", "", [""]]
    , ["_componentRatio", 0, [0]]
    , ["_ascending", true, [true]]
    , ["_default", _defaultDefault, [0]]
];

private _targets = _delimitedValues splitString ", " apply { parseNumber _x; } select { _x > 0; };

// Nothing to return but the default value
if (_targets isEqualTo []) exitWith {
    _default;
};

// No need to sort anything etc just return with it
if (count _targets == 1) exitWith {
    (_targets#0);
};

_targets sort _ascending;

_componentRatio = 0 max (_componentRatio min 1);

private _targetIndex = floor (_componentRatio * (count _targets));

private _target = _targets select _targetIndex;

_target;
