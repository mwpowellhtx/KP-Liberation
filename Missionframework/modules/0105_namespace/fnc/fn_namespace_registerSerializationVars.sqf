#include "script_component.hpp"
/*
    KPLIB_fnc_namespace_registerSerializationVars

    File: fn_namespace_registerSerializationVars.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-20 13:19:38
    Last Update: 2021-04-20 13:19:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Registers zero or more serialization variable names.

    Parameter(s):
        _registry - a HASHMAP registry [HASHMAP, default: emptyHashMap]
        _variableNames - a single VARIABLE NAME or an ARRAY of zero or more names, to serialize
            [STRING|ARRAY, default: []]
        _reg - whether to REGISTER or UNREGISTER [BOOL, default: true]

    Returns:
        The number of variables registered [SCALAR]
 */

params [
    [Q(_registry), emptyHashMap, [emptyHashMap]]
    , [Q(_variableNames), [], ["", []]]
    , [Q(_reg), true, [true]]
];

// May receive a single VARIABLE NAME or an ARRAY of names
_variableNames = switch (true) do {
    case (_variableNames isEqualType []): { _variableNames; };
    case (_variableNames isEqualType ""): { [_variableNames]; };
    default { []; };
};

private _registered = ({ _registry set [_x, _reg]; true; } count _variableNames);

_registered;
