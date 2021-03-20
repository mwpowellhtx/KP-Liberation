#include "script_component.hpp"
/*
    KPLIB_fnc_missions_getArrayTelemetry

    File: fn_missions_getArrayTelemetry.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 00:58:26
    Last Update: 2021-03-20 00:58:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Decodes the mission '_status' in terms of its bitwise flags as a human readable report.

    Parameters:
        _status - a bitwise encoded logistics status [SCALAR, default: 0]

    Returns:
        The namespace matching the '_targetUuid' or 'locationNull' if a match could not be found [LOCATION]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
 */

params [
    [Q(_namespace), locationNull, [locationNull]]    
];

private _retval = [];

if (isNull _namespace) exitWith { _retval; };

([_namespace, [
    [QMVAR(_uuid), ""]
    , [QMVAR(_onGetTelemetry), MSFUNC(_onNoTelemetry)]
]] call KPLIB_fnc_namespace_getVars) params [
    Q(_uuid)
    , Q(_onGetTelemetry)
];

[
    _uuid isEqualTo ""
    , [_namespace, MSTATUS(_standby)] call MSFUNC(_checkStatus)
] params [
    Q(_running)
    , Q(_standby)
];

/* Presents a different set of TELEMETRY depending on the circumstances:
 *      - (_running && _standby)
 *      - (_running && !_standby)
 *      - (!_running) - or template, the default case
 * We could probably structure this as a simple "running/not-running" if statement,
 * but we also want to allow for esoteric corner cases as needs arise.
 */
_retval = switch (true) do {
    case (_running): {

        ([_namespace, +[
            [QMVAR(_status), MSTATUS(_standby)]
            , [QMVAR(_timer), KPLIB_timers_default]
            , [QMVAR(_pos), KPLIB_zeroPos]
        ]] call KPLIB_fnc_namespace_getVars) params [
            Q(_status)
            , Q(_timer)
            , Q(_pos)
        ];

        [
            [_status] call MSFUNC(_getStatusReport)
            , mapGridPosition _pos
        ] params [
            Q(_statusReport)
            , Q(_gridRef)
        ];

        [
            [QMVAR(_statusReport), _statusReport]
            , [QMVAR(_timer), _timer]
            , [QMVAR(_gridRef), _gridRef]
        ];
    };
    default {

        ([_namespace, +[
            [QMVAR(_cost), MVAR(_zeroDebit)]
        ]] call KPLIB_fnc_namespace_getVars) params [
            Q(_cost)
        ];

        _cost params [
            [Q(_supplyCost), 0, [0]]
            , [Q(_ammoCost), 0, [0]]
            , [Q(_fuelCost), 0, [0]]
            , [Q(_intelCost), 0, [0]]
        ];

        // De-con the paths
        (KPLIB_resources_imagePaths + [KPLIB_common_intelPath]) params [
            Q(_supplyPath)
            , Q(_ammoPath)
            , Q(_fuelPath)
            , Q(_intelPath)
        ];

        [
            [QMVAR(_supplyCost), _supplyCost, _supplyPath]
            , [QMVAR(_ammoCost), _ammoCost, _ammoPath]
            , [QMVAR(_fuelCost), _fuelCost, _fuelPath]
            , [QMVAR(_intelCost), _intelCost, _intelPath]
        ];
    };
};

// Then append MISSION specific TELEMETRY
_retval append ([_namespace] call _onGetTelemetry);

_retval;
