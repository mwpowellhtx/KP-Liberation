/*
    KPLIB_fnc_logistics_calculateTransitDuration

    File: fn_logistics_calculateTransitDuration.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 15:05:29
    Last Update: 2021-03-06 15:05:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Calculates approximate duration between ALPHA and BRAVO ENDPOINTS.

    Parameters:
        _endpoints - the ALPHA and BRAVO ENDPOINTS [ARRAY, default: []]
        _transportSpeedMps - the CONVOY TRANSPORT speed in meters per second (mps)
            [SCALAR, default: _defaultTransportSpeedMps]

    Returns:
        The approximate duration between ALPHA and BRAVO ENDPOINTS [SCALAR]
 */

private _defaultTransportSpeedMps = [] call KPLIB_fnc_logistics_calculateTransportSpeedMps;

params [
    ["_endpoints", [], [[]]]
    , ["_transportSpeedMps", _defaultTransportSpeedMps, [0]]
];

_endpoints params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

_alpha params [
    ["_alphaPos", +KPLIB_zeroPos, [[]], 3]
];

_bravo params [
    ["_bravoPos", +KPLIB_zeroPos, [[]], 3]
];

(_alphaPos distance2D _bravoPos) / _transportSpeedMps;
