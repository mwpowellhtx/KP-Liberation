#include "script_component.hpp"
/*
    KPLIB_fnc_missions_registerOne

    File: fn_missions_registerOne.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 17:28:36
    Last Update: 2021-03-20 17:28:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Registers ONE MISSION TEMPLATE. Adds the TEMPLATE to the known MISSIONS if it was
        not already there. Also sets the instance in the HASHMAP for faster lookup later on.

    Parameter(s):
        _namespace - a CBA MISSION namespace to register [LOCATION, default: locationNull]

    Returns:
        The index of the registered MISSION namespace [SCALAR]

    References:
        https://community.bistudio.com/wiki/in
        https://community.bistudio.com/wiki/keys
        https://community.bistudio.com/wiki/set
        https://community.bistudio.com/wiki/getOrDefault
        https://community.bistudio.com/wiki/Category:Command_Group:_HashMap
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

([_namespace, [
    [QMVAR(_templateUuid), ""]
]] call KPLIB_fnc_namespace_getVars) params [
    Q(_targetUuid)
];

private [Q(_namespaceIndex)];

private _templates = MSVAR(_templates);
private _templateKeys = keys _templates;
private _registeredItems = _templates getOrDefault [QMVAR(_registeredItems), []];

if (_targetUuid in _templateKeys) exitWith {

    _namespaceIndex = _registeredItems findIf {

        ([_x, [
            [QMVAR(_templateUuid), ""]
        ]] call KPLIB_fnc_namespace_getVars) params [
            Q(_templateUuid)
        ];

        _targetUuid isEqualType _templateUuid;
    };

    _namespaceIndex;
};

_templates set [_targetUuid, _namespace];

_namespaceIndex = _registeredItems pushBack _namespace;

_templates set [QMVAR(_registeredItems), _registeredItems];

_namespaceIndex;
