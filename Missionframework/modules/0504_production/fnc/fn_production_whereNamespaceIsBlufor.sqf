
/*
    KPLIB_fnc_production_whereNamespaceIsBlufor

    File: fn_production_whereNamespaceIsBlufor.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 15:50:10
    Last Update: 2021-03-17 15:50:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Predicates a CBA PRODUCTION namespace belonging to BLUFOR. For use primarily as an
        argument driven callback, but may operate with 'select' or 'count' operators as well.

    Parameter(s):
        locationNull - a CBA PRODUCTION namespace [LOCATION, default: locationNull]

    Returns:
        Whether the CBA PRODUCTION namespace "is BLUFOR" [BOOL]

    References:
        https://community.bistudio.com/wiki/count
        https://community.bistudio.com/wiki/select
        https://community.bistudio.com/wiki/Category:Arma_3:_Scripting_Commands
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

if (isNil "_x") then { _x = _namespace; };

([_x, [
    ["KPLIB_production_markerName", KPLIB_production_markerNameDefault]
]] call KPLIB_fnc_namespace_getVars) params [
    "_markerName"
];

_markerName in KPLIB_sectors_blufor;
