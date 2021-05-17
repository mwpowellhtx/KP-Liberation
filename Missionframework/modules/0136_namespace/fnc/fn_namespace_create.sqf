/*
    KPLIB_fnc_namespace_create

    File: fn_namespace_create.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-05 22:10:33
    Last Update: 2021-04-16 08:27:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates a new CBA namespace.

    Parameter(s):
        _isGlobal - whether the namespace is global [BOOL, default: false]
        _onInit - optional callback to initialize the namespace [CODE, default: {}]

    Returns:
        A created CBA namespace [LOCATION]

    References:
        http://cbateam.github.io/CBA_A3/docs/files/common/fnc_createNamespace-sqf.html
 */

params [
    ["_isGlobal", false, [false]]
    , ["_onInit", {}, [{}]]
];

private _retval = [_isGlobal] call CBA_fnc_createNamespace;

_retval call _onInit;

_retval;
