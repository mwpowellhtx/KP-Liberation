/*
    KPLIB_fnc_markers_delete

    File: fn_markers_delete.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-10 10:24:11
    Last Update: 2021-03-11 10:43:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Deletes the marker locally given the marker name.

    Parameters:
        _markerName - the marker name to delete [STRING, default: ""]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_markerName", "", [""]]
];

if (_markerName in allMapMarkers) then {
    deleteMarkerLocal _markerName;
};

true;
