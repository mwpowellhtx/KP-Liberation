/*
    KPLIB_fnc_production_onDebitCapability

    File: fn_production_onDebitCapability.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 11:32:55
    Last Update: 2021-02-17 11:35:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The intention with this function is to assess the cost, assert the debit, if
        possible, and respond with an appropriate result tuple. It is not our intention
        to engage anything else here, users in the form of remote invocations, etc. That
        is the role of the caller, 'KPLIB_fnc_productionServer_onAddCapability', for example.

    Parameter(s):
        _targetCap - the capability being added to the factory sector [SCALAR, default: 0]
        _namespace = the CBA production namespace, if one cound be found [LOCATION, default: objNull]

    Returns:
        A tuple corresponding with the result:
            [
                ["_status", 0, [0]]
                , ["_cost", [0, 0, 0], [[]], 3]
                , ["_baseMarkerText", "", [""]]
            ]

    Dependencies:
        0005_config
        0015_linq
        0210_resources
*/

params [
    ["_targetCap", 0, [0]]
    , ["_namespace", objNull]
];

// TODO: TBD: for now assuming cost, pay, etc, are all positive, and applied accordingly...
// TODO: TBD: upon visiting the whole transaction aspect, we think we just call the value positive or negative, credit or debit, accordingly.

// Setup the default cost
private _cost = [
    KPLIB_param_production_defaultCost
    , KPLIB_param_production_defaultCost
    , KPLIB_param_production_defaultCost
];

// Then apply the target cost
_cost set [_targetCap, KPLIB_param_production_targetCost];

// Namespace is not considered a CBA production namespace...
if (!(_namespace call KPLIB_fnc_production_verifyNamespace)) exitWith {
    [KPLIB_production_addCap_elementNotFound, _cost, ""];
    //                           1. _baseMarkerText: ^^
};

private _status = KPLIB_production_addCap_clear;

/* Assume factory cost payment unless we identify FOB accreditation:
 * https://en.wikipedia.org/wiki/Accreditation
 * https://www.dictionary.com/browse/accreditation
*/
private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];
private _baseMarkerText = _namespace getVariable ["_baseMarkerText", ""];

// Marker name of the designated source from which to debit the cost
private _sourceName = _markerName;
private _range = KPLIB_param_sectorCapRange;

if (_cost isEqualTo (_cost apply {0})) exitWith {
    [_status, _cost, _baseMarkerText];
};

// Cost is not zero, so we need to verify resources
if (KPLIB_param_production_creditFob) then {
    if (KPLIB_sectors_fobs isEqualTo []) then {
        _status = KPLIB_production_addCap_insufficientSumFob;
    } else {
        private _markerPos = markerPos _markerName;
        // Minding the Ps and Qs, first for Min, then for 'KPLIB_sectors_fobs'
        private _fob = [KPLIB_sectors_fobs, { (_this#0#4) distance2D _markerPos; }] call KPLIB_fnc_linq_min;
        //                                     ^^^^^^^^^
        _sourceName = (_fob#0);
        _range = KPLIB_param_fobRange;
    };
};

// Clear to attempt the debit...
if (_status == KPLIB_production_addCap_clear) then {
    private _debitArgs = [_sourceName] + _cost + [_range];
    if (!(_debitArgs call KPLIB_fnc_resources_pay)) then {
        _status = if (_sourceName in KPLIB_sectors_factory) then {
            KPLIB_production_addCap_insufficientSumSector;
        } else {
            KPLIB_production_addCap_insufficientSumFob;
        };
    };
};

[_status, _cost, _baseMarkerText];
