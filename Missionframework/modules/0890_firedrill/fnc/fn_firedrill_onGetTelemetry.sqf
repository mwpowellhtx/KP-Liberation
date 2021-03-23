#include "script_component.hpp"
/*
    KPLIB_fnc_firedrill_onGetTelemetry

    File: fn_firedrill_onGetTelemetry.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 16:42:28
    Last Update: 2021-03-20 17:01:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the telemetry for the mission.

    Parameter(s):
        _mission - a CBA MISSION namespace [LOCATION, default: locationNull]

    Returns:
        The MISSION TELEMETRY [ARRAY]
 */

params [
    [Q(_mission), locationNull, [locationNull]]
];

[
    [QPVAR1(_players), []]
    , [QPVAR1(_range), KPLIB_param_fobRage]
    , [QMVAR(_fobs), KPLIB_sectors_fobs]
    , [QMVAR(_playersWithin), []]
] apply {
    _mission getVariable _x;
} params [
    Q(_players)
    , Q(_range)
    , Q(_fobs)
    , Q(_playersWithin)
];

[
    [localize "STR_KPLIB_MISSION_FIREDRILL_MISSION_UNITS_TEXT", str (count _players)]
    , [localize "STR_KPLIB_MISSION_FIREDRILL_MISSION_WITHIN_TEXT", str (count _playersWithin)]
    , [localize "STR_KPLIB_MISSION_FIREDRILL_MISSION_FOBS_TEXT", str (count _fobs)]
    , [localize "STR_KPLIB_MISSION_FIREDRILL_MISSION_RANGE_TEXT", str _range]
];
