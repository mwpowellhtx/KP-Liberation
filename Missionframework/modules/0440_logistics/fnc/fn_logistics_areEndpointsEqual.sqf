/*
    KPLIB_fnc_logistics_areEndpointsEqual

    File: fn_logistics_areEndpointsEqual.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-03-15 00:48:21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns whether ALPHA and BRAVO ENDPOINTS are both EQUAL. Neither should
        equal the ZERO ENDPOINT, either.

    Parameters:
        _alpha - an ALPHA logistics endpoint tuple shape [ARRAY]
        _bravo - a BRAVO logistics endpoint tuple shape [ARRAY]

    Returns:
        Returns whether ALPHA and BRAVO ENDPOINT tuples are considered functionally
        equivalent, notwithstanding any BILL VALUE elements [BOOL]
 */

params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

// Normalize ALPHA and BRAVO ENDPOINTS first
([_alpha, _bravo] apply { [_x] call KPLIB_fnc_logistics_normalizeEndpoint; }) params {
    "_0"
    , "_1"
};

// Sans any BILL VALUE elements
_alpha = _0 select [0, 2];
_bravo = _1 select [0, 2];

// Then we may compare whether they are EQUAL, to each other and to ZERO
[
    [_alpha, KPLIB_logistics_zeroEndpoint, _alpha] call KPLIB_fnc_logistics_areEndpointsEqual
    , [_bravo, KPLIB_logistics_zeroEndpoint, _bravo] call KPLIB_fnc_logistics_areEndpointsEqual
    , [_alpha, _bravo] call KPLIB_fnc_logistics_areEndpointsEqual
] params [
    "_alphaIsZero"
    , "_bravoIsZero"
    , "_alphaEqualsBravo"
];

!(
    _alphaIsZero
        || _bravoIsZero
) && _alphaEqualsBravo;
