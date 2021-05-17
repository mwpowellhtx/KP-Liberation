/*
    KPLIB_fnc_logistics_convoyIsEmpty

    File: fn_logistics_convoyIsEmpty.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 11:38:02
    Last Update: 2021-03-07 11:38:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns whether the CONVOY is considered EMPTY, i.e. fully UNLOADED. This means
        that the CONVOY must have TRANSPORTS, and they must all be UNLOADED.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        Whether the CONVOY can be considered EMPTY, i.e. UNLOADED [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    [KPLIB_logistics_convoy, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_convoy"
];

_convoy = +_convoy;

// Which like FULL, EMPTY is EMPTY, no in betweens
[
    count _convoy
    , { (_x isEqualTo KPLIB_resources_storageValueDefault); } count _convoy
] params [
    "_transportCount"
    , "_emptyTransportCount"
];

_transportCount > 0 && (
    _emptyTransportCount == _transportCount
);
