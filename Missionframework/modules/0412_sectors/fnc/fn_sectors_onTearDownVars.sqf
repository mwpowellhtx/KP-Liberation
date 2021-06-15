#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onTearDownVars

    File: fn_sectors_onTearDownVars.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-31 23:07:34
    Last Update: 2021-06-14 16:52:21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        TEARS DOWN the CBA SECTOR namespace by removing it from the ALL ACTIVE array
        and taking care of the follow on bookkeeping.

    Parameter(s):
        _sector - a CBA SECTOR namespace being town down [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onTearDownVars_debug)
    || (_sector getVariable [QMVAR(_onTearDownVars_debug), false])
    ;

if (_debug) then {
    [format ["[fn_sectors_onTearDownVars] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "SECTORS"] call KPLIB_fnc_common_log;
};

// The other variables, UNITS, ASSETS, RESOURCES, are dealt with by the OBJECTS TEAR DOWN function
{ _sector setVariable _x; } forEach [
    [Q(KPLIB_captured), nil]
    , [QMVAR(_timer), nil]
];
// The GARRISON array is a summary view of the above

MVAR(_allActive) = MVAR(_allActive) - [_sector];

[] call MFUNC(_getActiveSectors);

if (_debug) then {
    ["[fn_sectors_onTearDownVars] Fini", "SECTORS"] call KPLIB_fnc_common_log;
};

true;
