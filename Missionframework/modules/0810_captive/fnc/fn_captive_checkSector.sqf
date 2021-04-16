/*
    KPLIB_fnc_captive_checkSector

    File: fn_captive_checkSector.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-09-10
    Last Update: 2021-04-06 15:47:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Checks the given sector for remaining enemys and lets them surrender.

    Parameter(s):
        _sector - Sector marker [STRING, defaults to ""]

    Returns:
        Function reached the end [BOOL]
 */

// TODO: TBD: should refactor to either sectors? possibly just units... kind of borderline...
params [
    ["_sector", "", [""]]
];

// Exit if no sector is given
if (_sector isEqualTo "") exitWith {
    false
};

private _sectorPos = getMarkerPos _sector;

// TODO: TBD: times 2? no, use 'act' range
private _units = _sectorPos nearEntities ["Man", KPLIB_param_sectors_capRange * 2];

private _unitsToSurrender = _units select {
    side _x isEqualTo KPLIB_preset_sideE;
};

// Check the sector for remaining units
{ [_x] call KPLIB_fnc_captive_setSurrender; } forEach _unitsToSurrender;

true;
