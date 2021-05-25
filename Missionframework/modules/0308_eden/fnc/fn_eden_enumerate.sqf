#include "script_component.hpp"
/*
    KPLIB_fnc_eden_enumerate

    File: fn_eden_enumerate.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 12:28:54
    Last Update: 2021-05-20 19:50:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Enumerates all of the EDEN START BASE proxy objects, then identifies each of
        their object VEHICLEVARNAME strings. This will also serve as the map markers
        for the same. We do not care what else is appended to any of the names, as long
        as the prefix is 'KPLIB_eden_startbase', for instance. It can simply be named
        'KPLIB_eden_startbase', 'KPLIB_eden_startbase_0', or 'KPLIB_eden_startbase_foo',
        for all we care, it does not matter.

        Enumeration shall occur once and only once.

    Parameters:
        _basename - The base name that shall be used as PREFIX [STRING, default: 'startbase']

    Returns:
        The enumerated START BASE MARKER NAMES [ARRAY]
 */

private _debug = false;

if (_debug) then {
    ["[fn_eden_enumerate] Entering...", "EDEN", true] call KPLIB_fnc_common_log;
};

params [
    [Q(_basename), Q(startbase), [""]]
];

private _prefix = toLower format ["KPLIB_eden_%1", _basename];

if (isNil { MVAR(_startbases); }) then {

    MVAR(_startbases) = vehicles select {
        private _varName = toLower vehicleVarName _x;
        private _varNamePrefix = _varName select [0, (count _varName) min (count _prefix)];
        typeOf _x isEqualTo KPLIB_preset_proxyClassName
            && _varNamePrefix isEqualTo _prefix;
    };

    KPLIB_sectors_startbases = MVAR(_startbases) apply { vehicleVarName _x; };
    publicVariable Q(KPLIB_sectors_startbases);
};

if (_debug) then {
    ["[fn_eden_enumerate] Fini", "EDEN", true] call KPLIB_fnc_common_log;
};

MVAR(_startbases);
