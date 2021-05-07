#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_getRoads

    File: fn_ieds_getRoads.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-06 15:42:24
    Last Update: 2021-05-06 15:42:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the ROADS or MAIN ROADS within an area.

    Parameter(s):
        _targetPos - a TARGET POSTIION [POSITION, default: KPLIB_zeroPos]
        _range - range about which to identify road objects [SCALAR, default: KPLIB_param_sectors_capRange]
        _bridge - whether to include bridges [BOOL, default: false]

    Returns:
        An array of road objects [ARRAY]

    References:
        https://community.bistudio.com/wiki/nearestTerrainObjects
        https://community.bistudio.com/wiki/getRoadInfo
 */

private _debug = MPARAM(_getRoads_debug);

params [
    [Q(_targetPos), +KPLIB_zeroPos, [[]], 3]
    , [Q(_range), KPLIB_param_sectors_capRange, [0]]
    , [Q(_bridge), false, [false]]
];

private _roads = nearestTerrainObjects [_targetPos, [Q(ROAD), Q(MAIN ROAD)], _range];

private _selected = _roads select {
    getRoadInfo _x params [
        Q(_0), Q(_1), Q(_2), Q(_3)
        , Q(_4), Q(_5), Q(_6), Q(_7)
        , Q(_isBridge)
    ];
    !_bridge || (_isBridge && _bridge);
};

_selected;
