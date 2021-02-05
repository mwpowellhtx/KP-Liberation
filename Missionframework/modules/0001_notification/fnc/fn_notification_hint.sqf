/*
    KPLIB_fnc_notification_hint

    File: fn_notification_hint.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 11:06:52
    Last Update: 2021-02-05 11:06:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:

    Parameter(s):
        _text
        _module
        _tickTime

    Returns:
        Function reached the end [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html#CBA_fnc_waitAndExecute
*/

if (!hasInterface) exitWith {false};

params [
    ["_text", "", [""]]
    , ["_delay", KPLIB_notification_delay, [0]]
];

if (_text isEqualTo "") exitWith {false};

hint _text;

[
    {hintSilent "";}
    , []
    , _delay
] call CBA_fnc_waitAndExecute;

true
