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
        _this - a CBA production namespace [NAMESPACE]

    Returns:
        A newly converted SQF ARRAY representation of the production NAMESPACE [ARRAY]
 */

private _namespace = _this;

// As verified in the in game A3 Extended Debug Console (EDC) ...
if (!(typeName _namespace isEqualTo "LOCATION")) exitWith {
    false;
};

private _expectedVars = [
    "_markerName"
    , "_baseMarkerText"
    , "_timer"
    , "_capability"
    , "_queue"
    , "KPLIB_resources_storageValue"
];

private _namespaceVars = allVariables _namespace;

(_expectedVars select { toLower _x in _namespaceVars; }) isEqualTo _expectedVars;
