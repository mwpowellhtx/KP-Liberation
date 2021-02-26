/*
    KPLIB_fnc_logistics_verifyNamespace

    File: fn_logistics_verifyNamespace.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 14:48:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        NONE

    Returns:
        NONE
 */

private _debug = [
    [
        "KPLIB_param_logistics_verificationDebug"
        , "KPLIB_param_logistics_namespaceVerificationDebug"
    ]
] call KPLIB_fnc_logistics_debug;

params [
    ["_namespace", [], [[]]]
];

if (isNull _namespace) exitWith {
    false;
};

true;
