/*
    KPLIB_fnc_missions_onNoOp

    File: fn_missions_onNoOp.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 20:29:21
    Last Update: 2021-03-19 20:29:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        A default, no-op placeholder.

    Parameter(s):
        _namespace - [LOCATION, default: locationNull]
        _args - the arguments [ARRAY, default: []]
        _callerName - the caller name invoking the event handler [STRING, default: "fn_missions_onNoOp"]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_args", [], [[]]]
    , ["_callerName", "fn_missions_onNoOp", [""]]
];

false;
