/*
    KPLIB_fnc_core_buildFob

    File: fn_core_buildFob.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Crated: 2018-05-11
    Last Update: 2021-03-12 21:15:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Creates FOB on given position.

    Parameters:
        _buildPos - Object or position where FOB has to be built [ARRAY, default: []]

    Returns:
        The FOB specification as created, [_uuid, _est, _].
*/

params [
    ["_buildPos", KPLIB_zeroPos, [[]], 3]
    , ["_est", systemTime, [[]], 7]
    // TODO: TBD: may inject a created UUID at this moment...
    , ["_uuid", "", [""]]
];

private _fob = [_buildPos] call KPLIB_fnc_core_createFob;

KPLIB_sectors_fobs pushBack _fob;

_fob;
