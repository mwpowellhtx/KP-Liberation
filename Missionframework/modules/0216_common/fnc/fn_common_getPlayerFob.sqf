/*
    KPLIB_fnc_common_getPlayerFob

    File: fn_common_getPlayerFob.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-24
    Last Update: 2021-05-23 15:14:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the FOB '_markerName' corresponding to the '_target' proximity.

    Parameter(s):
        _target - the object by which to gauge sector '_markerName' proximity [OBJECT, default: player]

    Returns:
        The sector '_markerName' corresponding with the current '_target' proximity [STRING, default: _default]
 */

// TODO: TBD: should refactor properly to the FOBS module now that we are establishing that...
params [
    ["_target", player, [objNull]]
];

if (KPLIB_sectors_fobs isEqualTo []) exitWith { ""; };

// Which gets updated during the FPS event loops...
private _targetMarker = _target getVariable ["KPLIB_sectors_markerName", ""];
//                                            ^^^^^^^^^^^^^^^^^^^^^^^^

([_targetMarker] arrayIntersect KPLIB_sectors_fobs) params [
    ["_markerName", "", [""]]
];

_markerName;
