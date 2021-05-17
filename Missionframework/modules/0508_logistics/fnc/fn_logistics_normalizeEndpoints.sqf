/*
    KPLIB_fnc_logistics_normalizeEndpoints

    File: fn_logistics_normalizeEndpoints.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-15 21:16:08
    Last Update: 2021-03-15 21:16:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Normalizes the ENDPOINTS to ALPHA and BRAVO form factor. Optionally includes both
        of the ALPHA and BRAVO ENDPOINT BILL VALUE elements, or when their respective sizes
        was four, i.e. inclusive of BILL VALUE.

    Parameters:
        _endpoints - an ENDPOINTS array [ARRAY, default: []]

    Returns:
        The ENDPOINTS normalized to ALPHA and BRAVO form factor [ARRAY]
 */

params [
    ["_endpoints", [], [[]]]
    , ["_includeBillValue", false, [false]]
];

_endpoints params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

// Which itself is a function of normalizing each of the ALPHA and BRAVO ENDPOINTS
[
    [_alpha, _includeBillValue] call KPLIB_fnc_logistics_normalizeEndpoint
    , [_bravo, _includeBillValue] call KPLIB_fnc_logistics_normalizeEndpoint
];
