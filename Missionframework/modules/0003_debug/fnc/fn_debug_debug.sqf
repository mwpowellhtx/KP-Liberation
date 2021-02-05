/*
    KPLIB_fnc_debug_debug

    File: fn_debug_debug.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 13:46:09
    Last Update: 2021-02-04 13:46:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Responds with advice to the caller whether the calling module should be debugged.
        Elements may be either BOOL or CODE in nature. Default is assumed to be BOOL.
        Allows for default 'KPLIB_param_debug'.

    Parameter(s):
        _conditions - An array of BOOL or CODE elements used to evaluate whether to
            debug [ARRAY, default: []]

    Returns:
        Whether the calling module should be debugged [BOOL]
*/

params [
    ["_conditions", [], [[]]]
];

// Always allows the 'KPLIB_param_debug' parameter
if (KPLIB_param_debug) exitWith {true};

// Evaluates each of the conditions over and above the default
private _evaluated = _conditions apply {
    switch (typeName _x) do {
        case "CODE": {[] call _x};
        default {_x};
    };
};

({_x} count _evaluated) > 0;
