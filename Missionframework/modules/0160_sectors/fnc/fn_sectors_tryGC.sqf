#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_tryGC

    File: fn_sectors_tryGC.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-07 16:45:02
    Last Update: 2021-04-10 13:22:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        GARBAGE COLLECTS the DEACTIVATED SECTOR. Returns whether DEACTIVATION
        fully resolved the GC phase.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        Whether DEACTIVATION fully resolved the GC phase [BOOL]
 */

private _debug = MPARAM(_tryGC_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectors_tryGC] Entering: [_markerName]: %1"
        , str [_markerName]], "SECTORS", true] call KPLIB_fnc_common_log;
};

private _deactivated = [_namespace, MSTATUS(_deactivated), QMVAR(_status)] call KPLIB_fnc_namespace_checkStatus;

// TODO: TBD: and any other GC that we must do, i.e. clean up the units, vehicles, etc...
if (_deactivated) then {
    [_namespace] call KPLIB_fnc_namespace_onGC;
    _namespace = objNull;
};

if (_debug) then {
    [format ["[fn_sectors_tryGC] Fini: [isNull _namespace, _deactivated]: %1"
        , str [isNull _namespace, _deactivated]], "SECTORS", true] call KPLIB_fnc_common_log;
};

isNull _namespace;
