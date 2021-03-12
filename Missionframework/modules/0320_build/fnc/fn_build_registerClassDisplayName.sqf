/*
    KPLIB_fnc_build_registerClassDisplayName

    File: fn_build_registerClassDisplayName.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-12 16:48:03
    Last Update: 2021-03-12 16:48:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _className - the class name [STRING, default: ""]
        _displayName - the display name [STRING, default: ""]

    Returns:
        The callback finished [BOOL]

    References:
        https://community.bistudio.com/wiki/createHashMap
        https://community.bistudio.com/wiki/set
        https://community.bistudio.com/wiki/keys
        https://community.bistudio.com/wiki/Category:Command_Group:_HashMap
 */

params [
    ["_className", "", [""]]
    , ["_displayName", "", [""]]
];

if (isNil "KPLIB_build_buildItemRegistry") then {
    KPLIB_build_buildItemRegistry = createHashMap;
};

KPLIB_build_buildItemRegistry set [_className, _displayName];

_className in (keys KPLIB_build_buildItemRegistry);
