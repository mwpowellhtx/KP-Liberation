/*
    KPLIB_fnc_build_getMovableObjects

    File: fn_build_getMovableObjects.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-14 10:29:59
    Last Update: 2021-05-17 20:33:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Gets the objects currently within the FOB zone and eligible for build move mode.

    Parameter(s):
        _markerName - the FOB zone marker name [STRING, default: ""]

    Returns:
        The objects currently within the FOB zone and eligible for build move mode [ARRAY, default: []]
 */

params [
    ["_markerName", "", [""]]
];

private _objects = [];

if (_markerName in allMapMarkers
    && !((KPLIB_sectors_fobs select { (_x#0) isEqualTo _markerName; }) isEqualTo [])) then {

    // TODO: TBD: may refactor in terms of CBA setting... i.e. 'KPLIB_param_build_moveMaxMomentum'
    private _maxMom = 1;

    _objects = nearestObjects [markerPos _markerName, [], KPLIB_param_fobs_range];
    // Even the abient wildlife...                    ^^

    _objects = _objects select {
        !isNull _x
        // Include only assets that are not currently in flight...
            && abs (speed _x) < _maxMom
            // Gets updated during FPS event loops...
            && (_x getVariable ["KPLIB_sector_markerName", ""]) isEqualTo _markerName
            //                   ^^^^^^^^^^^^^^^^^^^^^^^
            && ((_x getVariable ["KPLIB_asset_isMovable", false])
                || (_x getVariable ["KPLIB_asset_wasSeized", false]))
    };
};

_objects;
