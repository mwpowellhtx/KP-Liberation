/*
    KPLIB_fnc_logistics_alphaEndpointHasBillValue

    File: fn_logistics_alphaEndpointHasBillValue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-26 00:16:44
    Last Update: 2021-03-04 19:31:21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns whether the ALPHA endpoint has bill values.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        Whether the ALPHA endpoint has bill values [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_endpoints"
];

_endpoints params [
    ["_alpha", [], [[]]]
];

private _storageValueDefault = +KPLIB_resources_storageValueDefault;

_alpha params [
    ["_alphaPos", +KPLIB_zeroPos, [[]], 3]
    , ["_alphaMarker", "", [""]]
    , ["_alphaMarkerText", "", [""]]
    , ["_alphaBillValue", _storageValueDefault, [[]], 3]
];

// Meaning that there is something to consider LOADING
!(_alphaBillValue isEqualTo _storageValueDefault);
