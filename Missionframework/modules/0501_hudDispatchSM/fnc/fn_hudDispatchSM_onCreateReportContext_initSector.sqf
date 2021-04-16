#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_onCreateReportContext_initSector

    File: fn_hudDispatchSM_onCreateReportContext_initSector.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-16 09:05:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initializes the dispatch report being created with SECTOR REPORT elements.

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
        , {MPARAM(_onCreateReportContext_initSector_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_context), locationNull, [locationNull]]
];

if (_debug) then {
    ["[fn_hudDispatchSM_onCreateReportContext_initSector] Entering...", "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

[
    getPos _player
    , +KPLIB_sectors_all
    , KPLIB_param_sectors_capRange
    , KPLIB_param_sectors_actRange
] params [
    Q(_playerPos)
    , Q(_allSectors)
    , Q(_sectorCapRange)
    , Q(_sectorActRange)
];

private _getDistance = { (markerPos _this) distance2D _playerPos; };

/*
// Along similar lines as with FOB initialization, this is the core question being asked:
_range = KPLIB_param_sectors_actRange;
_pos = getPos player;
_getDistance = { (markerPos _this) distance2D _pos; };
KPLIB_sectors_all apply { [_x, _x call _getDistance]; } select { (_x#1) <= _range; };
*/

private _sectorRanges = _allSectors apply { [_x, _x call _getDistance]; } select { (_x#1) <= _sectorActRange; };

// Select the 'best' SECTOR RANGE by INVERTED RANGE or defer to default
private _markerRange = [_sectorRanges, { -(_x#1); }, ["", -1]] call CBA_fnc_selectBest;
//                       Inverted range: ^^^^^^^
//                              Default:             ^^^^^^^^

if (_debug) then {
    [format ["[fn_hudDispatchSM_onCreateReportContext_initSector] Fini: [_markerRange, _sectorCapRange, _sectorActRange]: %1"
        , str [_markerRange, _sectorCapRange, _sectorActRange]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// Valid range cannot be negative
if ((_markerRange#1) >= 0) then {
    // TODO: TBD: some of these elements might be interesting to have in hand approaching OVERLAY as well...
    // TODO: TBD: i.e. ranges, etc, very much TBD... do we have the necessary comprehension, i.e. ENGAGED (?)
    { _context setVariable _x; } forEach [
        [Q(_markerName), (_markerRange#0)]
        , [Q(_actualRange), (_markerRange#1)]
        , [Q(_sectorCapRange), _sectorCapRange]
        , [Q(_sectorActRange), _sectorActRange]
        , [Q(_towerSectors), +KPLIB_sectors_tower]
        , [Q(_bluforSectors), +KPLIB_sectors_blufor]
    ];
};

true;
