/*
    KPLIB_fnc_logistics_calculateTransportSpeedMps

    File: fn_logistics_calculateTransportSpeedMps.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-26 10:36:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Calculates the transport speed in 'meters per second' based on the CBA settings.

    Parameters:
        _speedKph - the speed in kilometers per hour (kph) [SCALAR, default: KPLIB_param_logistics_transportSpeedKph]

    Returns:
        The estimated transport speed in 'meters per second' based on the CBA settings.

    Remarks:
        Careful with this one. It may require constantly recalibrating running logistics assets
        taking into consideration the updated velocity. We will need to do additional bookkeeping,
        keeping track of current position, etc, in order to accurately gauge if and when that should
        occur. Which is not hard to do, just as long as we remember to do so. Each namespace should
        carry a 'KPLIB_logistics_transportSpeedKph', 'KPLIB_logistics_currentPos', etc, therefore,
        and always check with home parameters.
 */

params [
    ["_speedKph", KPLIB_param_logistics_transportSpeedKph, [0]]
];

_speedKph * KPLIB_uom_kph_to_mps;
