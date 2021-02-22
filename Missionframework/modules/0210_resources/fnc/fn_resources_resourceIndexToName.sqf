/*
    KPLIB_fnc_resources_resourceIndexToName

    File: fn_resources_resourceIndexToName.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-21 20:32:21
    Last Update: 2021-02-21 20:32:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the textual name for the '_resourceIndex' value.

    Parameter(s):
        _resourceIndex - the resouce index [SCALAR, default: KPLIB_resouces_i_sup]

    Returns:
        The textual name for the '_resourceIndex' [STRING]
            0: supply
            1: ammo
            2: fuel
 */

params [
    ["_resourceIndex", KPLIB_resouces_i_sup, [0]]
];

private _key = switch {_resourceIndex} do {
    case KPLIB_resources_i_sup: {
        "STR_KPLIB_PRODUCTION_CAPABILITY_SUPPLY";
    };
    case KPLIB_resources_i_amm: {
        "STR_KPLIB_PRODUCTION_CAPABILITY_AMMO";
    };
    case KPLIB_resources_i_fue: {
        "STR_KPLIB_PRODUCTION_CAPABILITY_FUEL";
    };
    default {
        "STR_KPLIB_PRODUCTION_CAPABILITY_NA";
    };
};

localize _key;
