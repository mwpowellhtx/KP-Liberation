/*
    KPLIB_fnc_logistics_areEndpointsEqual

    File: fn_logistics_areEndpointsEqual.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-03-15 00:48:21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns whether the two endpoints are equal to one another. May evaluate only
        identifying information, or may include the full endpoint, including bill values.

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

// We do not care about BILL VALUE elements for purposes of this comparison
private _onAvailableEndpoint = {
    params [
        ["_pos", +KPLIB_zeroPos, [[]], 3]
        , ["_markerName", "", [""]]
        , ["_baseMarkerText", "", [""]]
    ];

    [
        _pos
        , _markername
        , _baseMarkerText
    ];
};

private _alphaAvail = _alpha call _onAvailableEndpoint;
private _bravoAvail = _bravo call _onAvailableEndpoint;

// Actually expecting ALPHA and BRAVO to at least have a value, plus AVAIL equal
!((_alpha isEqualTo []) || (_bravo isEqualTo []))
    && _alphaAvail isEqualTo _bravoAvail;

// TODO: TBD: better might be to actually "verify" that they are both considered ENDPOINT tuples
