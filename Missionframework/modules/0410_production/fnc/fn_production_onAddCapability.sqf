/*
    KPLIB_fnc_production_onAddCapability

    File: fn_production_onAddCapability.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 11:32:55
    Last Update: 2021-02-05 11:32:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:

    Parameter(s):
        _markerName - the factory sector affected by the request
        _cap - the capability being added to the sector
        _cid - the client identifier used to invoke client side callbacks

    Returns:
*/

private _debug = [] call KPLIB_fnc_production_debug;

params [
    ["_markerName", "", [""]]
    , ["_cap", -1, [0]]
    , ["_cid", -1, [0]]
];

private _retval = false;

if (_markerName isEqualTo "" || _cap < 0 || _cid < 0) exitWith {
    _retval;
};

private _resourceName = localize (switch (_cap) do {
    case 0: {"STR_KPLIB_PRODUCTION_CAPABILITY_SUPPLY"};
    case 1: {"STR_KPLIB_PRODUCTION_CAPABILITY_AMMO"};
    case 2: {"STR_KPLIB_PRODUCTION_CAPABILITY_FUEL"};
    default {"STR_KPLIB_PRODUCTION_CAPABILITY_NA"};
});

private _matched = KPLIB_production select { ((_x#0#0) isEqualTo _markerName) && !((_x#2#0) select _cap); };
//                           1. _markerName:   ^^^^^^
//                           2.        _cap:                                       ^^^^^^^^^^^^^^^^^^^^

// May or may not have a match, evaluate whether request CAN be processed further.
private _productionElem = if (_matched isEqualTo []) then {[]} else {(_matched#0)};

private _debitResult = [_cap, _productionElem] call KPLIB_fnc_production_onDebitCapability;

_debitResult params [
    ["_status", 0, [0]]
    , ["_cost", [0, 0, 0], [[]], 3]
    //   _cost:  S, A, F
    , ["_baseMarkerText", "", [""]]
];

private _key = switch (_status) do {
    case KPLIB_production_addCap_elementNotFound: {
        "STR_KPLIB_PRODUCTION_CANNOT_ADD_CAPABILITY";
    };
    case KPLIB_production_addCap_insufficientSumFob;
    case KPLIB_production_addCap_insufficientSumSector: {
        "STR_KPLIB_PRODUCTION_INSUFFICIENT_RES";
    };
    // TODO: TBD: case? or just default? (?)
    case KPLIB_production_addCap_clear: {

        // Let the other capabilities pass through as-is, while raising the desired _cap
        (_productionElem#2) set [0, [(_productionElem#2#0)
            , { (_this#1 == _cap) || (_this#0) }] call KPLIB_fnc_linq_select];

        // And re-render the production sector marker text
        _productionElem call KPLIB_fnc_production_onRenderMarkerText;

        // And trigger that a save should occur with the now-updated production bits
        [] call KPLIB_fnc_init_save;

        "STR_KPLIB_PRODUCTION_ADDED_CAPABILITY";
    };
    default {""};
};

// TODO: TBD: should log bits of this...
// Unable to notify anything
if (_key isEqualTo "") exitWith {
    _retval;
};

// Decon the cost tuple just prior to rendering the notification
_cost params [
    ["_s", 0, [0]]
    , ["_a", 0, [0]]
    , ["_f", 0, [0]]
];

[format [localize _key, _resourceName, _baseMarkerText, _s, _a, _f]] remoteExec ["KPLIB_fnc_notification_hint", _cid];
//                                           1. Supply: ^^
//                                           2.   Ammo:     ^^
//                                           3.   Fuel:         ^^

_retval = true;

_retval;
