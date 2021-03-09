/*
    KPLIB_fnc_logistics_convoyIsFull

    File: fn_logistics_convoyIsFull.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 11:31:35
    Last Update: 2021-03-07 11:31:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns whether the CONVOY is considered FULL, i.e. fully LOADED. This means
        that the CONVOY must have TRANSPORTS, and they must all be LOADED.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        Whether the CONVOY can be considered FULL, i.e. LOADED [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , [KPLIB_logistics_convoy, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
    , "_convoy"
];

[
    count _convoy
    , { !(_x isEqualTo KPLIB_resources_storageValueDefault); } count _convoy
    , { (_x isEqualTo KPLIB_resources_storageValueDefault); } count _convoy
    , [_namespace] call KPLIB_fnc_logistics_alphaEndpointHasBillValue
    , [_status, KPLIB_logistics_status_enRoute] call KPLIB_fnc_logistics_checkStatus
] params [
    "_transportCount"
    , "_fullTransportCount"
    , "_emptyTransportCount"
    , "_alphaHasBill"
    , "_enRoute"
];

// TODO: TBD: this would be when we evaluate for partially loaded transports, is it allowable?
_transportCount > 0
    && (
        // En route with at least partial load
        (_enRoute && _fullTransportCount > 0)
            // Loading with full load ready to transit
            || (!_enRoute && _alphaHasBill && _emptyTransportCount == 0)
            // Loading no bill remaining ready to transit
            || (!(_enRoute || _alphaHasBill) && _fullTransportCount > 0)
    );
