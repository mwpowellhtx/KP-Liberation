#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_shouldGarrisonApcs

    File: fn_garrison_shouldGarrisonApcs.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-02 15:02:50
    Last Update: 2021-05-02 15:02:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether the SECTOR shouold GARRISON APCs.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        Whether the SECTOR should GARRISON APCs [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _markerName = _namespace getVariable [Q(KPLIB_sectors_markerName), ""];

private _counted = ({ _markerName find (_x#0) >= 0 && (_x#1); } count [
    [KPLIB_preset_eden_cityPrefix           , MPARAM(_cityGarrisonApcs)         ]
    , [KPLIB_preset_eden_metropolisPrefix   , MPARAM(_metropolisGarrisonApcs)   ]
    , [KPLIB_preset_eden_factoryPrefix      , MPARAM(_factoryGarrisonApcs)      ]
    , [KPLIB_preset_eden_basePrefix         , MPARAM(_baseGarrisonApcs)         ]
    , [KPLIB_preset_eden_towerPrefix        , MPARAM(_towerGarrisonApcs)        ]
]);

_counted > 0;
