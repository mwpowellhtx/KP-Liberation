/*
    KPLIB_fnc_config_onRegisterSetting

    File: fn_config_onRegisterSetting.sqf
    Author: Michael W. Powell [22nd MEU SOD]
    Created: 2021-01-29 09:14:41
    Last Update: 2021-01-29 09:14:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Registers the _varName with the CBA settings given _getReg specification.

    Parameter(s):
        _varName
        _getReg

    Returns:
        Function reached the end [BOOL]
*/

_x params [
    ["_varName", "", [""]]
    , ["_getReg", {[]}, [{}]]
];

private _settingIndex = _forEachIndex;

private _reg = _varName call _getReg;

if (_reg isEqualTo []) exitWith {
    diag_log text format ["[CONFIG] [fn_config_onRegisterSetting] registration failed [_settingIndex, _varName]: %1", str [_settingIndex, _varName]];
    false
};

// According to the CBA docs, see: https://cbateam.github.io/CBA_A3/docs/files/settings/fnc_init-sqf.html
private _status = _reg call CBA_Settings_fnc_init;

// We do not have logging installed yet when this is evaluated.
diag_log text format ["[CONFIG] [fn_config_onRegisterSetting] registered [_settingIndex, _varName, _status]: %1", str [_settingIndex, _varName, _status]];

private _success = 0;

_status == _success
