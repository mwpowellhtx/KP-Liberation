/*
    KPLIB_fnc_core_findStartbasesWithFlightDeck

    File: fn_core_findStartbasesWithFlightDeck.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-25 11:52:36
    Last Update: 2021-01-25 11:52:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Selects the startbases within range of the rotary with flight deck designation.

    Parameters:
        _rotary - The rotary asset informing the startbase selection algorithm
        _range - The range around which to select the startbase proxies.

    Returns:
        The selected startbases within range of the rotary asset with flight deck designation [ARRAY]

    Remarks:
        At this level we do not care whether there actually is a flight deck proxy object.
        We just want the startbases selected that are within range and eligibility.
*/

params [
    ["_rotary", objNull, [objNull]]
    , ["_range", KPLIB_param_rotaryMoveRange, [0]]
];

private _onWithFlightDeck = {
    params ["_target", "_startbase"];
    (_startbase select 4) <= _range
    && ((_startbase select 1) getVariable ["_flightDeckProxy", ""] != "")
};

// Identify the start bases that are near the asset and which support flight deck proxies.
[_rotary, _onWithFlightDeck] call KPLIB_fnc_core_findStartbases;
