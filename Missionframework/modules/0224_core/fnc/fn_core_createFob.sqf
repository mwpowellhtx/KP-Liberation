/*
    KPLIB_fnc_core_createFob

    File: fn_core_createFob.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-12
    Last Update: 2021-02-12 20:36:22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Establishes the presence of an FOB.

    Parameters:
        _pos - Receives a 3D position in order to place the FOB marker [ARRAY, default: []]

    Returns:
        The FOB specification including the marker name [ARRAY
            , [
                _markerName
                , _markerText
                , _varName
                , _uuid
                , _pos
                , _est
            ]
            - Note that _markerText is blank at this moment since we cannot know precise index
            - Additionally, there is no real _varName vis-a-via FOB based tuples

    Remarks:
        Expecting that at least a position be passed in as parameters, i.e.
            [_pos] call KPLIB_fnc_core_createFob
*/

// TODO: TBD: refactor this to FOBS module, if necessary...
private _debug = [] call KPLIB_fnc_debug_debug;

params [
    ["_pos", KPLIB_zeroPos, [[]], 3]
];

if (_debug) then {
    [format ["[fn_core_createFob] Entering: [_pos, _est, _uuid]: %1", str [_pos, _est, _uuid]], "CORE", true] call KPLIB_fnc_common_log;
};

if (_pos isEqualTo KPLIB_zeroPos) exitWith {
    if (_debug) then {
        ["[fn_core_createFob] Unable to establish FOB at zero pos", "CORE", true] call KPLIB_fnc_common_log;
    };
    [];
};

private _markerName = format ["KPLIB_fob_%1", _uuid];

// TODO: TBD: upon refactor, i.e. with things such as "calculate marker text" being functionally injected...
["", "", ""] params [
    "_markerName"
    , "_markerText"
    , "_varName"
];

// TODO: TBD: should consider refactoring FOB bits to namespaces versus arrays...
// Simplify the FOB tuple
private _fob = +[
    _markerName
    , _markerText
    , _varName
    , ([] call KPLIB_fnc_uuid_create_string)
    , _pos
    , systemTime
];

if (_debug) then {
    [format ["[fn_core_createFob] Fini: _fob: %1", str _fob], "CORE", true] call KPLIB_fnc_common_log;
};

_fob;
