/*
    KPLIB_fnc_persistence_whereAssetShouldBeFobPersistent

    File: fn_persistence_whereAssetShouldBeFobPersistent.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-17 20:27:22
    Last Update: 2021-05-17 20:27:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        CBA per frame refresh for assets aligible in proximity of FOB zones. Assumes that '_object'
        has already been screened to have either been:
            1. created at an FOB to begin with, i.e. having 'KPLIB_fob_originalUuid' variable, or:
            2. asset was seized, i.e. was enemy or civilian, with 'KPLIB_asset_wasSeized' variable

    Parameter(s):
        _object - the object being considered for FOB asset persistence [OBJECT, default: objNull]
        _range - the range about each FOB to consider objects being qualified [SCALAR, default: KPLIB_param_fobs_range]
        _fobs - the FOBs to consider for object qualification [ARRAY, default: KPLIB_sectors_fobs]

    Returns:
        Whether '_object' qualifies for FOB persistence [BOOL]

    References:
        https://github.com/mwpowellhtx/KP-Liberation/issues/39
 */

params [
    ["_object", objNull, [objNull]]
    , ["_range", KPLIB_param_fobs_range, [0]]
    , ["_fobs", KPLIB_sectors_fobs, [[]]]
];

if (isNull _object) exitWith {
    false;
};

[
    count _fobs > 0
    , alive _object
    , _object isEqualTo (vehicle _object)
    , count (crew _object) == 0
    , abs (speed _object) <= 1
    , ({ _range >= (_object distance2D (_x#4)); } count _fobs) > 0
] params [
    "_givenFobs"
    , "_alive"
    , "_objIsObj"
    , "_disembarked"
    , "_noMomentum"
    , "_fobProximity"
];

// Matches when criteria are:
_givenFobs
    && _alive
    && _objIsObj
    && _disembarked
    && _noMomentum
    && _fobProximity
    ;
