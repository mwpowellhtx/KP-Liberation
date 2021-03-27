#include "script_component.hpp"

// ...

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
    _context getVariable [Q(_fobs), []]
    , _context getVariable [Q(_compiledReport), []]
] params [
    Q(_fobs)
    , Q(_compiledReport)
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob_resources] Entering: [count _fobs]: %1"
        , str [count _fobs]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

if (count _fobs > 0) then {
    private _resTotals = _fobs apply {
        _x params [
            [Q(_markerName), "", [""]]
        ];
        // Yes it is the default, but we will be specific
        [_markerName, _range] call KPLIB_fnc_resources_getResTotal;
    };

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

    _compiledReport append [
        [QMVAR(_fobReport_supply), [_supplySlice] call KPLIB_fnc_linq_sum]
        , [QMVAR(_fobReport_ammo), [_ammoSlice] call KPLIB_fnc_linq_sum]
        , [QMVAR(_fobReport_fuel), [_fuelSlice] call KPLIB_fnc_linq_sum]
    ];
};

_context setVariable [Q(_compiledReport), _compiledReport];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob_resources] Fini: [count _compiledReport]: %1"
        , str [count _compiledReport]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
