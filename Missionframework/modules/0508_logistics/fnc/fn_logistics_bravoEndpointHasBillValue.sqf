/*
    KPLIB_fnc_logistics_bravoEndpointHasBillValue

    File: fn_logistics_bravoEndpointHasBillValue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 19:28:26
    Last Update: 2021-03-07 19:28:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns whether the BRAVO endpoint has bill values. Virtually identical
        to the ALPHA query in every respect, for those moments when the ENDPOINTS
        have not yet swapped, and we are estimating what the next STATUS should be.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        Whether the BRAVO endpoint has bill values [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    ["_endpoints", [], [[]]]
];

_endpoints params [
    "_alpha"
    , ["_bravo", [], [[]]]
];

_bravo params [
    ["_pos", +KPLIB_zeroPos, [[]], 3]
    , ["_markerName", "", [""]]
    , ["_baseMarkerText", "", [""]]
    , ["_bravoValue", +KPLIB_resources_storageValueDefault, [[]], 3]
];

// Meaning that there is something to consider LOADING
!(_bravoValue isEqualTo KPLIB_resources_storageValueDefault);
