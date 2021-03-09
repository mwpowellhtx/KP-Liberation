/*
    KPLIB_fnc_logistics_checkStatus

    File: fn_logistics_checkStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 17:08:31
    Last Update: 2021-03-05 08:43:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Checks the 'KPLIB_logistics_status'. Allows for 'KPLIB_logistics_status_standby'
        zeroed use cases.

    Parameter(s):
        _status - the status flags [SCALAR, default: KPLIB_logistics_status_standby]
        _mask - the bit flags mask to check [SCALAR, default: KPLIB_logistics_status_standby]

    Returns:
        Checks the bit flags 'KPLIB_logistics_status' [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
 */

params [
    ["_status", KPLIB_logistics_status_standby, [0]]
    , ["_mask", KPLIB_logistics_status_standby, [0]]
];

// Allowing for a zeroed status
if (_mask == KPLIB_logistics_status_standby && _status == _mask) exitWith {
    true;
};

[_status, _mask] call BIS_fnc_bitflagsCheck;
