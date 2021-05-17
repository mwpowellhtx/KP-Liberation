/*
    KPLIB_fnc_notification_show

    File: fn_notification_show.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-04 13:34:54
    Last Update: 2021-04-04 13:34:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:

    Parameter(s):
        _template - the CfgNotifications template to use [STRING, default: "Default"]
        _arguments - the string replacement arguments to use [ARRAY, default: []]
        _targets - optional targets, see 'remoteExec' for possible variations, but,
            we expect most commonly array of players, client identifiers, or singles

    Returns:
        The callback finished [BOOL]

    References:
        https://community.bistudio.com/wiki/remoteExec
        https://community.bistudio.com/wiki/BIS_fnc_showNotification
*/

params [
    ["_template", "Default", [""]]
    , ["_arguments", [], [[]]]
    , "_targets"
];

// Targets unspecified meaning the local
if (isNil "_targets") then {
    if (!hasInterface) exitWith { false; };
    [_template, _arguments] call BIS_fnc_showNotification;
} else {
    // Otherwise notify remotely
    [_template, _arguments] remoteExec ["BIS_fnc_showNotification", _targets];
};

true;
