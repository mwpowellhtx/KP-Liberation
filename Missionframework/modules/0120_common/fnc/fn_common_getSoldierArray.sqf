/*
    KPLIB_fnc_common_getSoldierArray

    File: fn_common_getSoldierArray.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-03-31
    Last Update: 2021-05-04 19:39:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the UNITS class names minus excluded variable name associates aligned
        with the SIDE.

    Parameter(s):
        _side - the SIDE for which to request UNITS class names [SIDE, default: KPLIB_preset_sideE]

    Returns:
        The UNITS class names [ARRAY]
 */

private _defaultExcludeVars = [
    "rsCrewmanHeli", "rsCrewmanVeh", "rsPilotHeli"
    , "rsPilotJet", "rsParatrooper", "rsSurvivor"
];

params [
    ["_side", KPLIB_preset_sideE, [sideEmpty]]
    , ["_excludeVars", _defaultExcludeVars, [[]]]
];

[
    ["units", _side, true] call KPLIB_fnc_common_getPresetClass
    , _excludeVars apply { [_x, _side] call KPLIB_fnc_common_getPresetClass; }
] params [
    "_unitClassNames"
    , "_excludeClassNames"
];

_unitClassNames - _excludeClassNames;
