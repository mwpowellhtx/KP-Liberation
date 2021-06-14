#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getBucketBundle

    File: fn_sectors_getBucketBundle.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-07 12:13:25
    Last Update: 2021-06-14 16:50:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a BUNDLE of UNITS, TANKS, ACTIVATION or CAPTURE range, and SIDE oriented counts.
        May return the raw arrays of elements or as a COUNT depending on the arguments.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _count - whether to COUNT the results or just return them as is [BOOL, default: false]

    Returns:
        A bundle of organized elements:
            [
                KPLIB_sectors_actUnitsF
                , KPLIB_sectors_actUnitsE
                , KPLIB_sectors_actUnitsR
                , KPLIB_sectors_actUnitsC
                , KPLIB_sectors_capUnitsF
                , KPLIB_sectors_capUnitsE
                , KPLIB_sectors_capUnitsR
                , KPLIB_sectors_capUnitsC
                , KPLIB_sectors_actTanksF
                , KPLIB_sectors_actTanksE
                , KPLIB_sectors_actTanksR
                , KPLIB_sectors_actTanksC
                , KPLIB_sectors_capTanksF
                , KPLIB_sectors_capTanksE
                , KPLIB_sectors_capTanksR
                , KPLIB_sectors_capTanksC
                , KPLIB_sectors_actVehiclesF
                , KPLIB_sectors_actVehiclesE
                , KPLIB_sectors_actVehiclesR
                , KPLIB_sectors_actVehiclesC
                , KPLIB_sectors_capVehiclesF
                , KPLIB_sectors_capVehiclesE
                , KPLIB_sectors_capVehiclesR
                , KPLIB_sectors_capVehiclesC
            ]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_count), false, [false]]
];

private _debug = MPARAM(_getBucketBundle_debug)
    || (_sector getVariable [QMVAR(_getBucketBundle_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectors_getBucketBundle] Entering: [_markerName, markerText _markerName, _count]: %1"
        , str [_markerName, markerText _markerName, _count]], "SECTORS", true] call KPLIB_fnc_common_log;
};

private _allVarNames = MPRESET(_bucketNamePrefixes) apply {
    private _bucketName = _x;
    KPLIB_preset_allSideSuffixes apply { _bucketName + _x; };
};

if (_debug) then {
    [format ["[fn_sectors_getBucketBundle] Bundling: [KPLIB_preset_allSideSuffixes, %1]: %2"
        , QMPRESET(_bucketNamePrefixes)
        , str [KPLIB_preset_allSideSuffixes, MPRESET(_bucketNamePrefixes)]
        ], "SECTORS", true] call KPLIB_fnc_common_log;
};

private _varNames = flatten _allVarNames;

private _bundle = _varNames apply {
    private _varName = _x;
    private _value = _sector getVariable [_varName, []];

    if (_debug) then {
        [format ["[fn_sectors_getBucketBundle] Bundling: [count _varNames, count %1]: %2"
            , _varName
            , str [count _varNames, count _value]
            ], "SECTORS", true] call KPLIB_fnc_common_log;
    };

    if (_count) then { count _value; } else { _value; };
};

if (_debug) then {
    [format ["[fn_sectors_getBucketBundle] Fini: [count _bundle]: %1"
        , str [count _bundle]], "SECTORS", true] call KPLIB_fnc_common_log;
};

_bundle;
