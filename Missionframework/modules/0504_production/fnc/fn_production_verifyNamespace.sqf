/*
    KPLIB_fnc_production_verifyNamespace

    File: fn_production_verifyNamespace.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-17 09:00:35
    Last Update: 2021-02-17 09:00:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Verifies that the CBA namespace is at 

    Parameter(s):
        _namespace - a CBA production namespace [NAMESPACE]

    Returns:
        A newly converted SQF ARRAY representation of the production NAMESPACE [ARRAY]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

// Type has already been trapped: ^^^^^^^^^^^^
if (isNull _namespace) exitWith { false; };

// There may be other intermediate and transient variables, but these are the core...
private _expectedVars = [
    "KPLIB_production_markerName"
    , "KPLIB_production_baseMarkerText"
    , "KPLIB_production_timer"
    , "KPLIB_production_capability"
    , "KPLIB_production_queue"
    , "KPLIB_resources_storageValue"
];

private _namespaceVars = allVariables _namespace;

(_expectedVars select { toLower _x in _namespaceVars; }) isEqualTo _expectedVars;
