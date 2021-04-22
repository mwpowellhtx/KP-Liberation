#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getStatusReport

    File: fn_sectors_getStatusReport.sqf
    Author: Michael W. Powell [22nd MSU SOC]
    Created: 2021-04-22 12:30:29
    Last Update: 2021-04-22 17:15:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Enumerates the STATUS bits by decomposing the flags and translating into
        human readable text.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        An array of decomposed human readable flags [ARRAY]
 */

private _debug = MPARAM(_getStatusReport_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _status = _namespace getVariable [QMVAR(_status), MSTATUS(_standby)];

// Construct them on demand, trade off between the global variable and performance
private _reportTable = [
    [MSTATUS(_garrisoning)      , Q(garrisoning)        ]
    , [MSTATUS(_garrisoned)     , Q(garrisoned)         ]
    , [MSTATUS(_capturing)      , Q(capturing)          ]
    , [MSTATUS(_captured)       , Q(captured)           ]
    , [MSTATUS(_deactivating)   , Q(deactivating)       ]
    , [MSTATUS(_deactivated)    , Q(deactivated)        ]
    , [MSTATUS(_resisting)      , Q(resisting)          ]
    , [MSTATUS(_resisted)       , Q(resisted)           ]
    , [MSTATUS(_reinforcing)    , Q(reinforcing)        ]
    , [MSTATUS(_reinforced)     , Q(reinforced)         ]
    , [MSTATUS(_infantry)       , Q(infantry)           ]
    , [MSTATUS(_paratrooper)    , Q(paratrooper)        ]
    , [MSTATUS(_lightArmor)     , Q(lightArmor)         ]
    , [MSTATUS(_heavyArmor)     , Q(heavyArmor)         ]
    , [MSTATUS(_mission)        , Q(mission)            ]
    , [MSTATUS(_complete)       , Q(complete)           ]
    , [MSTATUS(_patrol)         , Q(patrol)             ]
    , [MSTATUS(_antiAir)        , Q(antiAir)            ]
    , [MSTATUS(_closeAirSupport), Q(closeAirSupport)    ]
    , [MSTATUS(_combatAirPatrol), Q(combatAirPatrol)    ]
    , [MSTATUS(_counterAttack)  , Q(counterAttack)      ]
];

private _candidates = _reportTable select {
    [_status, (_x#0)] call KPLIB_fnc_namespace_checkStatus;
};

private _report = _candidates apply { toUpper (_x#1); };

_report;
