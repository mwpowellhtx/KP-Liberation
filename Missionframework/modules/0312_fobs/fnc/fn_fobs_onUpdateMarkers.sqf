#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_onUpdateMarkers

    File: fn_fobs_onUpdateMarkers.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-17 20:09:46
    Last Update: 2021-05-21 12:19:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when UPDATE MARKERS event is raised.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAM(_onUpdateMarkers_debug);

{
    private _debugForEach = _debug
        || (_x getVariable [QMVAR(_onUpdateMarkers_debug), false]);

    [_x, _forEachIndex] call MFUNC(_onUpdateMarkerOne);

} forEach MVAR(_allBuildings);

KPLIB_sectors_fobs = MVAR(_allBuildings) apply { _x getVariable [QMVAR(_markerName), ""]; };
publicVariable Q(KPLIB_sectors_fobs);

true;
