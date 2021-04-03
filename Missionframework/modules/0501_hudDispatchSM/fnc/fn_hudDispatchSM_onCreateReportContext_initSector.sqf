#include "script_component.hpp"

// ...

// TODO: TBD: issue was likely that the CONFIG was not created, the function was not defined
// TODO: TBD: when we have that, it clears up A LOT
// TODO: TBD: sort out the context and I think we'll be okay...
// TODO: TBD: getting ZERO FOBS up front, which does not seem right...
// TODO: TBD: that and we will probably need to run profiler to see what is being called so much
// https://community.bistudio.com/wiki/BIS_fnc_sortBy

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
    , KPLIB_param_sectorCapRange
    , KPLIB_param_sectorActRange
] params [
    Q(_playerPos)
    , Q(_allSectors)
    , Q(_sectorCapRange)
    , Q(_sectorActRange)
];

private _getDistance = { (markerPos _this) distance2D _playerPos; };

/*
// Along similar lines as with FOB initialization, this is the core question being asked:
_range = KPLIB_param_sectorActRange;
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
