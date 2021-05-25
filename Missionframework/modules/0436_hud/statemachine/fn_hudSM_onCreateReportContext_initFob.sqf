#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onCreateReportContext_initFob

    File: fn_hudSM_onCreateReportContext_initFob.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-24 20:07:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initializes the dispatch report being created with FOB REPORT elements.

    Parameters:
        _player - player for whom context is being initialized [OBJECT, default: objNull]
        _context - a dispatch report context [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
 */


private _debug = [
    [
        {MPARAM(_createReportContext_debug)}
        , {MPARAM(_onCreateReportContext_initFob_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_context), locationNull, [locationNull]]
];

private _sectors = missionNamespace getVariable ["KPLIB_sectors_fobs", []];

if (_debug) then {
    [format ["[fn_hudSM_onCreateReportContext_initFob] Entering: [isNull _player, isNull _context, count _sectors]: %1"
        , str [isNull _player, isNull _context, count _sectors]], "HUDSM", true] call KPLIB_fnc_common_log;
};

// /*
// // To verify the FOBs themselves...
// _pos = getPos player;
// _all = player getvariable [KPLIB_hud_reportAllResources, false];
// _distance = { (_this#4) distance2D _pos; };
// KPLIB_sectors_fobs select { _all || (_x call _distance) <= KPLIB_param_fobs_range; }
// */

private _reportAllResources = _player getVariable [KPLIB_hud_reportAllResources, false];
private _getMarkerDistance = { markerPos _this distance _player; };

// TODO: TBD: will revisit the HUD aspects... client/server may not be quite as necessary...
// TODO: TBD: as long as we have necessary bits on the client side we can tally...
// TODO: TBD: besides that we also need to separate the HUDs anyway...

// Remember, the HUD view is ONE FOB or ALL FOBS
private _fobMarkers = [
    _sectors
    , []
    , { _x call _getMarkerDistance; }
    , "ascend"
    , { _reportAllResources || (_x call _getMarkerDistance) <= KPLIB_param_fobs_range; }
] call BIS_fnc_sortBy;

if (!(_reportAllResources || _fobMarkers isEqualTo [])) then {
    _fobMarkers = _fobMarkers select [0, 1];
};

{ _context setVariable _x; } forEach [
    [Q(_fobMarkers), +_fobMarkers]
    , [Q(_reportAllResources), _reportAllResources]
];

if (_debug) then {
    [format ["[fn_hudSM_onCreateReportContext_initFob] Fini: [_reportAllResources, count _fobMarkers]: %1"
        , str [_reportAllResources, count _fobMarkers]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
