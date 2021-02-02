/*
    KPLIB_fnc_core_buildFob

    File: fn_core_buildFob.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Crated: 2018-05-11
    Last Update: 2021-01-26 17:12:04
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
    , ["_est", [], [[]], 7]
    // TODO: TBD: may inject a created UUID at this moment...
    , ["_uuid", "", [""]]
];

private _fob = [_buildPos, _est, _uuid] call KPLIB_fnc_core_createFob;

// TODO: TBD: assumes that the FOB POI does not yet exist...
KPLIB_sectors_fobs pushBack _fob;

// TODO: TBD: circle back on the event, must now handle the FOB shape...
// TODO: TBD: posting the event could/should effectively public the var, also update the markers...
["KPLIB_fob_built", _fob] call CBA_fnc_globalEvent;

// TODO: TBD: we might actually refactor "updating markers" to a separate CBA based event handler...
// TODO: TBD: i.e. update FOB markers, update factory markers, so on and so forth...
// Update the markers prior to publishing.
[] call KPLIB_fnc_core_updateFobMarkers;

publicVariable "KPLIB_sectors_fobs";

_fob
