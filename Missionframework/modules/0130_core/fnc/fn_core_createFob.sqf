/*
    KPLIB_fnc_core_createFob

    File: fn_core_createFob.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-12
    Last Update: 2021-01-27 21:02:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Establishes the presence of an FOB.

    Parameters:
        _pos - Receives a 3D position in order to place the FOB marker [ARRAY, default: []]
        _est - Receives an optional 'systemTime' [ARRAY, default: systemTime]
        _uuid - Receives an optional UUID string [STRING, default: created via KPLIB_fnc_uuid_create_string]

    Returns:
        The FOB specification including the marker name [ARRAY
            , [
                _varName
                , [_uuid, _systemTime]
                , [_sectorType, _pos, _side]
                , [_markerName, _markerText]
            ]]
            - Note that _markerText is blank at this moment since we cannot know precise index
            - Additionally, there is no real _varName vis-a-via FOB based tuples

    Remarks:
        Expecting that at least a position be passed in as parameters, i.e.
            [_pos] call KPLIB_fnc_core_createFob
*/

params [
    ["_pos", KPLIB_zeroPos, [[]], 3]
    , ["_est", systemTime, [[]], 7]
    , ["_uuid", [] call KPLIB_fnc_uuid_create_string, [""]]
];

if (KPLIB_param_debug) then {
    [format ["[fn_core_createFob] Entering: [_pos, _est, _uuid]: %1", str [_pos, _est, _uuid]], "CORE", true] call KPLIB_fnc_common_log;
};

if (_pos isEqualTo KPLIB_zeroPos) exitWith {
    if (KPLIB_param_debug) then {
        ["[fn_core_createFob] Unable to establish FOB at zero pos", "CORE", true] call KPLIB_fnc_common_log;
    };
    [];
};

private _markerName = format ["KPLIB_fob_%1", _uuid];
// TODO: TBD: upon refactor, i.e. with things such as "calculate marker text" being functionally injected...
private _markerText = "";

// TODO: TBD: more candidates for potentially preset variables... possibly even CBA parameters...
private _markerType = "b_hq";
private _markerSize = [1.5, 1.5];
private _markerColor = "ColorYellow";

// TODO: TBD: should we verify that the marker does not already exist?
// TODO: TBD: could probably refactor "sector markers" to a separate functional area...
// TODO: TBD: that way we focus on the meta data only, i.e. FOB tuple

// We assume that the marker name is unique, no need to capture it again.
/*private _marker =*/ createMarker [_markerName, _pos];

_markerName setMarkerType _markerType;
_markerName setMarkerSize _markerSize;
_markerName setMarkerColor _markerColor;

// There is no 'name' for FOB tuples per se.
private _varName = "";

// Returns with the FOB version of the Sectors tuple.
private _fob = +[
    _varName
    , [_uuid, _est]
    , [KPLIB_sectorType_fob, _pos, KPLIB_preset_sideF]
    , [_markerName, _markerText]
];

if (KPLIB_param_debug) then {
    [format ["[fn_core_createFob] Fini: _fob: %1", str _fob], "CORE", true] call KPLIB_fnc_common_log;
};

_fob;
