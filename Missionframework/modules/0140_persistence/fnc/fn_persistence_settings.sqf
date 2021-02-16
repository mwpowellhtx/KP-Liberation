
/*
    KPLIB_fnc_persistence_settings

    File: fn_persistence_settings.sqf
    Author: Michael W. Powell [22nd MEU SOD]
    Created: 2021-01-28 15:24:28
    Last Update: 2021-01-28 15:24:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initializes the CBA settings.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

private _noop = {};

private _debug = +[
    [
        // Enables/Disables extended Liberation debug output for the server log [default: false]
        "KPLIB_param_persistence_debug"
        , {
            [
                _this
                , "CHECKBOX"
                , [localize "STR_KPLIB_SETTINGS_PERSISTENCE_DEBUG", localize "STR_KPLIB_SETTINGS_PERSISTENCE_DEBUG_TT"]
                , localize "STR_KPLIB_SETTINGS_DEBUG"
                , false
                , 2
                , _noop
            ];
        }
    ]
];

{
    [_x, _forEachIndex] call KPLIB_fnc_config_onRegisterSettings;
} forEach [_debug];

true;
