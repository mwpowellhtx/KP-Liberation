/*
    KPLIB_fnc_namespace_clone

    File: fn_namespace_clone.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 19:11:38
    Last Update: 2021-03-19 19:11:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Clones a given namespace including opportunity to copy a nominal set of variables.

    Parameter(s):
        _template - a template CBA namespace [LOCATION, default: locationNull]
        _variableNamesToClone - a nominal set of variables to copy over [ARRAY, default: []]

    Returns:
        A cloned CBA namespace [LOCATION]

    References:
        http://cbateam.github.io/CBA_A3/docs/files/common/fnc_createNamespace-sqf.html
 */

params [
    ["_template", locationNull, [locationNull]]
    , ["_variableNamesToClone", [], [[]]]
    , ["_isGlobal", false, [false]]
];

private _clone = [] call CBA_fnc_createNamespace;

private _templateVariableNames = allVariables _template;

private _availableNamesToClone = _variableNamesToClone select { (toLower _x) in _templateVariableNames; };

{ _clone setVariable [_x, (_template getVariable _x)]; } forEach _availableNamesToClone;

_clone;
