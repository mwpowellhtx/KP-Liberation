/*
    KPLIB_fnc_admin_onLiberateSectors

    File: fn_admin_onLiberateSectors.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-09 23:28:59
    Last Update: 2021-02-09 23:29:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Useful when debugging, vetting, etc. Back door shorthand liberates sectors
        without needing to engage anything in game.

    Parameter(s):
        _addMarkerNames - marker names to add to the liberated sectors [ARRAY, default: []]
        _removeMarkerNames - marker names to remove from the liberated sectors [ARRAY, default: []]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_addMarkerNames", [], [[]]]
    , ["_removeMarkerNames", [], [[]]]
];

private _selected = _addMarkerNames select {_x in KPLIB_sectors_all && !(_x in KPLIB_sectors_blufor)};

KPLIB_sectors_blufor append _selected;

KPLIB_sectors_blufor = KPLIB_sectors_blufor - _removeMarkerNames;

[] call KPLIB_fnc_init_save;

[] spawn KPLIB_fnc_core_updateSectorMarkers;

true
