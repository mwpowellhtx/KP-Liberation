/*
    KPLIB_fnc_logistics_calculateFobRangeSeconds

    File: fn_logistics_calculateFobRangeSeconds.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 12:39:15
    Last Update: 2021-05-17 20:35:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Calculates the 'KPLIB_param_fobs_range' in terms of a time window, in seconds.

    Parameters:
        NONE

    Returns:
        The 'KPLIB_param_fobs_range' in terms of a time window, in seconds. [SCALAR]
 */

private _transportSpeedMps = [] call KPLIB_fnc_logistics_calculateTransportSpeedMps;

private _fobRangeSeconds = KPLIB_param_fobs_range / _transportSpeedMps; 

_fobRangeSeconds;
