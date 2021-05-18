/*
    KPLIB_fnc_persistence_enumerateFobObjects

    File: fn_persistence_enumerateFobObjects.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-23 19:38:09
    Last Update: 2021-05-17 20:27:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the set of eligible objects within range of each FOB to include in the next per frame persistence cycle.

    Parameter(s):
        _fobs - an array of FOB assets [ARRAY, default: []]
        _range - range within which to consider each asset [SCALAR, default: KPLIB_param_fobs_range]

    Returns:
        The set of eligible objects within range of each FOB to include in the next per frame persistence cycle.
 */

params [
    ["_fobs", KPLIB_sectors_fobs, [[]]]
    , ["_range", KPLIB_param_fobs_range, [0]]
];

private _retval = [];

_fobs select {
    private _fob = _x;
    // If performance is going to suffer, this is why... So we dial back the frequency...
    private _objects = nearestObjects [(_fob#4), [], _range];
    // Do light screening, following by heavy screening...
    _objects = _objects select {
        [_x] call KPLIB_fnc_persistence_whereAssetMayBeFobPersistent;
    };
    _objects = _objects select {
        [_x, _range, [_fob]] call KPLIB_fnc_persistence_whereAssetShouldBeFobPersistent;
    };
    _retval append _objects;
    true;
};

_retval;
