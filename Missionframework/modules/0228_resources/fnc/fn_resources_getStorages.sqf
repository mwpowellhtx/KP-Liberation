/*
    KPLIB_fnc_resources_getStorages

    File: fn_resources_getStorages.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-16
    Last Update: 2021-05-25 11:26:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns all storages inside given radius of a given position.

    Parameter(s):
        _center - Position AGL from where to look for storages [POSITION AGL, default: KPLIB_zeroPos]
        _radius - Radius from the center [NUMBER, default: KPLIB_param_fobs_range]
        _types - the types to include in the nearest objects query, which allows for smaller
            sets of types, and even transports, rather than static spull bunds, for instance
            [ARRAY, default: KPLIB_resources_storageClasses]

    Returns:
        All found storage objects [ARRAY]
*/

// TODO: TBD: let's consollidate these, 'getting storages'...
// TODO: TBD: the only thing we need is a 'marker', 'class names', and 'range'...

// TODO: TBD: might could phase this one out eventually...
// TODO: TBD: and/or consolidate FOB/FACTORY storage concerns...

// TODO: TBD: instead of "center pos" should consider simply "marker name" since that is now the protocol...
params [
    ["_center", KPLIB_zeroPos, [[]], 3]
    , ["_radius", KPLIB_param_fobs_range, [0]]
    , ["_types", KPLIB_resources_storageClasses, [[]]]
];

nearestObjects [_center, _types, _radius]
