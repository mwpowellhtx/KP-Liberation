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

params [
    ["_fob", KPLIB_fob_empty, [[]], 2]
];

// TODO: TBD: do some logging...
if (_fob isEqualTo []) exitWith {false};

[_fob#0#3, _fob#1#2, _fob#1#3] params ["_pos", "_est", "_uuid"];

if (!([_uuid] call KPLIB_fnc_uuid_verify_string)) exitWith {false};

if (_pos isEqualTo KPLIB_zeroPos) exitWith {false};

private _i = KPLIB_sectors_fobs findIf {(_x#1#3) isEqualTo _uuid};
//                           1. _uuid:   ^^^^^^

if (_i < 0) exitWith {false};

// FOB was rebuilt, replace the tuple in the parent collection.
private _new = [_pos, _est, _uuid] call KPLIB_fnc_core_buildFob;

KPLIB_sectors_fobs set [_i, _new];

["KPLIB_fob_built", _rebuilt] call CBA_fnc_globalEvent;

// Returns with a simple check that the bits were restored correctly.
_new isEqualTo _fob
