/*
    KPLIB_fnc_eden_assetToFlightDeck

    File: fn_eden_assetToFlightDeck.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-05
    Last Update: 2021-01-28 11:50:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Moves the asset from the its Eden spawn point to the designated 'KPLIB_eden_flightDeckProxy' , when it is clear.

    Parameters:
        _asset - The asset which should be moved [OBJECT, default: objNull]

    Returns:
        Whether the asset moved to designated flight deck [BOOL]

    // TODO: TBD: clear documentation opportunities exist...
    Remarks:
        Be careful here. Dealing with several potentially misdirected metadata opportunities. Really
        and truly deserves clear documentation, perhaps in the module mark down. If not a proper wiki
        presense, eventually.
*/

params [
    ["_asset", objNull, [objNull]]
];

// No asset, no script.
if (isNull _asset) exitWith {false};

// Identify the nearest Eden with flight deck designation.
private _eden = [] call {
    private _selected = [_asset] call KPLIB_fnc_eden_selectWithFlightDeck;
    if (KPLIB_param_debug) then {
        [format ["[fn_eden_assetToFlightDeck] %1 eligible proxies", count _selected], "CORE", true] call KPLIB_fnc_common_log;
    };
    [_selected, {_x select 4}] call KPLIB_fnc_common_min;
};

// We should never land here so long as the conditions informing the action menu item are met.
// TODO: TBD: we may notify here after all, but we think the conditions informing the actions should preclude that scenario.
if (isNil "_eden") exitWith {
    [localize "STR_KPLIB_HINT_EDENNOTFOUND"] call KPLIB_fnc_notification_hint;
    false
};

// Get the designated proxy object given the startbase.
private _flightDeckProxy = [(missionNamespace getVariable [_eden select 0, objNull]) getVariable ["KPLIB_eden_flightDeckProxy", ""]] call {
    params ["_variable"];
    if (_variable == "") then {objNull} else {
        missionNamespace getVariable [_variable, objNull];
    };
};

// Take precautions versus typos and such between the mission file and the script assumptions.
if (isNull _flightDeckProxy) then {
    [localize "STR_KPLIB_HINT_FLIGHTDECKNOTFOUND"] call KPLIB_fnc_notification_hint;
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
    // TODO: TBD: instead of hard coding the spec, identify in the presets, etc...
};

// Exit, if the flight deck is blocked or somebody is inside the rotary asset.
if !((crew _asset) isEqualTo [] && _nearEntities isEqualTo []) exitWith {
    [localize "STR_KPLIB_HINT_ASSETMOVEBLOCKED"] call KPLIB_fnc_notification_hint;
    false
};

// Disable damage handling and simulation.
_asset allowDamage false;
_asset enableSimulationGlobal false;

// Move the rotary asset to the flight deck.
_asset setPosATL [_flightDeckPos select 0, _flightDeckPos select 1, (_flightDeckPos select 2) + 0.1];

// Activate the simulation again.
_asset enableSimulationGlobal true;
_asset setDamage 0;
_asset allowDamage true;

true
