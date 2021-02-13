/*
    KPLIB_fnc_common_getTargetMarkerInRange

    File: fn_common_getTargetMarkerInRange.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-13 07:44:13
    Last Update: 2021-02-13 07:44:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the sector '_markerName' corresponding to the nearest sector from the
        specified '_sectors'.

    Parameter(s):
        _target - the object from which to gauge nearest sector [OBJECT, default: player]
        _range - the range within which _target should be of the nearest marker [SCALAR, default: 0]
        _sectors - a sectors array;
            [nil, default: (KPLIB_sectors_all + KPLIB_sectors_edens + KPLIB_sectors_fobs)]
            [ARRAY]
        _default - a default return value in the event a result could not be obtained [STRING, default: ""]

    Returns:
        Whether the '_target' is in '_range' of the nearest marker within '_sectors' [BOOL]
 */

params [
    ["_target", player, [objNull]]
    , ["_range", 0, [0]]
    , "_sectors"
    , ["_default", "", [""]]
];

private _nearestMarker = if (isNil "_sectors") then {
    [_target, nil, _default] call KPLIB_fnc_common_getNearestMarker;
} else {
    [_target, _sectors, _default] call KPLIB_fnc_common_getNearestMarker;
};

_range >= ((markerPos _nearestMarker) distance2D _target);
