/*
    KPLIB_fnc_resources_getFactoryStorages

    File: fn_resources_getFactoryStorages.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-15 20:44:04
    Last Update: 2021-04-16 08:44:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the storage container '_classNames' within '_range' of the factory sector '_markerName'.

    Parameter(s):
        _markerName - the marker name corresponding to the factory in question [STRING, default: ""]
        _classNames - the storage class names to consider during the inquiry [ARRAY, default: []]
        _range - the range about which to inquire about storage containers [SCALAR, default: 0]

    Returns:
        Storage containers in proximity of the designated factory marker [ARRAY]
 */

params [
    ["_markerName", "", [""]]
    , ["_classNames", [KPLIB_preset_storageSmallF], [[]]]
    , ["_range", KPLIB_param_sectors_capRange, [0]]
];

private _retval = [];

if (!(_markerName in allMapMarkers)) exitWith {
    _retval;
};

private _candidates = nearestObjects [(markerPos _markerName), _classNames, _range];

// TODO: TBD: likely ditto here, "when" is this happening relative to build confirmed? / https://github.com/mwpowellhtx/KP-Liberation/issues/60

/* There should not be any overlap, but in the event there is, we can discern that.
 * This is also where the pattern deviates slightly versus FOB storage containers. */

_retval = _candidates select {
    (_x getVariable ["KPLIB_sector_markerName", ""]) isEqualTo _markerName;
};

_retval;
