#include "script_component.hpp"
/*
    KPLIB_fnc_namespace_createSerializationRegistry

    File: fn_namespace_createSerializationRegistry.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-20 13:13:00
    Last Update: 2021-04-20 13:13:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Creates a new HASHMAP for purposes of registering VARIABLE NAMES for serialization
        purposes. The associated value is BOOL, true included, false excluded.

    Parameter(s):
        _variableNames - a single VARIABLE NAME or an ARRAY of zero or more names, to serialize
            [STRING|ARRAY, default: []]

    Returns:
        HASHMAP for use registering variable names [HASHMAP]
 */

params [
    [Q(_variableNames), [], ["", []]]
];

private _registry = createHashMap;

private _registered = [_registry, _variableNames] call MFUNC(_registerSerializationVars);

_registry;
