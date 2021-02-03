/*
    KPLIB_fnc_resources_getResTotal

    File: fn_resources_getResTotal.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-16
    Last Update: 2021-01-27 15:05:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Gets total amount of resources from a given sector or FOB.

    Parameter(s):
        _markerName - the _markerName corresponding to the Sector of FOB from which to query resources. [STRING, default: ""]

    Returns:
        Amount of supplies, ammo and fuel [ARRAY]
*/

// TODO: TBD: we are not ready for a deeper dive into the whole "resources" question...
// TODO: TBD: but we do need to address the notion of "named locations" ...
// TODO: TBD: for starters, we should be specific about what is "location"...
// TODO: TBD: from its usage here, presumably throughout, we say it is "_markerName"
// TODO: TBD: which the caller should have in hand given the tuples...
params [
    ["_markerName", "", [""]]
];

private _resources = [0, 0, 0];

// Exit if no location was given
if (_markerName isEqualTo "") exitWith {_resources};

// Get all storage areas in the vicinity of the marker
private _storages = nearestObjects [markerPos _markerName, KPLIB_resources_storageClasses, KPLIB_param_fobRange];

// Get the stored resource values
private _supplies = 0;
private _ammo = 0;
private _fuel = 0;
{
    _resources = [_x] call KPLIB_fnc_resources_getStorageValue;
    _supplies = _supplies + (_resources select 0);
    _ammo = _ammo + (_resources select 1);
    _fuel = _fuel + (_resources select 2);
} forEach _storages;

// Return values
[_supplies, _ammo, _fuel]
