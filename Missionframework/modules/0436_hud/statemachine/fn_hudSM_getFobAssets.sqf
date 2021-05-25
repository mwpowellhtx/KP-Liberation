#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_getFobAssets

    File: fn_hudSM_getFobAssets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-21 01:17:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns with an array of assets aligned to the FOB matching the predicate.

    Parameters:
        _fobMarker - the FOB MARKER about which to consider [STRING, default: ""]
        _assetType - an ASSET TYPE being considered [STRING, default: _defaultAssetType]
        _range - a RANGE about which to consider [SCALAR, default: KPLIB_param_fobs_range]

    Returns:
        An array of assets matching the FOB criteria [ARRAY]
 */

private _defaultAssetType = Q(Plane);

params [
    [Q(_fobMarker), "", [""]]
    , [Q(_assetType), _defaultAssetType, [""]]
    , [Q(_range), KPLIB_param_fobs_range, [0]]
];

private _assets = nearestObjects [markerPos _fobMarker, [_assetType], _range];

private _qualified = _assets select { [_x, _range] call KPLIB_fnc_persistence_shouldBePersistent; };

_qualified;
