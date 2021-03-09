/*
    KPLIB_fnc_logistics_setStatus

    File: fn_logistics_setStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 12:03:32
    Last Update: 2021-03-07 12:03:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _status - the status flags [SCALAR, default: KPLIB_logistics_status_standby]
        _mask - the bit flags mask to set [SCALAR, default: KPLIB_logistics_status_standby]

    Returns:
        The '_status' with '_mask' bits set [SCALAR]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
 */

params [
    ["_status", KPLIB_logistics_status_standby, [0]]
    , ["_mask", KPLIB_logistics_status_standby, [0]]
];

[_status, _mask] call BIS_fnc_bitflagsSet;
