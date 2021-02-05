/*
    KPLIB_fnc_production_create

    File: fn_production_create.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 17:29:44
    Last Update: 2021-02-04 17:29:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Renders the '_markerText' for the given '_production' tuple.

    Parameter(s):
        _markerName - the marker name of the discovered 'KPLIB_sectors_factory' site [STRING, default: ""]

    Returns:
        A newly minted '_production' tuple corresponding to the '_markerName' input.
        When invalid returns empty, i.e. '[]'.
*/

params [
    ["_markerName", "", [""]]
];

if (!(_this call KPLIB_fnc_production_exists)) exitWith {[]};

private _production = +KPLIB_production_default;

/* We shall defer the discovery of the _markerText until after reconciling
 * saved data with the current 'KPLIB_sectors_factory' discovery. */

// TODO: TBD: assuming these happen only once...
_production set [KPLIB_production_i_ident, [_markerName, markerText _markerName]];

private _cap = [] call KPLIB_fnc_production_getDefaultCapability;

_production select KPLIB_production_i_info set [KPLIB_production_info_i_cap, _cap];

_production;
