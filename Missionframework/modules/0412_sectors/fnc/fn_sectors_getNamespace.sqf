#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getNamespace

    File: fn_sectors_getNamespace.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-21 12:23:35
    Last Update: 2021-04-21 12:23:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the CBA SECTOR namespace corresponding to the MARKER NAME.

    Parameter(s):
        _targetMarker - target CBA SECTOR namespace MARKER NAME [STRING, default: ""]

    Returns:
        The CBA SECTOR namespace corresponding to the target MARKER NAMV [LOCATION]
 */

params [
    [Q(_targetMarker), "", [""]]
];

private _selected = MVAR(_namespaces) select {
    private _markerName = _x getVariable [QMVAR(_markerName), ""];
    _targetMarker isEqualTo _markerName;
};

if (count _selected == 0) exitWith {
    locationNull;
};

(_selected#0);
