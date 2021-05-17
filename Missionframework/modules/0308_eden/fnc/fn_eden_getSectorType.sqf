#include "script_component.hpp"
/*
    KPLIB_fnc_eden_getSectorType

    File: fn_eden_getSectorType.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-14 16:21:05
    Last Update: 2021-05-01 12:34:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the SECTOR TYPE corresponding to the MARKER NAME.

    Parameter(s):
        _markerName - the marker name [STRING, default: ""]

    Returns:
        SECTOR TYPE corresponding to the MARKER NAME [STRING]

    References:
        https://community.bistudio.com/wiki/find
 */

private _debug = MPARAM(_getSectorType_debug);

params [
    [Q(_markerName), "", [""]]
];

private _sectorTypePairs = [
    [MPRESET(_cityPrefix)           , MPRESET(_cityType)        ]
    , [MPRESET(_metropolisPrefix)   , MPRESET(_metropolisType)  ]
    , [MPRESET(_factoryPrefix)      , MPRESET(_factoryType)     ]
    , [MPRESET(_towerPrefix)        , MPRESET(_towerType)       ]
    , [MPRESET(_basePrefix)         , MPRESET(_baseType)        ]
];

// Narrow to the PREFIX aligned view if possible
private _selectedPairs = _sectorTypePairs select { _markerName find (_x#0) >= 0; };
//                                  By its PREFIX: ^^^^^^^^^^^^^^^^^^^^^^^

// Defaults matter otherwise what we get are intermediate NILs
_selectedPairs params [
    [Q(_pair), [], [[]]]
];

_pair params [
    [Q(_0), "", [""]]
    , [Q(_sectorType), "", [""]]
];

_sectorType;
