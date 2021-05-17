/*
    KPLIB_fnc_productionCO_makeCapDebit

    File: fn_productionCO_makeCapDebit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 11:30:50
    Last Update: 2021-03-17 08:04:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Calculates the calculated resource cost required to add the production capability
        represented by '_mask'.

    Parameter(s):
        _this (i.e. '_mask') - BOOL array masking a target capability add request [ARRY, default: KPLIB_production_cap_default]
            - _supplyMask - a resource mask [BOOL, default: false]
            - _ammoMask - a resource mask [BOOL, default: false]
            - _fuelMask - a resource mask [BOOL, default: false]

    Returns:
        A tuple consisting of the target, '_mask', resource costs:
            [
                ["_supplyCost", 0, [0]]
                , ["_ammoCost", 0, [0]]
                , ["_fuelCost", 0, [0]]
            ]
 */

private _debug = [
    [
        {KPLIB_param_productionCO_makeCapDebit_debug}
    ]
] call KPLIB_fnc_productionCO_debug;

params [
    ["_supplyMask", false, [false]]
    , ["_ammoMask", false, [false]]
    , ["_fuelMask", false, [false]]
];

private _mask = [
    _supplyMask
    , _ammoMask
    , _fuelMask
];

if (_debug) then {
    [format ["[fn_productionCO_getCapabilityCost] Entering: [_mask]: %1"
        , str [_mask]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

private _retval = _mask apply {
    if (_x) then {
        KPLIB_param_production_targetCost
    } else {
        KPLIB_param_production_defaultCost;
    };
};

if (_debug) then {
    [format ["[fn_productionCO_getCapabilityCost] Finished: [_retval]: %1"
        , str [_retval]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

_retval;
