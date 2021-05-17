#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onReportSector_progressBar

    File: fn_hudSM_onReportSector_progressBar.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:10:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Compiles the specific SECTOR elements of the DISPATCH REPORT.

    Parameters:
        _player - player for whom SECTOR report is compiled [OBJECT, default: objNull]
        _context - the DISPATCH REPORT context [LOCATION, locationNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://en.wikipedia.org/wiki/Fraction
 */

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
    [format ["[fn_hudSM_onReportSector_progressBar] Entering: [_markerName, _targetRange, count _compiledReport]: %1"
        , str [_markerName, _targetRange, count _compiledReport]], "HUDSM", true] call KPLIB_fnc_common_log;
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
        [format ["[fn_hudSM_onReportSector_progressBar] Compiling: [_blufor, _opforUnitsCount, _bluforUnitsCount, _totalCount, _widthCoefficient]: %1"
            , str [_blufor, _opforUnitsCount, _bluforUnitsCount, _totalCount, _widthCoefficient]], "HUDSM", true] call KPLIB_fnc_common_log;
    };

    // We just want the calculated PROGRESS BAR POSITION
    _compiledReport append [
        [QMVAR(_sectorReport_lblPbOpfor_widthCoefficient), _widthCoefficient]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudSM_onReportSector_progressBar] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
