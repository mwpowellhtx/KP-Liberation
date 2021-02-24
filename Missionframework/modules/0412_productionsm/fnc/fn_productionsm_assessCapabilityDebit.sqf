/*
    KPLIB_fnc_productionsm_assessCapabilityDebit

    File: fn_productionsm_assessCapabilityDebit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 11:32:55
    Last Update: 2021-02-18 09:41:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The intention with this function is to assess the cost, assert the debit, if
        possible, and respond with an appropriate result tuple. It is not our intention
        to engage anything else here, users in the form of remote invocations, etc. That
        is the role of the caller, 'KPLIB_fnc_productionsm_onAddCapability', for example.

    Parameter(s):
        _namespace - a CBA production namespace, if one cound be found [LOCATION, default: locationNull]
        _capability -
        _capabilityMask - BOOL array masking the target capability add request [ARRY, default: KPLIB_production_cap_default]
        _candidate -

    Returns:
        A tuple corresponding with the result:
            [
                ["_assessment", 0, [0]]
                , ["_cost", [0, 0, 0], [[]], 3]
                , ["_baseMarkerText", "", [""]]
            ]

    Dependencies:
        0005_config
        0015_linq
        0210_resources
 */

private _debug = [] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_capability", (+KPLIB_production_cap_default), [[]], 3]
    , ["_capabilityMask", (+KPLIB_production_cap_default), [[]], 3]
    , ["_candidate", (+KPLIB_production_cap_default), [[]], 3]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_assessCapabilityDebit] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _assessment = KPLIB_productionsm_addCap_success;

/* Obtain the cost given the desired mask, which we do not need to know
 * target capability (i.e. '_targetCap') as long as we have this. */
private _cost = _capabilityMask call KPLIB_fnc_productionsm_getCapabilityCost;

// Namespace is not considered a CBA production namespace...
if (!([_namespace] call KPLIB_fnc_production_verifyNamespace)) exitWith {
    if (_debug) then {
        ["[fn_productionsm_assessCapabilityDebit] Invalid namespace", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };
    _assessment = KPLIB_productionsm_addCap_elementNotFound;
    +[_assessment, _cost, ""];
};

private _baseMarkerText = _namespace getVariable ["_baseMarkerText", ""];

if (_candidate isEqualTo _capability) exitWith {
    if (_debug) then {
        ["[fn_productionsm_assessCapabilityDebit] No change", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };
    _assessment = KPLIB_productionsm_addCap_exists;
    +[_assessment, _cost, _baseMarkerText];
};

// Marker name of the designated source from which to debit the cost
private _sourceName = _markerName;
private _range = KPLIB_param_sectorCapRange;

if (_cost isEqualTo (_cost apply {0})) exitWith {
    if (_debug) then {
        ["[fn_productionsm_assessCapabilityDebit] No cost", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };
    [_assessment, _cost, _baseMarkerText];
};

// Cost is not zero, so we need to verify resources
if (KPLIB_param_production_debitFob) then {
    if (KPLIB_sectors_fobs isEqualTo []) then {
        _assessment = KPLIB_productionsm_addCap_insufficientSumFob;
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

// Clear to attempt the debit...
if (_assessment isEqualTo KPLIB_productionsm_addCap_success) then {
    private _debitArgs = [_sourceName] + _cost + [_range];
    if (!(_debitArgs call KPLIB_fnc_resources_pay)) then {
        _assessment = if (_sourceName in KPLIB_sectors_factory) then {
            KPLIB_productionsm_addCap_insufficientSumSector;
        } else {
            KPLIB_productionsm_addCap_insufficientSumFob;
        };
    };
};

private _retval = +[
    _assessment
    , _cost
    , _baseMarkerText
];

if (_debug) then {
    [format ["[fn_productionsm_assessCapabilityDebit] Finished: [_assessment, _cost, _baseMarkerText]: %1"
        , str [_retval]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

_retval;
