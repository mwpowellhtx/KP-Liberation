#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_getFobAssets

    File: fn_hudDispatchSM_getFobAssets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns with an array of assets aligned to the FOB matching the predicate.

    Parameters:
        _fob - the FOB about which to check [ARRAY, default: []]
        _assetType - the asset type [STRING, default: Q(Plane)]
        _range - range about which to check [SCALAR, default: KPLIB_param_fobRange]

    Returns:
        An array of assets matching the FOB criteria [ARRAY]
 */

params [
    [Q(_fob), [], [[]]]
    , [Q(_assetType), Q(Plane), [""]]
    , [Q(_range), KPLIB_param_fobRange, [0]]
];

_fob params [
    Q(_0)
    , Q(_1)
    , Q(_2)
    , Q(_3)
    , Q(_pos)
];

private _assets = nearestObjects [_pos, [_assetType], _range];

private _retval = _assets select { [_x] call MFUNC(_whereShouldBeCounted); };

_retval;
