/*
    KPLIB_fnc_common_getPlayerFob

    File: fn_common_getPlayerFob.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-24
    Last Update: 2021-02-14 10:57:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the FOB '_markerName' corresponding to the '_target' proximity.

    Parameter(s):
        _target - the object by which to gauge sector '_markerName' proximity [OBJECT, default: player]
        _default - the default marker name [STRING, default '']

    Returns:
        The sector '_markerName' corresponding with the current '_target' proximity [STRING, default: _default]
*/

params [
    ["_target", player, [objNull]]
    , ["_default", "", [""]]
];

// Which gets updated during the FPS event loops...
private _targetMarker = _target getVariable ["KPLIB_sector_markerName", _default];
//                                            ^^^^^^^^^^^^^^^^^^^^^^^

// Verify whether the sector marker name is an FOB...
if ((KPLIB_sectors_fobs select { (_x#0) isEqualTo _targetMarker; }) isEqualTo []) exitWith {
    //                            ^^^^
    _default;
};

_targetMarker;
