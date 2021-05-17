#include "script_component.hpp"
/*
    KPLIB_fnc_mission_getStatusReport

    File: fn_mission_getStatusReport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 00:58:26
    Last Update: 2021-03-20 00:58:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Decodes the mission '_status' in terms of its bitwise flags as a human readable report.

    Parameters:
        _status - a bitwise encoded logistics status [SCALAR, default: 0]

    Returns:
        The namespace matching the '_targetUuid' or 'locationNull' if a match could not be found [LOCATION]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
 */

private _standby = MSTATUS1(_standby);

params [
    [Q(_status), _standby, [0]]
];

if (_status < _standby) exitWith {
    toUpper (localize "STR_KPLIB_LOGISTICS_STATUS_NA");
};

if (_status == _standby) exitWith {
    toUpper (MVAR(_statusReports)#0#1);
};

private _reports = MVAR(_statusReports) select {
    [_status, (_x#0)] call BIS_fnc_bitflagsCheck;
};

_reports = _reports apply { (toUpper (_x#1)); };

_reports joinString ", ";
