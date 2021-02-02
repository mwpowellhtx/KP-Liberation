/*
    KPLIB_fnc_common_getPlayerFob

    File: fn_common_getPlayerFob.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-24
    Last Update: 2021-01-29 17:25:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the FOB _markerName corresponding to the _player location.

    Parameter(s):
        _player - the _player from which to obtain the 'KPLIB_sector_info#0' or '_markerName' [OBJECT, default: player]
            - tuples in the shape of, ['_markerName', '_sectorType', '_uuid'], from which we shall select '_this#0' or '_markerName' by default.
        _selector - OPTIONAL, may select bits of the info tuple as needed [CODE, default: {_this#0}]

    Returns:
        '_this#0' or '_markerName' from the '_target' 'KPLIB_sector_info' variable, as specified by the '_selector' parameter.
*/

params [
    ["_target", player, [objNull]]
    , ["_selector", {_this#0}, [{}]]
];

[_target, _selector] call KPLIB_fnc_common_getSectorInfo;
