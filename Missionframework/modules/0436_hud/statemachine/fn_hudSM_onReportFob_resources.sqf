#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onReportFob_resources

    File: fn_hudSM_onReportFob_resources.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-20 17:38:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Compiles the specific FOB elements of the DISPATCH REPORT.

    Parameters:
        _player - player for whom FOB report is compiled [OBJECT, default: objNull]
        _context - the DISPATCH REPORT context [LOCATION, locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = [
    [
        {MPARAM(_onReportFob_debug)}
        , {MPARAM(_onReportFob_resources_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_context), locationNull, [locationNull]]
];

[
    _context getVariable [Q(_fobMarkers), []]
    , _context getVariable [Q(_compiledReport), []]
] params [
    Q(_fobMarkers)
    , Q(_compiledReport)
];

if (_debug) then {
    [format ["[fn_hudSM_onReportFob_resources] Entering: [count _fobMarkers]: %1"
        , str [count _fobMarkers]], "HUDSM", true] call KPLIB_fnc_common_log;
};

if (count _fobMarkers > 0) then {
    private _resTotals = _fobMarkers apply { [_x, _range] call KPLIB_fnc_resources_getResTotal; };

    // TODO: TBD: review 'KPLIB_fnc_resources_getResTotal', might make sense to just support 0+ locations...
    // Get RESOURCE SLICE views across the range of RESOURCE TOTALS
    (KPLIB_resources_indexes apply {
        private _resourceIndex = _x;
        _resTotals apply { _x select _resourceIndex; };
    }) params [
        Q(_supplySlice)
        , Q(_ammoSlice)
        , Q(_fuelSlice)
    ];

    // Sum each of the SLICES then RENDER each of them
    [_supplySlice, _ammoSlice, _fuelSlice] apply {
        [_x] call KPLIB_fnc_linq_sum;
    } apply {
        [_x] call MFUNC(_renderScalar);
    } params [
        Q(_renderedSupply)
        , Q(_renderedAmmo)
        , Q(_renderedFuel)
    ];

    KPLIB_resources_imagePaths params [
        Q(_supplyPath)
        , Q(_ammoPath)
        , Q(_fuelPath)
    ];

    _compiledReport append [
        [QMVAR(_fobReport_supply), _renderedSupply]
        , [QMVAR(_fobReport_ammo), _renderedAmmo]
        , [QMVAR(_fobReport_fuel), _renderedFuel]
        , [QMVAR(_fobReport_supplyPath), _supplyPath]
        , [QMVAR(_fobReport_ammoPath), _ammoPath]
        , [QMVAR(_fobReport_fuelPath), _fuelPath]
        , [QMVAR(_fobReport_supplyColor), [0, 0.95, 0, 1]]
        , [QMVAR(_fobReport_ammoColor), [0.95, 0, 0, 1]]
        , [QMVAR(_fobReport_fuelColor), [0.95, 0.95, 0, 1]]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudSM_onReportFob_resources] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
