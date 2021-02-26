/*
    KPLIB_fnc_logistics_createArray

    File: fn_logistics_createArray.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 14:45:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns a freshly minted logistics tuple.

    Parameters:
        NONE

    Returns:
        A freshly minted logistics tuple [ARRAY]
 */

private _uuid = [] call KPLIB_fnc_uuid_create_string;

// New lines, lines in standby, have not been assigned any endpoints yet
private _endpoints = [];

// Likewise no transports are assigned to new lines
private _transportValues = [];

+[
    _uuid
    , KPLIB_logistics_status_standby
    , KPLIB_timers_default
    , _endpoints
    , _transportValues
];
