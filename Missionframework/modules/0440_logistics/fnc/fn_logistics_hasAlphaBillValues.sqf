/*
    KPBLIB_fnc_logistics_hasAlphaBillValues

    File: fn_logistics_hasAlphaBillValues.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-26 00:16:44
    Last Update: 2021-02-26 00:16:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns whether the ALPHA endpoint has bill values.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        Whether the ALPHA endpoint has bill values [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

private _endpoints = _namespace getVariable ["KPLIB_logistics_endpoints"];

_endpoints params [
    ["_alpha", [], [[]]]
];

_alpha params [
    ["_0", +KPLIB_zeroPos, [[]]]
    , ["_1", "", [""]]
    , ["_2", "", [""]]
    , ["_alphaValues", +KPLIB_resources_storageValueDefault, [[]]]
];

// Rolling sum across the parts...
private _onSum = { (_this#0) + (_this#1); };

private _zed = 0;

// No values remaining, zero sum, means transfer complete
private _sum = [_zed, _alphaValues, _onSum] call KPLIB_fnc_linq_aggregate;

_sum == _zed;