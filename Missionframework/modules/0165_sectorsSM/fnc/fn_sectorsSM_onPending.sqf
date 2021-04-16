#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onPending

    File: fn_sectorsSM_onPending.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-14 00:01:05
    Last Update: 2021-04-14 00:01:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes the CBA SECTOR namespace with current situational report details.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAMSM(_onPending_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (isServer) then {
    [format ["[fn_sectorsSM_onPending] Entering: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: fill in the gaps...

[
    _namespace getVariable [QMVAR(_opforUnitCountCap), 0]
    , _namespace getVariable [QMVAR(_bluforUnitCountAct), 0]
    , [_namespace, MSTATUS(_deactivating), QMVAR(_status)] call KPLIB_fnc_namespace_checkStatus
] params [
    Q(_opforUnitCountCap)
    , Q(_bluforUnitCountAct)
    , Q(_deactivating)
];

[_namespace, MSTATUS(_deactivating), { _bluforUnitCountAct == 0; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;
[_namespace, MSTATUS(_deactivating) + MSTATUS(_deactivated), { _bluforUnitCountAct > 0; }, QMVAR(_status)] call KPLIB_fnc_namespace_unsetStatus;

switch (true) do {

    case (_bluforUnitCountAct > 0): {
        if (isServer) then {
            [format ["[fn_sectorsSM_onPending] Reset deactivating: [_opforUnitCountCap, _bluforUnitCountAct]: %1"
                , str [_opforUnitCountCap, _bluforUnitCountAct]], "SECTORSSM", true] call KPLIB_fnc_common_log;
        };
        _namespace setVariable [QMVAR(_timer), nil];
    };

    case (_bluforUnitCountAct == 0 && !_deactivating): {
        if (isServer) then {
            [format ["[fn_sectorsSM_onPending] Deactivating: [_opforUnitCountCap, _bluforUnitCountAct]: %1"
                , str [_opforUnitCountCap, _bluforUnitCountAct]], "SECTORSSM", true] call KPLIB_fnc_common_log;
        };
        _namespace setVariable [QMVAR(_timer), nil];
        [_namespace, QMVAR(_timer), [MPARAMSM(_pendingPeriod)] call KPLIB_fnc_timers_create] call KPLIB_fnc_namespace_timerHasElapsed;
        //_namespace setVariable [QMVAR(_timer), [MPARAMSM(_pendingPeriod)] call KPLIB_fnc_timers_create];
    };
};

if (isServer) then {
    [format ["[fn_sectorsSM_onPending] Entering: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
