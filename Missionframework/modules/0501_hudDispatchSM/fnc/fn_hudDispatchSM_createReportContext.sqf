#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_createReportContext_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

// For use throughout, caller assumes responsibility for deletion
private _context = [] call CBA_fnc_createNamespace;

[
    // When TRUE, report on ALL the FOBS, otherwise report on the nearest one
    _player getVariable [KPLIB_hud_reportAllResources, false]
    , KPLIB_param_fobRange
] params [
    Q(_reportAllResources)
    , Q(_range)
];

// Setup the FOB report bits of the context
[_player, _context, _reportAllResources, +KPLIB_sectors_fobs, _range] call {
    params [
        [Q(_target), objNull, [objNull]]
        , [Q(_context), locationNull, [locationNull]]
        , [Q(_reportAll), false, [false]]
        , [Q(_fobs), [], [[]]]
        , [Q(_range), 0, [0]]
    ];
    private _fobsForContext = if (_reportAll) then { _fobs; } else {
        private _targetPos = getPos _target;
        _fobs select {
            _x params [
                Q(_0)
                , Q(_1)
                , Q(_2)
                , Q(_3)
                , [Q(_pos), +KPLIB_zeroPos, [[]], 3]
            ];
            (_pos distance2D _targetPos) <= _range;
        };
    };
    _context setVariable [Q(_fobs), _fobsForContext];
    true;
};

// Prepare for any SECTOR report bits
[_player, _context, +KPLIB_sectors_all, KPLIB_param_sectorCapRange] call {
    params [
        [Q(_target), objNull, [objNull]]
        , [Q(_context), locationNull, [locationNull]]
        , [Q(_allSectors), [], [[]]]
        , [Q(_targetRange), 0, [0]]
    ];

    private _targetPos = getPos _target;

    // TODO: TBD: could allow more or less with a CBA setting on the factor, i.e. (_factor*_targetRange)
    private _sectorRanges = _allSectors apply {
        [_x, (markerPos _x) distance2D _targetPos];
    } select {
        // TODO: TBD: may be captured better/differently...
        (_x#1) <= (MPARAM(_sectorReportRangeCoefficient) * _targetRange);
        //         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    };

    private _markerRangeDefault = ["", -1];

    // Select the 'best' SECTOR RANGE by INVERTED RANGE
    private _markerRange = [_sectorRanges, { -(_x#1); }, _markerRangeDefault] call CBA_fnc_selectBest;
    //                       Inverted range: ^^^^^^^
    //                              Default:             ^^^^^^^^

    // Which default should be empty string, i.e. ''
    if (!(_markerRange isEqualTo _markerRangeDefault)) then {
        // TODO: TBD: some of these elements might be interesting to have in hand approaching OVERLAY as well...
        // TODO: TBD: i.e. ranges, etc, very much TBD... do we have the necessary comprehension, i.e. ENGAGED (?)
        { _context setVariable _x; } forEach [
            [Q(_markerName), (_markerRange#0)]
            , [Q(_actualRange), (_markerRange#1)]
            , [Q(_targetRange), _targetRange]
            , [Q(_towerSectors), +KPLIB_sectors_tower]
            , [Q(_bluforSectors), +KPLIB_sectors_blufor]
        ];
    };

    true;
};

true;
