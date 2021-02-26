/*
    KPLIB_fnc_logistics_getNamespaceBy

    File: fn_logistics_getNamespaceBy.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 21:49:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns the CBA logistics namespace matching the '_predicate', or 'locationNull' when one could not be found.

    Parameters:
        _predicate - find the CBA logistics namespace matching the predicate [CODE, default: _defaultPredicate]

    Returns:
        The namespace matching the '_predicate' or 'locationNull' if a match could not be found [LOCATION]

    References:
        https://community.bistudio.com/wiki/locationNull
 */

private _defaultPredicate = { true; };

params [
    ["_predicate", _defaultPredicate, [{}]]
];

private _i = KPLIB_logistics_namespaces findIf _predicate;

if (_i < 0) exitWith { locationNull; };

(KPLIB_logistics_namespaces select _i);
