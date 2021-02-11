/*
    KPLIB_fnc_production_onDebitCapability

    File: fn_production_onDebitCapability.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 11:32:55
    Last Update: 2021-02-05 11:32:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The intention with this function is to assess the cost, assert the debit, if
        possible, and respond with an appropriate result tuple. It is not our intention
        to engage anything else here, users in the form of remote invocations, etc. That
        is the role of the caller, 'KPLIB_fnc_production_server_onAddCapability', for example.

    Parameter(s):
        _cap - the capability being added to the factory sector [SCALAR, default: 0]
        _productionElem - the production element, if one could be found [ARRAY, default: []]

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
    ["_cap", 0, [0]]
    , ["_productionElem", [], [[]]]
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
_cost set [_cap, KPLIB_param_production_targetCost];

// No production element no added capability
if (_productionElem isEqualTo []) exitWith {
    [KPLIB_production_addCap_elementNotFound, _cost, ""];
    //                           1. _baseMarkerText: ^^
};

private _status = KPLIB_production_addCap_clear;

/* Assume factory cost payment unless we identify FOB accreditation:
 * https://en.wikipedia.org/wiki/Accreditation
 * https://www.dictionary.com/browse/accreditation
*/
(_productionElem#0) params [
    ["_markerName", "", [""]]
    , ["_baseMarkerText", "", [""]]
];
private _resourceName = _markerName;
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
        private _fob = [KPLIB_sectors_fobs, { ((_x#0#0) distance2D _markerPos); }] call KPLIB_fnc_linq_min;
        _resourceName = (_fob#0#0);
        _range = KPLIB_param_fobRange;
    };
};

// Clear to attempt the debit...
if (_status == KPLIB_production_addCap_clear) then {
    private _debitArgs = [_resourceName] + _cost + [_range];
    if (!(_debitArgs call KPLIB_fnc_resources_pay)) then {
        _status = if (_resourceName in KPLIB_sectors_factory) then {
            KPLIB_production_addCap_insufficientSumSector;
        } else {
            KPLIB_production_addCap_insufficientSumFob;
        };
    };
};

[_status, _cost, _baseMarkerText];
