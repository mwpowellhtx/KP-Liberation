/*
    KPLIB_fnc_production_exists

    File: fn_production_exists.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 14:50:41
    Last Update: 2021-02-04 14:50:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the _production tuple exists in alignment with the current
        'KPLIB_sectors_factory'. Callers may provide a single '_markerName' to the
        function. Callers should more typically provide the full '_production' tuple,
        i.e. '_production call KPLIB_fnc_production_exists'.

    Parameter(s):
        _markerName - the identifier of the factory marker [STRING, default: ""]

    Returns:
        Whether the '_markerName' exists in the currently known 'KPLIB_sectors_factory' array [BOOL]
*/

params [
    ["_markerName", "", [""]]
];

private _i = KPLIB_sectors_factory findIf {_x isEqualTo _markerName};

_i >= 0;
