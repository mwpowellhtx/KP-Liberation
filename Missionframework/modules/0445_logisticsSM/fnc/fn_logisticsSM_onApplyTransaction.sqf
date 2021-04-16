/*
    KPLIB_fnc_logisticsSM_onApplyTransaction

    File: fn_logisticsSM_onApplyTransaction.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 17:00:45
    Last Update: 2021-03-05 01:21:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _markerName - [STRING, default: "]
        _billValue - [ARRAY, default: []]
        _onApply - [CODE, default: KPLIB_fnc_resources_refund]

    Returns:
        The callback has finished [ARRAY]
 */

private _debug = [
    [
        {KPLIB_param_logisticsSM_onApplyTransaction_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_markerName", "", [""]]
    , ["_billValue", +KPLIB_resources_storageValueDefault, [[]], 3]
    , ["_onApply", KPLIB_fnc_resources_refund, [{ false; }]]
];

_billValue params [
    ["_supply", 0, [0]]
    , ["_ammo", 0, [0]]
    , ["_fuel", 0, [0]]
];

private _range = if (_markerName in KPLIB_sectors_factory) then {
    KPLIB_param_sectors_capRange;
} else {
    KPLIB_param_fobRange;
};

private _args = [
    _markerName
    , _supply
    , _ammo
    , _fuel
    , _range
];

private _complete = _args call _onApply;

_complete;
