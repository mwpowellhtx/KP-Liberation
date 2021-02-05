/*
    KPLIB_fnc_notification_hint

    File: fn_notification_hint.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 11:06:52
    Last Update: 2021-02-05 15:25:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:

    Parameter(s):
        _text - the text to display [STRING, default: ""]
        _delay - how long, in seconds, to wait until clearing the notification hint [SCALAR, default: KPLIB_notification_delay]
        _adaptive - may wait a little longer for longer hint notifications [BOOL, default: true]

    Returns:
        Function reached the end [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html#CBA_fnc_waitAndExecute
*/

if (!hasInterface) exitWith {false};

params [
    ["_text", "", [""]]
    , ["_delay", KPLIB_notification_delay, [0]]
    , ["_adaptive", true, [true]]
];

if (_text isEqualTo "") exitWith {false};

private _textCount = count _text;

_delay = _delay max 0;

_delay = if (_adaptive) then {_delay + (_textCount / 7)} else {_delay};

hint _text;

[
    {hintSilent "";}
    , []
    , _delay
] call CBA_fnc_waitAndExecute;

true
