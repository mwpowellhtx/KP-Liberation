#include "script_component.hpp"
/*
    KPLIB_fnc_sectorSM_onTransit

    File: fn_sectorSM_onTransit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-30 18:05:01
    Last Update: 2021-06-14 16:56:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to CBA SECTORS STATE MACHINE TRANSITIONS from one state to another.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull
        _fromState - STATE from which transition occurs [STRING, default: '']
        _toState - STATE to which transition is occurring [STRING, default: '']

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_fromState), "", [""]]
    , [Q(_toState), "", [""]]
];

private _debug = MPARAMSM(_onTransit_debug)
    || (_sector getVariable [QMVAR(_onTransit_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

private _theTransit = format ["%1:%2", _fromState, _toState];

// if (_theTransit == (format ["%1:%2", QMVARSM(_state_deactivating), QMVARSM(_state_pending)])) then {
//     [_sector, MSTATUS(_deactivating), {true}, QMVAR(_status)] call KPLIB_fnc_namespace_unsetStatus;
// };

if (_theTransit == (format ["%1:%2", QMVARSM(_state_pending), QMVARSM(_state_idle)])) then {
    if (_debug) then {
        // TODO: TBD: logging...
    };
    [QMVAR(_tearDown), [_sector]] call CBA_fnc_serverEvent;
    [QMVAR(_tearDown), [_sector, Q(_units)]] call CBA_fnc_serverEvent;
    [QMVAR(_tearDown), [_sector, Q(_assets)]] call CBA_fnc_serverEvent;
};

// if (_theTransit == (format ["%1:%2", QMVARSM(_state_deactivating), QNVARSN(_state_idle)])) then {
//     // Fully set the STATUS to STANDBY this is critical the sector must be completely reset
//     { _sector setVariable _x; } forEach [
//         [QMVAR(_status), MSTATUS(_standby)]
//         , [QMVAR(_timer), nil]
//         , [QMVAR(_captured), nil]
//     ];
// };

if (_debug) then {
    // TODO: TBD: logging...
};

true;
