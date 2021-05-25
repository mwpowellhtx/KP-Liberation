#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_onUpdateMarkerOne

    File: fb_fobs_onUpdateMarkerOne.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-18 09:47:05
    Last Update: 2021-05-24 22:33:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Updates the marker details for the FOB BUILDING.

    Parameter(s):
        _fobBuilding - an FOB BUILDING object [OBJECT, default: objNull]
        _fobIndex - the INDEX of the FOB BUILDING [SCALAR, default: -1]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/createMarker
        https://community.bistudio.com/wiki/setMarkerType
        https://community.bistudio.com/wiki/setMarkerSize
        https://community.bistudio.com/wiki/setMarkerColor
        https://community.bistudio.com/wiki/setMarkerPos
        https://community.bistudio.com/wiki/setMarkerText
        https://community.bistudio.com/wiki/CfgMarkers
        https://community.bistudio.com/wiki/Category:Command_Group:_Markers
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
 */

params [
    [Q(_fobBuilding), objNull, [objNull]]
    , [Q(_fobIndex), -1, [0]]
];

private _debug = MPARAM(_onUpdateMarkerOne_debug)
    || (_fobBuilding getVariable [QMVAR(_onUpdateMarkerOne_debug), false])
    ;

if (_debug) then {
    [format ["[fb_fobs_onUpdateMarkerOne] Entering: [isNull _fobBuilding, _fobIndex]: %1"
        , str [isNull _fobBuilding, _fobIndex]], "FOBS", true] call KPLIB_fnc_common_log;
};

if (_fobIndex < 0 || isNull _fobBuilding || !(typeOf _fobBuilding isEqualTo KPLIB_preset_fobBuildingF)) exitWith {
    false;
};

// Assuming the FOB BUILDING exists in the array of ALL BUILDINGS and have been properly appended
[
    getPos _fobBuilding
    , _fobBuilding getVariable [QMVAR(_fobUuid), ""]
    , _fobBuilding getVariable [QMVAR(_markerName), ""]
    , _fobBuilding getVariable [QMVAR(_markerText), ""]
] params [
    Q(_actualPos)
    , Q(_fobUuid)
    , Q(_markerName)
    , Q(_markerText)
];

if (_debug) then {
    [format ["[fb_fobs_onUpdateMarkerOne] Marker and uuid: [_markerName, _markerText, _fobUuid]: %1"
        , str [_markerName, _markerText, _fobUuid]], "FOBS", true] call KPLIB_fnc_common_log;
};

// We will replace the marker assuming INDEXING changed
private _newMarkerName = format ["%1%2", MPRESET(_markerPrefix), _fobUuid];

if (_debug) then {
    [format ["[fb_fobs_onUpdateMarkerOne] New marker name and text: [_newMarkerName, _newMarkerText]: %1"
        , str [_newMarkerName, _newMarkerText]], "FOBS", true] call KPLIB_fnc_common_log;
};

if (_markerName in allMapMarkers && !(_newMarkerName isEqualTo _markerName)) then {
    deleteMarker _markerName;
};

_markerName = _newMarkerName;

if (!(_markerName in allMapMarkers)) then {

    _markerName = _newMarkerName;

    createMarker [_markerName, getPos _fobBuilding];

    _markerName setMarkerType MPRESET(_markerType);
    _markerName setMarkerSize MPRESET(_markerSize);
    _markerName setMarkerColor MPRESET(_markerColor);
};

// Aligns both marker TEXT and POSITION to that of the current FOB BUILDING
{
    _x params [Q(_value), Q(_get), Q(_set)];
    private _oldValue = [] call _get;
    if (!(_value isEqualTo _oldValue)) then { _value call _set; };
} forEach [
    [
        _markerText
        , { markerText _markerName; }
        , { _markerName setMarkerText _this; }
    ]
    , [
        _actualPos
        , { markerPos _markerName; }
        , { _markerName setMarkerPos _this; }
    ]
];

if (_debug) then {
    ["[fb_fobs_onUpdateMarkerOne] Fini", "FOBS", true] call KPLIB_fnc_common_log;
};

true;
