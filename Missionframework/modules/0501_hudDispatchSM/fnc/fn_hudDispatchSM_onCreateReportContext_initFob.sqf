#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_onCreateReportContext_initFob

    File: fn_hudDispatchSM_onCreateReportContext_initFob.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
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

if (_debug) then {
    [format ["[fn_hudDispatchSM_onCreateReportContext_initFob] Entering: [isNull _player, isNull _context]: %1"
        , str [isNull _player, isNull _context]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

/*
// To verify the FOBs themselves...
_pos = getPos player;
_all = player getvariable [KPLIB_hud_reportAllResources, false];
_distance = { (_this#4) distance2D _pos; };
KPLIB_sectors_fobs select { _all || (_x call _distance) <= KPLIB_param_fobRange; }
*/

[
    getPos _player
    , _player getVariable [KPLIB_hud_reportAllResources, false]
] params [
    Q(_playerPos)
    , Q(_reportAllResources)
];

[
    +KPLIB_sectors_fobs
    , KPLIB_param_fobRange
    // Will use this function to SELECT as well as to SORT
    ,       { (_this#4) distance2D _playerPos; }
    //   _pos: ^^^^^^^
] params [
    Q(_allFobs)
    , Q(_fobRange)
    , Q(_getDistance)
];

// PLAYER does still need to be in range of at least ONE FOB for this to yield REPORT
private _fobRangeCount = ({ (_x call _getDistance) <= _fobRange; } count _allFobs);

// _reportAllResources - when TRUE, report on ALL the FOBS, otherwise report on the nearest one
private _fobs = _allFobs select {
    _fobRangeCount > 0
        && (
            _reportAllResources
                || (_x call _getDistance) <= _fobRange
        );
};

// None is NONE, and if ONE, no need to sort anything, either
if (!_reportAllResources && count _fobs > 1) then {
    private _sorted = [_fobs, [], { _x call _getDistance; }] call BIS_fnc_sortBy;
    _fobs = _sorted select [0, 1];
};

_context setVariable [Q(_fobs), +_fobs];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onCreateReportContext_initFob] Fini: [_reportAllResources, count _fobs]: %1"
        , str [_reportAllResources, count _fobs]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
