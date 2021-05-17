/*
    KPLIB_fnc_resources_estimateCrates

    File: fn_resources_estimateCrates.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 10:48:08
    Last Update: 2021-02-10 10:48:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Estimates the number of crates required to support the volume

    Parameter(s):
        _volume - the volume which crate requirement is being estimated [SCALAR, default: 0]

    Returns:
        The number of crates required to support the volume [SCALAR, default: 0]
*/

params [
    ["_volume", 0, [0]]
];

// TODO: TBD: replace the half dozen or a dozen or so "manual" calculations with this one
ceil (_volume / KPLIB_param_crateVolume);
