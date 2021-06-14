#include "script_component.hpp"
/*
    KPLIB_fnc_sectorSM_getSectorsList

    File: fn_sectorSM_getSectorsList.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 21:09:35
    Last Update: 2021-06-14 16:57:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the next set of CBA SECTOR namespaces approaching a next round of
        CBA statemachine processing. Primarily the function evaluates candidate sectors
        that are ACTIVATING and raises the ACTIVE Flag. Once active, sectors fall off the
        set of active sectors naturally from within the running state machine. The key outcome
        here, besides the critical steps of REFRESHING each sector, NOTIFYING each player,
        and preparing ACTIVATING sectors for activation, is to return with ALL ACTIVE sectors
        following evaluation.

    Parameter(s):
        NONE

    Returns:
        Only the ALL ACTIVE sectors [ARRAY]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
        https://community.bistudio.com/wiki/Category:Command_Group:_Triggers
 */

// TODO: TBD: might we consider actual A3 'triggers' for purposes of activating/deactivating sectors (?)
// TODO: TBD: seems like it might be a natural fit, possibly...
// TODO: TBD: we still may consider proper A3 'triggers', but for now, holding off on that level of complexity...

if (!KPLIB_campaignRunning) exitWith { []; };

private _debug = MPARAMSM(_onGetContextList_debug)
    || ({ _x getVariable [QMVARSM(_onGetContextList_debug), false]; } count MVAR(_namespaces) > 0)
    ;

// Do this once per iteration only
private _opforMarkers = [] call MFUNC(_getOpforSectors);

if (_debug) then {
    [format ["[fn_sectorSM_getSectorsList] Entering: [count %1, count %2]: %3"
        , QMVAR(_blufor), QMVAR(_opfor), str [count MVAR(_blufor), count MVAR(_opfor)]]
        , "SECTORSM", true] call KPLIB_fnc_common_log;
};

// REFRESH each of the SECTORS
{ [QMVAR(_refresh), [_x]] call CBA_fnc_serverEvent; } forEach MVAR(_namespaces);

// Followed by PLAYER NOTIFICATION
{ [QMVAR(_notifySitRep), [_x]] call CBA_fnc_serverEvent; } forEach allPlayers;

// Idenfity SECTORS ON DECK in NEAREST ACT DIST order, filters out already active
private _sectorsToActivate = [
    MVAR(_namespaces)
    , []
    , { _x getVariable [QMVAR(_nearestActDist), -1]; }
    , Q(ascend)
    , { [_x, true] call MFUNC(_canActivate); }
] call BIS_fnc_sortBy;

if (_debug) then {
    private _onDeckMarkerTexts = _sectorsToActivate apply { markerText (_x getVariable QMVAR(_markerName)); };
    [format ["[fn_sectorSM_getSectorsList] On deck: [count _sectorsToActivate, _onDeckMarkerTexts]: %1"
        , str [count _sectorsToActivate, _onDeckMarkerTexts]]
        , "SECTORSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: which should notify to PLAYERS when MAX ACT is reached...
// TODO: TBD: in the form of an active sectors notificaiton... for a HUD of its own...

// Allowing at most MAX ACT count ACTIVATING sectors, so not all on deck may activate
private _actSectors = _sectorsToActivate select [0, (count _sectorsToActivate) min ([] call MFUNC(_getCurrentMaxAct))];

if (_debug) then {
    private _actMarkerTexts = _actSectors apply { markerText (_x getVariable QMVAR(_markerName)); };
    [format ["[fn_sectorSM_getSectorsList] Activating: [count _actSectors, _actMarkerTexts]: %1"
        , str [count _actSectors, _actMarkerTexts]], "SECTORSM", true] call KPLIB_fnc_common_log;
};

// Go ahead and ACTIVATE the qualifying sectors
{ [QMVAR(_activating), [_x]] call CBA_fnc_serverEvent; } forEach _actSectors;

// Returns the ACTIVE SECTOR markers, plus calculating INACTIVE SECTOR markers
private _activeMarkers = [] call MFUNC(_getActiveSectors);

[Q(KPLIB_updateMarkers)] call CBA_fnc_serverEvent;

// Shuffle to help with perceived monotony
private _shuffled = MVAR(_namespaces) call BIS_fnc_arrayShuffle;

if (_debug) then {
    private _activeMarkerTexts = _activeMarkers apply { markerText _x; };
    [format ["[fn_sectorSM_getSectorsList] Fini: [count %1, count _shuffled, _activeMarkerTexts]: %2"
        , QMVAR(_allActive), str [count MVAR(_allActive), count _shuffled, _activeMarkerTexts]]
        , "SECTORSM", true] call KPLIB_fnc_common_log;
};

/* We do need to return with 'all' of the SECTORS after all. Otherwise we are likely to see
 * odd states and transition behaviors when they activate or are subsequently deactivated. */

_shuffled;
