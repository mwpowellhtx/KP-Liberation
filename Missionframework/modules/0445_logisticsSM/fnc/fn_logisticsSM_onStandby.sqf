/*
    KPLIB_fnc_logisticsSM_onStandby

    File: fn_logisticsSM_onStandby.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 10:17:04
    Last Update: 2021-03-04 10:17:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Lines on standby, this is a no-op. Nothing to do, nothing to report.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

true;
