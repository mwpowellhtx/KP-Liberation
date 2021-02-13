/*
    KPLIB_fnc_eden_onUpdateMarkers

    File: fn_eden_onUpdateMarkers.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 12:17:00
    Last Update: 2021-02-13 10:00:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates or updates the markers associated with each of the known Eden tuples.

    Parameters:
        NONE

    Reference:
        https://community.bistudio.com/wiki/allMapMarkers
        https://community.bistudio.com/wiki/createMarker
        https://community.bistudio.com/wiki/setMarkerPos
        https://community.bistudio.com/wiki/setMarkerType
        https://community.bistudio.com/wiki/setMarkerText
        https://community.bistudio.com/wiki/setMarkerColor
        https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
*/



// Cannot create markers for empty names
private _selected = (missionNamespace getVariable ["KPLIB_sectors_edens", []]) select {
    !((_x#0) isEqualTo "");
};

// Working with 'KPLIB_sectors_edens' elements...
{
    // Because we simplified FOB and Eden tuple shapes...
    _x params [
        ["_markerName", "", [""]]
        , ["_markerText", "", [""]]
        , ["_varName", "", [""]]
        , ["_uuid", "", [""]]
        , ["_pos", KPLIB_zeroPos, [[]], 3]
        , ["_est", [], [[]], 7]
    ];

    // Only create the marker one time
    if (!(_markerName in allMapMarkers)) then {
        createMarker [_markerName, _pos];
    };

    _markerName setMarkerPos _pos;
    _markerName setMarkerType KPLIB_eden_markerType;
    _markerName setMarkerText _markerText;
    _markerName setMarkerColor KPLIB_preset_colorF;

} forEach _selected;

true;
