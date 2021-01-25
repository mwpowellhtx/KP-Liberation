/*
    KPLIB_fnc_core_rotaryToFlightDeck

    File: fn_core_rotaryToFlightDeck.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-05
    Last Update: 2021-01-25 10:21:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Moves the rotary asset from the its Liberty hangar to the designated flight deck, when it is clear.

    Parameters:
        _rotary - The rotary asset which should be moved. [OBJECT, default: objNull]

    Returns:
        Whether the rotary asset moved to designated flight deck [BOOL]

    // TODO: TBD: clear documentation opportunities exist...
    Remarks:
        Be careful here. Dealing with several potentially misdirected metadata opportunities. Really
        and truly deserves clear documentation, perhaps in the module mark down. If not a proper wiki
        presense, eventually.
*/

params [
    ["_rotary", objNull, [objNull]]
];

// No asset, no script.
if (isNull _rotary) exitWith {false};

// Identify the nearest startbase with flight deck designation.
private _startbase = [] call {
    private _startbases = [_rotary] call KPLIB_fnc_core_findStartbasesWithFlightDeck;
    [format ["[fn_core_rotaryToFlightDeck] %1 startbases are eligible", count _startbases], "CORE", true] call KPLIB_fnc_common_log;
    [_startbases, {_x select 4}] call KPLIB_fnc_common_min;
};

// We should never land here so long as the conditions informing the action menu item are met.
// TODO: TBD: we may notify here after all, but we think the conditions informing the actions should preclude that scenario.
if (isNil "_startbase") exitWith {
    hint localize "STR_KPLIB_HINT_STARTBASENOTFOUND";
    [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
    false
};

// Get the designated proxy object given the startbase.
private _flightDeckProxy = [_startbase select 1 getVariable ["_flightDeckProxy", ""]] call {
    params ["_variable"];
    if (_variable == "") then {objNull} else {
        missionNamespace getVariable [_variable, objNull];
    };
};

// Take precautions versus typos and such between the mission file and the script assumptions.
if (isNull _flightDeckProxy) then {
    hint localize "STR_KPLIB_HINT_FLIGHTDECKNOTFOUND";
    [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
    false
};

// ATL pos of the flight deck proxy.
private _flightDeckPos = getPosATL _flightDeckProxy;

// TODO: TBD: Could potentially refactor this as a setting, if necessary...
private _flightDeckRadius = 15;

// TODO: TBD: assumes we are talking about a grass cutter as the proxy...
// TODO: TBD: we should refactor that to an actual variable...
// Get all objects on the flight deck and exclude our spawnmarker cluttercutters, incompatible with ATL, so we use 2D.
private _nearEntities = ([_flightDeckPos select 0, _flightDeckPos select 1] nearEntities _flightDeckRadius) select {
    !((typeOf _x) isEqualTo "Land_ClutterCutter_small_F")
};

// Exit, if the flight deck is blocked or somebody is inside the rotary asset.
if !((crew _rotary) isEqualTo [] && _nearEntities isEqualTo []) exitWith {
    hint localize "STR_KPLIB_HINT_ROTARYMOVEBLOCKED";
    [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
    false
};

// Disable damage handling and simulation.
_rotary allowDamage false;
_rotary enableSimulationGlobal false;

// Move the rotary asset to the flight deck.
_rotary setPosATL [_flightDeckPos select 0, _flightDeckPos select 1, (_flightDeckPos select 2) + 0.1];

// Activate the simulation again.
_rotary enableSimulationGlobal true;
_rotary setDamage 0;
_rotary allowDamage true;

true
