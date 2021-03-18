/*
    KPLIB_fnc_production_getAllNamespaces

    File: fn_production_getAllNamespaces.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 15:53:46
    Last Update: 2021-03-17 15:53:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the CBA PRODUCTION namespaces that are currently among the BLUFOR
        controlled sectors. May be PREDICATED differently depending on the context.

    Parameter(s):
        _predicate - a CBA PRODUCTION namespace predicate [CODE,
            default: KPLIB_fnc_production_whereNamespaceIsBlufor]

    Returns:
        The set of CBA PRODUCTION namespaces matching the predicate [ARRAY]
 */

params [
    ["_predicate", KPLIB_fnc_production_whereNamespaceIsBlufor, [{}]]
];

KPLIB_production_namespaces select _predicate;
