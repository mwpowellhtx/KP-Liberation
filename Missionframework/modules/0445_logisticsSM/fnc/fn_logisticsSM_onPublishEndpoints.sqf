/*
    KPLIB_fnc_logisticsSM_onPublishEndpoints

    File: fn_logisticsSM_onPublishEndpoints.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 18:12:16
    Last Update: 2021-03-01 18:12:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Publishes the '_endpoints'' to the specified listening '_cid' logistics manager.

    Parameters:
        _cid - the client identifier to address with the ENDPOINT publication [ARRAY, default: []]
        _endpoints - the ENDPOINT array being published [ARRAY, default: []]

    Returns:
        The callback finished [BOOL]
 */

params [
    ["_cid", -1, [0]]
    , "_endpoints"
];

if (_cid < 0) exitWith {
    false;
};

// Support a kind of "lazy loading" with this one, when necessary, unless otherwise given
if (isNil "_endpoints") then {
    _endpoints = [] call KPLIB_fnc_logistics_getEndpoints;
};

[KPLIB_logisticsMgr_onEndpointsPublished, [_endpoints], _cid] call CBA_fnc_ownerEvent;

true;
