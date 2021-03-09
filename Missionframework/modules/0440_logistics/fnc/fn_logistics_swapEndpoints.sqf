/*
    KPLIB_fnc_logistics_swapEndpoints

    File: fn_logistics_swapEndpoints.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 16:58:20
    Last Update: 2021-03-04 16:58:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Swaps the '_endpoints' and returns the result.

    Parameters:
        _endpoints - an ALPHA+BRAVO ENDPOINTS pair [ARRAY, default: []]

    Returns:
        The '_endpoints' swapped [ARRAY]
 */

params [
    ["_endpoints", [], [[]]]
];

// TODO: TBD: we could verify whether we had endpoints...
_endpoints params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

+[_bravo, _alpha];
