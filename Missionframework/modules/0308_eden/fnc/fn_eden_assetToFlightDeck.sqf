#include "script_component.hpp"
/*
    KPLIB_fnc_eden_assetToFlightDeck

    File: fn_eden_assetToFlightDeck.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-05
    Last Update: 2021-05-20 21:43:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Queries aspects of 'KPLIB_sectors_startbases' and moves the asset from the its
        START BASE spawn point to the designated 'KPLIB_eden_flightDeckProxy', when it
        is clear.

    Parameters:
        _asset - The asset which should be moved [OBJECT, default: objNull]

    Returns:
        Whether the asset moved to designated flight deck [BOOL]

    // TODO: TBD: clear documentation opportunities exist...
    Remarks:
        Be careful here. Dealing with several potentially misdirected metadata opportunities.
        Really and truly deserves clear documentation, perhaps in the module mark down. If not
        a proper wiki presense, eventually.
 */

private _debug = KPLIB_param_debug;

params [
    [Q(_asset), objNull, [objNull]]
];

// TODO: TBD: should notify...
if (isNull _asset) exitWith { false; };

// Drill through the STARTBASE MARKERS themselves to the actual PROXY objects
private _nearestStartProxies = [
    KPLIB_sectors_startbases apply { missionName getVariable _x; }
    , []
    , { _x distance _asset; }
    , { (_x getVariable [QMVAR(_flightDeckProxy), ""]) != ""; }
] call BIS_fnc_sortBy;

_nearestStartProxies params [
    [Q(_startProxy), objNull, [objNull]]
];

if (isNull _startProxy) exitWith {
    [localize "STR_KPLIB_HINT_STARTBASE_NOT_FOUND"] call KPLIB_fnc_notification_hint;
    false;
};

private _flightDeckProxy = missionNamespace getVariable [_startProxy getVariable QMVAR(_flightDeckProxy), objNull];

if (isNull _flightDeckProxy) exitWith {
    [localize "STR_KPLIB_HINT_FLIGHT_DECK_NOT_FOUND"] call KPLIB_fnc_notification_hint;
    false;
};

// TODO: TBD: assumes we are talking about a grass cutter as the proxy...
// TODO: TBD: we should refactor that to an actual variable...
// Get all objects on the flight deck and exclude our spawnmarker cluttercutters, incompatible with ATL, so we use 2D.
private _nearEntities = (_flightDeckProxy nearEntities MPARAM(_flightDeckRadius)) select {};

private _flightDeckBlockage = nearestObjects [_flightDeckProxy, [Q(Air), Q(LandVehicle)], MPARAM(_flightDeckRadius)];

if (!([count _flightDeckBlockage, count crew _asset] isEqualTo [0, 0])) exitWith {
    [localize "STR_KPLIB_HINT_ASSET_MOVE_BLOCKED"] call KPLIB_fnc_notification_hint;
    false;
};

[_asset, getPosATL _flightDeckProxy] spawn {
    params [
        [Q(_asset), objNull, [objNull]]
        , [Q(_proxyPosATL), [], [[]], 3]
    ];

    _asset allowDamage false;
    _asset enableSimulationGlobal false;

    _asset setPosATL (_proxyPosATL vectorAdd [0, 0, 0.1]);

    _asset enableSimulationGlobal true;
    _asset setDamage 0;
    _asset allowDamage true;
};

true;
