#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_onStandby_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

/* Relay the DISPATCH REPORT and related bits to OVERLAY, which should leave
 * the OVERLAY REPORT in a position for immediate usage by the OVERLAY state. */
[] call {
    [
        _player getVariable [KPLIB_hudDispatchSM_dispatchStatus, KPLIB_hud_status_standby]
        , _player getVariable [KPLIB_hudDispatchSM_dispatchReport, []]
        , _player getVariable [QMVAR(_overlayReport), []]
        , _player getVariable [QMVAR(_overlayChanged), false]
    ] params [
        Q(_dispatchStatus)
        , Q(_dispatchReport)
        , Q(_overlayReport)
        , Q(_overlayChanged)
    ];

    // Acknowledge when DISPATCH REPORT CHANGED from the last OVERLAY REPORT
    private _changed = !(_dispatchReport isEqualTo _overlayReport);

    // (Re-)place OVERLAY bits with the DISPATCH ones when CHANGED from previous
    if (_changed) then {
        { _player setVariable _x; } forEach [
            [QMVAR(_overlayStatus), _dispatchStatus]
            , [QMVAR(_overlayReport), +_dispatchReport]
        ];
    };

    // Maintain the overall CHANGED flag, remember previous CHANGED events
    _player setVariable [QMVAR(_overlayChanged), _overlayChanged || _changed];

    // Only report when it actually changed
    if (_debug && (_overlayChanged || _changed)) then {
        [format ["[fn_hudSM_onStandby::call] Fini: [_overlayChanged, _changed, count _dispatchReport, count _overlayReport]: %1"
            , str [_overlayChanged, _changed, count _dispatchReport, count _overlayReport]], "HUDSM", true] call KPLIB_fnc_common_log;
    };
};

// And refresh the OVERLAY TIMER
[_player, MVAR(_overlayTimer), MPARAM(_overlayPeriod)] call KPLIB_fnc_hud_onRefreshPlayerTimer;

true;
