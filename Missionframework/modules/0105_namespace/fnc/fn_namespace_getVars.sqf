/*
    KPLIB_fnc_namespace_getVars

    File: fn_namespace_getVars.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-05 08:09:28
    Last Update: 2021-03-05 15:58:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Retrieves the member variables that make working with a CBA namespace what it is.
        We get the variables in the namespace for use throughout the state machine, for
        instance. If the caller does not need all of them, then do not use them.

    Parameter(s):
        _namespace - a CBA namespace [LOCATION || OBJECT, default: locationNull]
        _nameValuePairs - name and default value associative pairs to retrieve [ARRAY, default: []]

    Returns:
        An array of the namespace member variables for use throughout [ARRAY]
 */

params [
    ["_namespace", locationNull, [objNull, locationNull]]
    , ["_nameValuePairs", [], [[]]]
];

private _onGetNamespaceMember = {
    _x params [
        ["_variableName", "", [""]]
        , "_defaultValue"
    ];
    private _args = [_variableName, _defaultValue];
    if (isNil "_defaultValue") exitWith { _args = _variableName; };
    _namespace getVariable _args;
};

private _retval = _nameValuePairs apply _onGetNamespaceMember;

_retval;
