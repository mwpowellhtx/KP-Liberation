/*
    KPLIB_fnc_productionCO_tryDebitCap

    File: fn_productionCO_tryDebitCap.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 11:32:55
    Last Update: 2021-03-17 07:54:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The intention with this function is to assess the cost, assert the debit, if
        possible, and respond with an appropriate result tuple. It is not our intention
        to engage anything else here, users in the form of remote invocations, etc. That
        is the role of the caller, 'KPLIB_fnc_productionCO_onAddCap', for example.

    Parameter(s):
        _namespace - a CBA production namespace, if one cound be found [LOCATION, default: locationNull]
        _changeOrder - a CBA CHANGE ORDER namespace [LOCATION, default: locationNull]
            "KPLIB_production_capabilityMask" - BOOL array masking the target capability add request [ARRY, default: KPLIB_production_cap_default]
            "KPLIB_production_candidate"

    Returns:
        The debit was paid against the indicated resource, plus CHANGE ORDER updates [BOOL]
            "KPLIB_production_assessment" - an encoded assessment, result of the transaction

    Dependencies:
        0005_config
        0015_linq
        0210_resources
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

private _debug = [
    [
        {KPLIB_param_productionCO_tryDebitCap_debug}
        , {_namespace getVariable ["KPLIB_param_productionCO_tryDebitCap_debug", false]}
        , {_changeOrder getVariable ["KPLIB_param_productionCO_tryDebitCap_debug", false]}
    ]
] call KPLIB_fnc_productionCO_debug;

private _onExitWith = {
    params [
        ["_assessment", KPLIB_productionCO_addCap_success, [0]]
        , ["_msg", "", [""]]
    ];

    if (_debug && count _msg > 0) then {
        [_msg, "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
    };

    [_changeOrder, [
        ["KPLIB_production_assessment", _assessment]
    ]] call KPLIB_fnc_namespace_setVars;

    _assessment isEqualTo KPLIB_productionCO_addCap_success;
};

([_namespace, [
    ["KPLIB_production_markerName", KPLIB_production_markerNameDefault]
    , ["KPLIB_production_baseMarkerText", ""]
    , ["KPLIB_production_capability", +KPLIB_production_cap_default]
]] call KPLIB_fnc_namespace_getVars) params [
    "_markerName"
    , "_baseMarkerText"
    , "_cap"
];

([_changeOrder, [
    ["KPLIB_production_capabilityMask", +KPLIB_production_cap_default]
    , ["KPLIB_production_capabilityCandidate", +KPLIB_production_cap_default]
    , ["KPLIB_production_capabilityDebit", +KPLIB_resources_storageValueDefault]
]] call KPLIB_fnc_namespace_getVars) params [
    "_mask"
    , "_candidate"
    , "_debit"
];

private _assessment = KPLIB_productionCO_addCap_success;

if (_debug) then {
    [format ["[fn_productionCO_tryDebitCap] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

// Namespace is not considered a CBA production namespace...
if (!([_namespace] call KPLIB_fnc_production_verifyNamespace)) exitWith {
    [KPLIB_productionCO_addCap_elementNotFound, "[fn_productionCO_tryDebitCap] Invalid namespace"] call _onExitWith;
};

if (_candidate isEqualTo _cap) exitWith {
    [KPLIB_productionCO_addCap_exists, "[fn_productionCO_tryDebitCap] No change"] call _onExitWith;
};

// Marker name of the designated source from which to debit the cost
private _sourceName = _markerName;
private _range = KPLIB_param_sectorCapRange;

if (_debit isEqualTo (_debit apply {0})) exitWith {
    [nil, "[fn_productionCO_tryDebitCap] Nothing to debit, zero cost"] call _onExitWith;
};

// Cost is not zero, so we need to verify resources
if (KPLIB_param_production_debitFob) then {
    if (KPLIB_sectors_fobs isEqualTo []) then {
        _assessment = KPLIB_productionCO_addCap_insufficientSumFob;
    } else {
        private _markerPos = markerPos _markerName;
        // Minding the Ps and Qs, first for Min, then for 'KPLIB_sectors_fobs'
        private _fob = [KPLIB_sectors_fobs, { (_this#0#4) distance2D _markerPos; }] call KPLIB_fnc_linq_min;
        //                           1. _fob:       ^^
        //                           2. _pos:         ^^
        _sourceName = (_fob#0);
        _range = KPLIB_param_fobRange;
    };
};

// Clear to attempt the debit
if (_assessment isEqualTo KPLIB_productionCO_addCap_success) then {
    private _debitArgs = [_sourceName] + _debit + [_range];
    if (!(_debitArgs call KPLIB_fnc_resources_pay)) then {
        _assessment = if (_sourceName in KPLIB_sectors_factory) then {
            KPLIB_productionCO_addCap_insufficientSumSector;
        } else {
            KPLIB_productionCO_addCap_insufficientSumFob;
        };
    };
};

[_assessment, format ["[fn_productionCO_tryDebitCap] Fini: [_assessment, _debit, _baseMarkerText]: %1"
    , str [_assessment, _debit, _baseMarkerText]]] call _onExitWith;
