/*
    KPLIB_fnc_logistics_verifyNamespace

    File: fn_logistics_verifyNamespace.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 22:24:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Verifies that the '_namespace' is indeed valid.

    Parameters:
        _namespace - a CBA logistics namespace to validate [LOCATION, default: locationNull]

    Returns:
        Whether the '_namespace' is valid [BOOL]
 */

private _debug = [
    [
        "KPLIB_param_logistics_verificationDebug"
        , "KPLIB_param_logistics_namespaceVerificationDebug"
    ]
] call KPLIB_fnc_logistics_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

if (isNull _namespace) exitWith {
    false;
};

private _candidate = [_namespace, [
    ["KPLIB_logistics_uuid", ""]
    , ["KPLIB_logistics_status", KPLIB_logistics_status_na]
    , [KPLIB_logistics_timer, []]
    , ["KPLIB_logistics_endpoints", []]
    , [KPLIB_logistics_convoy, []]
]] call KPLIB_fnc_namespace_getVars;

[_candidate] call KPLIB_fnc_logistics_verifyArray;
