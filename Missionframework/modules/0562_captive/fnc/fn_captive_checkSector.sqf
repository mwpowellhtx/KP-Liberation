/*
    KPLIB_fnc_captive_checkSector

    File: fn_captive_checkSector.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-09-10
    Last Update: 2021-04-20 18:28:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Checks the given SECTOR marker name for remaining enemies and lets them surrender.

    Parameter(s):
        _markerName - a SECTOR marker name [STRING, default: ""]
        _range - RANGE about which to surrender surviving untis
            [SCALAR, default: KPLIB_param_sectors_actRange]

    Returns:
        Function reached the end [BOOL]
 */

// TODO: TBD: should refactor to either sectors? possibly just units... kind of borderline...
params [
    ["_markerName", "", [""]]
    , ["_range", KPLIB_param_sectors_actRange, [0]]
];

// Exit if no sector is given
if (_markerName isEqualTo "") exitWith {
    false;
};

private _markerPos = markerPos _markerName;
private _units = _markerPos nearEntities ["Man", _range];

// Surrender ALIVE units aligned with ENEMY
private _unitsToSurrender = _units select {
    private _null = isNull _x;
    private _alive = alive _x;
    private _aligned = side _x isEqualTo KPLIB_preset_sideE;
    !_null
        && _alive
        && _aligned;
};

{ [_x] call KPLIB_fnc_captive_setSurrender; } forEach _unitsToSurrender;

true;
