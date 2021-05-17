/*
    KPLIB_fnc_common_getPresetClass

    File: fn_common_getPresetClass.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-12-08
    Last Update: 2021-05-03 13:46:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Gets class or array of given type from preset.

    Parameter(s):
        _type - Preset type name [STRING, default: ""]
        _side - Preset side [SIDE, default: KPLIB_preset_sideE]
        _isArray - Array of classnames (true) or single classname (false) [BOOL, default: false]

    Returns:
        Classname from preset [STRING]
 */

params [
    ["_type", "", [""]]
    , ["_side", KPLIB_preset_sideE, [sideEmpty]]
    , ["_isArray", false, [false]]
];

// TODO: TBD: refactor side+suffix to a function...
// Determine classname side
private _sideSuffix = switch (_side) do {
    case KPLIB_preset_sideF: { "F"; };
    case KPLIB_preset_sideR: { "R"; };
    case KPLIB_preset_sideC: { "C"; };
    default { "E"; };
};

// TODO: TBD: what is "PL" in terms of it being "an array" (?) ...
private _classNamesVar = if (_isArray) then {
    format ["KPLIB_preset_%1Pl%2", _type, _sideSuffix];
} else {
    format ["KPLIB_preset_%1%2", _type, _sideSuffix]
};

private _classNames = missionNamespace getVariable _classNamesVar;

// Exit if there are no classnames of given type in preset
if (isNil { _classNames; }) exitWith {
    [format ["Could not find preset variable '%1'", _classNamesVar], "COMMON", true] call KPLIB_fnc_common_log;
    "";
};

// Return class name(s)
_classNames;
