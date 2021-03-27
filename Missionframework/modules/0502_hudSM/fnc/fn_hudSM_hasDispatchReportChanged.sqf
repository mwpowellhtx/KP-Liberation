#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_hasDispatchReportChanged_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

if (_debug) then {
    ["[fn_hudSM_hasDispatchReportChanged] Entering...", "HUDSM", true] call KPLIB_fnc_common_log;
};

[
    _player getVariable [KPLIB_hudDispatchSM_dispatchReport, []]
    , _player getVariable [QMVAR(_overlayReport), []]
    , _player getVariable [QMVAR(_overlayChanged), false]
] params [
    Q(_dispatchReport)
    , Q(_overlayReport)
    , Q(_overlayChanged)
];

private _changed = !(_dispatchReport isEqualTo _overlayReport);

if (_changed) then {
    // (Re-)place OVERLAY with the DISPATCH REPORT when CHANGED
    _player setVariable [QMVAR(_overlayReport), +_dispatchReport];
};

// Maintain the overall CHANGED flag, remember previous CHANGED events
_player setVariable [QMVAR(_overlayChanged), _overlayChanged || _changed];

if (_debug) then {
    [format ["[fn_hudSM_hasDispatchReportChanged] Fini: [count _dispatchReport, count _overlayReport, _overlayChanged, _changed]: %1"
        , str [count _dispatchReport, count _overlayReport, _overlayChanged, _changed]], "HUDSM", true] call KPLIB_fnc_common_log;
};

// While at the same time reporting CHANGED
_overlayChanged || _changed;
// Which should leave the OVERLAY REPORT in a position for immediate usage by the OVERLAY state
