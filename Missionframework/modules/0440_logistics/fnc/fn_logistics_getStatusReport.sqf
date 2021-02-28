/*
    KPLIB_fnc_logistics_getNamespaceByUuid

    File: fn_logistics_getNamespaceByUuid.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 22:00:22
    Last Update: 2021-02-25 22:00:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Decodes the logistics '_status' in terms of its bitwise flags as a human readable report.

    Parameters:
        _status - a bitwise encoded logistics status [SCALAR, default: 0]

    Returns:
        The namespace matching the '_targetUuid' or 'locationNull' if a match could not be found [LOCATION]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
 */


params [
    ["_status", KPLIB_logistics_status_standby, [0]]
];

if (_status == KPLIB_logistics_status_standby) exitWith {
    toUpper (KPLIB_logistics_status_reports#0#1);
};

private _reports = KPLIB_logistics_status_reports select {
    [_status, (_x#0)] call BIS_fnc_bitflagsCheck;
};

_reports = _reports apply { (toUpper (_x#1)); };

_reports joinString ", ";
