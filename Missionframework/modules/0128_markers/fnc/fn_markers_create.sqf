// TODO: TBD: ditto marker...
/*
    KPLIB_fnc_markers_create

    File: fn_markers_create.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-10 10:24:03
    Last Update: 2021-03-11 10:41:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Creates a map marker given nominal arguments, marker name, position, etc.

    Parameters:
        _markerName - the marker name to delete [STRING, default: ""]
        _pos - a 3D position to use for the marker [ARRAY, default: KPLIB_zeroPos]
        _markerType - a marker type [STRING, default: ""]
        _color - a marker color [STRING, default: KPLIB_preset_colorF]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/ctrlMapAnimAdd
        https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
 */

params [
    ["_markerName", "", [""]]
    , ["_pos", +KPLIB_zeroPos, [[]], 3]
    , ["_markerType", "", [""]]
    , ["_color", KPLIB_preset_colorF, [""]]
];

if (!(_markerName in allMapMarkers)) then {
    createMarkerLocal [_markerName, _pos];
} else {
    if (!(_pos isEqualTo (markerPos _markerName))) then {
        _markerName setMarkerPos _pos;
    };
};

if (!(_markerType isEqualTo (markerType _markerName))) then {
    _markerName setMarkerTypeLocal _markerType;
};

if (!(_color isEqualTo (markerColor _markerName))) then {
    _markerName setMarkerColorLocal _color;
};

true;
