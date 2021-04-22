#include "script_component.hpp"
/*
    KPLIB_fnc_namespace_serialize

    File: fn_namespace_serialize.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-20 12:47:25
    Last Update: 2021-04-20 12:47:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Serializes the NAMESPACE to an associative array of VARIABLE NAME and VALUE pairs.

    Parameter(s):
        _namespace - a CBA namespace being serialized [LOCATION, default: locationNull]
        _registry - serialization registry HASHPAM [HASHMAP, default: emptyHashMap]

    Returns:
        An associative array of VARIABLE NAME and VALUE pairs [ARRAY]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
    , [Q(_registry), emptyHashMap, [emptyHashMap]]
];

private _allVariables = allVariables _namespace;

private _availableKeys = keys _registry;

private _serializeKeys = _availableKeys select {
    (toLower _x in _allVariables)
        && (_registry getOrDefault [_x, false]);
};

_serializeKeys apply { [_x, _namespace getVariable _x]; };
