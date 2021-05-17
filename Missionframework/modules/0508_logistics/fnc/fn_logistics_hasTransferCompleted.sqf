/*
    KPLIB_fnc_logistics_hasTransferCompleted

    File: fn_logistics_hasTransferCompleted.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 11:58:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns whether the overall transfer has completed.

    Parameters:
        _namespace - the CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        Whether the overall transfer has completed [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    ["_endpoints", [], [[]]]
];

_endpoints params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

_alpha params [
    ["_0", +KPLIB_zeroPos, [[]]]
    , ["_1", "", [""]]
    , ["_2", "", [""]]
    , ["_alphaValues", +KPLIB_resources_storageValueDefault, [[]]]
];

_bravo params [
    ["_3", +KPLIB_zeroPos, [[]]]
    , ["_4", "", [""]]
    , ["_5", "", [""]]
    , ["_bravoValues", +KPLIB_resources_storageValueDefault, [[]]]
];

// Rolling sum across the parts...
private _onSum = { (_this#0) + (_this#1); };

private _zed = 0;

// No values remaining, zero sum, means transfer complete
private _sum = [_zed, (_alphaValues + _bravoValues), _onSum] call KPLIB_fnc_linq_aggregate;

_sum == _zed;
