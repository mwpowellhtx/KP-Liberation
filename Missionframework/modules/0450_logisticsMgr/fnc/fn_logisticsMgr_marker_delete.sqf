// TODO: TBD: could setup a markers module...
// TODO: TBD: especially approaching this, missions, tracking mobile respawns, etc, will need/want more support for it...
/*
    KPLIB_fnc_logisticsMgr_marker_delete

    File: fn_logisticsMgr_marker_delete.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-10 10:24:11
    Last Update: 2021-03-10 10:24:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Deletes the marker loclally.

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
