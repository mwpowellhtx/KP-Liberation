/*
    KPLIB_fnc_eden_create

    File: fn_eden_create.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-27 11:44:00
    Last Update: 2021-01-27 11:44:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates an Eden tuple corresponding to the input parameters.

    Parameter(s):
        _varName - the 'missionNamespace' variable name [STRING, default: ""]
        _proxy - the 'missionNamespace' object corresponding _varName [OBJECT, default: ""]
        _side - the side, in game terms, of the tuple [SIDE, default: KPLIB_preset_sideF]

    Returns:
        [] - when _proxy was objNull

        When _proxy is valid the return tuple is complete:
        [
            _varName
            , [_uuid, systemTime]
            , [_sectorType = KPLIB_sectorType_eden, _pos = getPosATL _proxy, _side]
            , [_markerName, _markerText]
        ]
*/

params [
    ["_varName", "", [""]]
    , ["_proxy", objNull, [objNull]]
];

if (isNull _proxy) then {
    _proxy = missionNamespace getVariable [_varName, objNull];
};

// And if proxy is STILL null, then return empty.
if (isNull _proxy) exitWith {[]};

private _bookkeeping = +[
    call KPLIB_fnc_uuid_create_string
    , systemTime
];

private _sector = [
    KPLIB_sectorType_eden
    , getPosATL _proxy
    , KPLIB_preset_sideF
];

private _marker = [
    [_varName, "_marker"] joinString ""
    , _proxy getVariable ["KPLIB_eden_markerText", localize "STR_KPLIB_MAINBASE"]
];

+[
    _varName
    , _bookkeeping
    , _sector
    , _marker
]
