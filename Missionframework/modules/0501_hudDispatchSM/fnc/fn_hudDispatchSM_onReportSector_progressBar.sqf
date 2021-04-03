#include "script_component.hpp"

// ...
// https://en.wikipedia.org/wiki/Fraction

private _debug = [
    [
        {MPARAM(_onReportSector_debug)}
        , {MPARAM(_onReportSector_progressBar_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_context), locationNull, [locationNull]]
];

// _markerName is to _fobs as SECTOR report is to FOB report
[
    _context getVariable [Q(_markerName), ""]
    , _context getVariable [Q(_compiledReport), []]
    , _context getVariable [Q(_targetRange), 0]
] params [
    Q(_markerName)
    , Q(_compiledReport)
    , Q(_targetRange)
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportSector_progressBar] Entering: [_markerName, _targetRange, count _compiledReport]: %1"
        , str [_markerName, _targetRange, count _compiledReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

if (!(_markerName isEqualTo "")) then {

    private _markerPos = markerPos _markerName;

    [
        // Yes there are default arguments, but this is clearer
        _markerName in KPLIB_sectors_blufor
        , [_markerPos, KPLIB_preset_sideF, _targetRange] call MFUNC(_getSectorUnits)
        , [_markerPos, KPLIB_preset_sideE, _targetRange] call MFUNC(_getSectorUnits)
        // , [_markerPos, KPLIB_preset_sideC, _targetRange] call MFUNC(_getSectorUnits)
        // , [_markerPos, KPLIB_preset_sideR, _targetRange] call MFUNC(_getSectorUnits)
    ] params [
        Q(_blufor)
        , Q(_bluforUnits)
        , Q(_opforUnits)
        // , Q(_civilianUnits)
        // , Q(_resistanceUnits)
    ];

    [
        count _opforUnits
        , count _bluforUnits
        , count _opforUnits + count _bluforUnits
    ] params [
        Q(_opforUnitsCount)
        , Q(_bluforUnitsCount)
        , Q(_totalCount)
    ];

    // TODO: TBD: have a look at the core/common sector cap bits concerning conditions for capture...
    // TODO: TBD: first, these sector bits should be refactored to a proper module for easier use throughout
    // TODO: TBD: secondly, the same sort of conditions should be reflected by the ratios, i.e. incorporate tanks, etc
    private _widthCoefficient = switch (true) do {

        // Then we want the OPFOR segment aligned on the RIGHT
        case (_blufor && _totalCount > 0): {
            -(_opforUnitsCount / _totalCount);
        };

        // Then the OPFOR segment should be aligned on the LEFT
        case (!_blufor && _totalCount > 0): {
            _opforUnitsCount / _totalCount;
        };

        // Elsewise assume FULL or EMPTY progress bar according to sector ALIGNMENT
        default {
            if (_blufor) then { 0; } else { 1; };
        };
    };

    if (_debug) then {
        [format ["[fn_hudDispatchSM_onReportSector_progressBar] Compiling: [_blufor, _opforUnitsCount, _bluforUnitsCount, _totalCount, _widthCoefficient]: %1"
            , str [_blufor, _opforUnitsCount, _bluforUnitsCount, _totalCount, _widthCoefficient]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
    };

    // We just want the calculated PROGRESS BAR POSITION
    _compiledReport append [
        [QMVAR(_sectorReport_lblPbOpfor_widthCoefficient), _widthCoefficient]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportSector_progressBar] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
