/*
    KPLIB_fnc_core_rebuildFob

    File: fn_core_rebuildFob.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-26 21:28:23
    Last Update: 2021-01-26 21:28:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Rebuilds an FOB upon loading the data.

    Parameters:
        _fob - An FOB tuple used to inform the rebuilding procedure [ARRAY, default: []]

    Returns:
        The FOB specification including the marker name [ARRAY, [_uuid, _est, _pos, _markerName, _markerText]]
            - Note that _markerText is blank at this moment since we cannot know precise index
*/

// TODO: TBD: refactor to init, pre-init, etc...
private _fobEmpty = +[
    ""
    , [KPLIB_uuid_zero, systemTime]
    , [KPLIB_sectorType_nil, KPLIB_zeroPos, KPLIB_preset_sideF]
    , ["", ""]
];

params [
    ["_fob", _fobEmpty, [[]], 4]
];

// TODO: TBD: do some logging...

if (_fob isEqualTo []) exitWith {false};

[
    _fob select 2 select 1
    , _fob select 1 select 0
    , _fob select 1 select 1
] params ["_pos", "_uuid", "_est"];

if (_pos isEqualTo KPLIB_zeroPos) exitWith {false};

// Rebuild the FOB from the serialized position.
private _rebuilt = [_pos, _est, _uuid] call KPLIB_fnc_core_buildFob;

{
    _rebuilt set [_x, +(_fob select _x)];
} forEach [
    1 // bookkeeping
    , 2 // sector, although we were given a position, still replace it
    , 3 // marker
];

// An swap in the loaded FOB tuple.
KPLIB_sectors_fobs set [count KPLIB_sectors_fobs - 1, _rebuilt];

["KPLIB_fob_built", _rebuilt] call CBA_fnc_globalEvent;

// TODO: TBD: the UUID check probably ought to run prior to any of it...
// Returns with a simple check that the bits were restored correctly
[_uuid] call KPLIB_fnc_uuid_verify_string
&& !((_rebuilt select 0) isEqualTo (_fob select 0))
