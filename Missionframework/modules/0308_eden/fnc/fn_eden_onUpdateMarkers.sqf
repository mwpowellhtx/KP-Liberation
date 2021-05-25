#include "script_component.hpp"
/*
    KPLIB_fnc_eden_onUpdateMarkers

    File: fn_eden_onUpdateMarkers.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 12:17:00
    Last Update: 2021-05-20 20:08:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        CREATE or UPDATE the START BASE MAP MARKERS.

    Parameters:
        NONE

    Reference:
        https://community.bistudio.com/wiki/allMapMarkers
        https://community.bistudio.com/wiki/createMarker
        https://community.bistudio.com/wiki/setMarkerType
        https://community.bistudio.com/wiki/setMarkerText
        https://community.bistudio.com/wiki/setMarkerColor
        https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
 */

// Will not be the case that we have an unnamed START BASE PROXY object
private _startbases = missionNamespace getVariable [Q(KPLIB_sectors_startbases), []];

{
    private _proxy = missionNamespace getVariable [_x, objNull];
    private _proxyPos = (getPos _proxy) vectorAdd [0, 0, 0.1];

    if (!(_x in allMapMarkers)) then {
        createMarker [_x, _proxyPos];
    };

    private _markerText = _proxy getVariable [QMVAR(_markerText), localize "STR_KPLIB_MAINBASE"];

    _x setMarkerPos _proxyPos;
    _x setMarkerType MPRESET(_markerType);
    _x setMarkerText _markerText;
    _x setMarkerColor KPLIB_preset_colorF;

} forEach _startbases;

true;
