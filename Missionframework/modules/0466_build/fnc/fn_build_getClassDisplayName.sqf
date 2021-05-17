/*
    KPLIB_fnc_build_getClassDisplayName

    File: fn_build_getClassDisplayName.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-12 16:37:11
    Last Update: 2021-03-12 16:37:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether module debug is suggested.

    Parameter(s):
        _className - the class name being considered [STRING, default: ""]
        _config - the config to use as a default source [CONFIG, default: configNull]

    Returns:
        Whether module debug is suggested [BOOL]

    References:
        https://community.bistudio.com/wiki/getOrDefault
        https://community.bistudio.com/wiki/Category:Command_Group:_HashMap
 */

params [
    ["_className", "", [""]]
    , ["_config", configNull, [configNull]]
];

if (isNull _config) then {
    _config = [] call { configFile >> "CfgVehicles"; };
};

private _displayName = KPLIB_build_buildItemRegistry getOrDefault [
    _className
    , getText (_config >> _className >> "displayName")
];

_displayName;
