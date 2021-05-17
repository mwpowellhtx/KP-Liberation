/*
    KPLIB_fnc_config_onRegisterSettings

    File: fn_config_onRegisterSettings.sqf
    Author: Michael W. Powell [22nd MEU SOD]
    Created: 2021-01-29 11:26:08
    Last Update: 2021-01-29 11:26:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a presets setting value specification.

    Parameter(s):
        _settings - The settings to be registered [ARRAY, default: []]
        _index - The index of the array being processed [SCALAR, default: -1]

    Returns:
        When registration has completed [BOOL]
*/

params [
    ["_settings", [], [[]]]
    , ["_index", -1, [0]]
];

diag_log text format ["[CONFIG] [fn_config_onRegisterSettings] registering %1 settings: [_index]: %2", count _settings, str [_index]];

KPLIB_fnc_config_onRegisterSetting forEach _settings;

true
