#include "script_component.hpp"
/*
    KPLIB_fnc_eden_getSectorIcon

    File: fn_eden_getSectorIcon.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-14 16:21:05
    Last Update: 2021-05-01 12:34:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the SECTOR ICON path corresponding to the MARKER NAME according to its form,
        fit, or function. These include: TOWER, FACTORY, MILITARY, CITY, METROPOLIS.

    Parameter(s):
        _markerName - the marker name [STRING, default: ""]

    Returns:
        A SECTOR ICON path corresponding to the MARKER NAME [STRING]
 */

private _debug = MPARAM(_getSectorIcon_debug);

params [
    [Q(_markerName), "", [""]]
    , [Q(_sectorIconPathDefault), "", [""]]
];

private _prefixIconMap = [
    [_markerName find MPRESET(_cityPrefix) == 0         , MPRESET(_cityIcon)        ]
    , [_markerName find MPRESET(_metropolisPrefix) == 0 , MPRESET(_metropolisIcon)  ]
    , [_markerName find MPRESET(_factoryPrefix) == 0    , MPRESET(_factoryIcon)     ]
    , [_markerName find MPRESET(_basePrefix) == 0       , MPRESET(_baseIcon)        ]
    , [_markerName find MPRESET(_towerPrefix) == 0      , MPRESET(_towerIcon)       ]
];

private _selectedIcons = _prefixIconMap select { (_x#0); } apply { (_x#1); };

_selectedIcons params [
    [Q(_retval), _sectorIconPathDefault, [""]]
];

_retval;
