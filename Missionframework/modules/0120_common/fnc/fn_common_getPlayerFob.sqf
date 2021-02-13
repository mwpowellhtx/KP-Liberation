/*
    KPLIB_fnc_common_getPlayerFob

    File: fn_common_getPlayerFob.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-24
    Last Update: 2021-02-13 07:06:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the FOB '_markerName' corresponding to the '_player' location.

    Parameter(s):
        _target - the object from which to gauge nearest FOB [OBJECT, default: player]

    Returns:
        The sector '_markerName' corresponding with the nearest FOB to the '_target' [STRING, default: _default]
*/

params [
    ["_target", player, [objNull]]
];

// TODO: TBD: may need to evaluate in range: 'KPLIB_fnc_common_getTargetMarkerInRange'
[_target, KPLIB_sectors_fobs] call KPLIB_fnc_common_getNearestMarker;
