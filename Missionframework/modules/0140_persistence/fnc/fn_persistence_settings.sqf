
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
                , {}
            ];
        }
    ]
];

private _settings = +[
    [
        // Refresh the KPLIB_persistence_objects every period in seconds [default: 15]
        "KPLIB_param_persistence_refreshObjectsPeriodSeconds"
        , {
            [
                _this
                , "SLIDER"
                , [localize "STR_KPLIB_SETTINGS_PERSISTENCE_REFRESH_OBJECTS_PERIOD", localize "STR_KPLIB_SETTINGS_PERSISTENCE_REFRESH_OBJECTS_PERIOD_TT"]
                , localize "STR_KPLIB_SETTINGS_PERSISTENCE"
                , [3, 900, 15, 0] // default: 3s, range: [3s, 900s], or [0:03, 15:00]
                , 2
                , {}
            ];
        }
    ]
];

{
    [_x, _forEachIndex] call KPLIB_fnc_config_onRegisterSettings;
} forEach [_debug, _settings];

true;
