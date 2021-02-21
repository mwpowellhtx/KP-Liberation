/*
    KPLIB_fnc_productionsm_onForcedPublication

    File: fn_productionsm_onForcedPublication.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-21 16:24:23
    Last Update: 2021-02-21 16:24:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Indicates that state publication should occur, if possible, regardless
        of the current publication timer.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

private _objSM = KPLIB_productionsm_objSM;

params [
    ["_namespace", locationNull, [locationNull]]
];

_objSM setVariable ["KPLIB_productionsm_forced", true];

true;
