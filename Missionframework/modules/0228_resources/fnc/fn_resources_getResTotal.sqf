/*
    KPLIB_fnc_resources_getResTotal

    File: fn_resources_getResTotal.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-16
    Last Update: 2021-05-23 15:07:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the TOTAL RESOURCES currently stored at the location corresponding
        to the MARKER NAME.

    Parameter(s):
        _markerName - a MARKER NAME about which to consider [STRING, default: "]
        _range - a RANGE about which to consider [SCALAR, default: KPLIB_param_fobs_range]

    Returns:
        Total RESOURCES [ARRAY]
            [
                "[_s]upply"
                , "[_a]mmo"
                , "[_f]uel"
            ]
 */

// TODO: TBD: we are not ready for a deeper dive into the whole "resources" question...
// TODO: TBD: but we do need to address the notion of "named locations" ...
// TODO: TBD: for starters, we should be specific about what is "location"...
// TODO: TBD: from its usage here, presumably throughout, we say it is "_markerName"
// TODO: TBD: which the caller should have in hand given the tuples...

// TODO: TBD: thinking twice about it... FOB BUILDING is a distraction...
// TODO: TBD: yes, we would like the object to be present and valid, and it will be validated...
// TODO: TBD: but at this level, what we are more concerned with is an actual MAP MARKER...
// TODO: TBD: either an actual SECTOR MARKER, or an FOB MARKER...
params [
    ["_markerName", "", [""]]
    , ["_range", KPLIB_param_fobs_range, [0]]
];

private _resources = [0, 0, 0];

if (_markerName isEqualTo "") exitWith { _resources; };

// Get all storage areas in proximity of the marker
private _storages = nearestObjects [markerPos _markerName, KPLIB_resources_storageClasses, _range];

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

_resources = [_supplies, _ammo, _fuel];

_resources;
