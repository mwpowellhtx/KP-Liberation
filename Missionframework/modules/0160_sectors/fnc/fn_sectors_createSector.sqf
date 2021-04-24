#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_createSector

    File: fn_sectors_createSector.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-07 17:40:29
    Last Update: 2021-04-11 13:14:50
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates a ready to use CBA SECTOR namespace for an ACTIVATING SECTOR. Includes
        the MARKER NAME and STANDBY status variables by default.

    Parameter(s):
        _markerName - marker name for an ACTIVATING SECTOR [STRING, default: ""]

    Returns:
        A CBA SECTOR namespace corresponding to the ACTIVATING SECTOR [LOCATION]
 */

private _debug = MPARAM(_createSector_debug);

params [
    [Q(_markerName), "", [""]]
];

if (_debug) then {
    [format ["[fn_sectors_createSector] Entering: [_markerName]: %1"
        , str [_markerName]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// Set the MARKER NAME variable for the CBA SECTOR namespace to begin with
private _namespace = [false, {
    private _namespace = _this;
    { _namespace setVariable _x; } forEach [
        [QMVAR(_markerName), _markerName]
        , [QMVAR(_markerPos), markerPos _markerName]
        , [QMVAR(_sectorIcon), [_markerName] call MFUNC(_getSectorIcon)]
        , [QMVAR(_status), MSTATUS(_standby)]
    ];
}] call KPLIB_fnc_namespace_create;

if (_debug) then {
    ["[fn_sectors_createSector] Fini", "SECTORS", true] call KPLIB_fnc_common_log;
};

_namespace;
