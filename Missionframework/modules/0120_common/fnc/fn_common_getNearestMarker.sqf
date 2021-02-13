/*
    KPLIB_fnc_common_getNearestMarker

    File: fn_common_getNearestMarker.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-13 07:44:25
    Last Update: 2021-02-13 07:01:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the sector '_markerName' corresponding to the nearest sector from the
        specified '_sectors'.

    Parameter(s):
        _target - the object from which to gauge nearest sector [OBJECT, default: player]
        _sectors - a sectors array;
            [nil, default: (KPLIB_sectors_all + KPLIB_sectors_edens + KPLIB_sectors_fobs)]
            [ARRAY]
        _default - a default return value in the event a result could not be obtained [STRING, default: ""]

    Returns:
        The sector '_markerName' corresponding with the nearest sector to the '_target' [STRING, default: _default]
 */

params [
    ["_target", player, [objNull]]
    , "_sectors"
    , ["_default", "", [""]]
];

// Yes, we know the shapes will be different, so we must transform them...
if (isNil "_sectors") then {
    _sectors = (KPLIB_sectors_all + KPLIB_sectors_edens + KPLIB_sectors_fobs);
};

// Assuming sectors is now presentable, transform to the _markerName elements themselves
_sectors = _sectors apply {
    switch (typeName _x) do {
        case "STRING": { _x; };
        case "ARRAY": {
            // Assuming a consistent start base Eden or FOB shape...
            private _markerName = (_x#0);
            _markerName;
        };
        default { ""; };
    };
} select { !(_x isEqualTo ""); };

private _nearest = _default;

// Get the nearest one and leave it to the caller to decide other bits like within range
if (!(_sectors isEqualTo [])) then {
    _nearest = [_sectors, { (markerPos (_this#0)) distance2D _target; }] call KPLIB_fnc_linq_min;
};

_nearest;
