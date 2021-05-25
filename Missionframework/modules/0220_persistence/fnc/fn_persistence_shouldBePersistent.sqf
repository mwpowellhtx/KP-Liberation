/*
    KPLIB_fnc_persistence_shouldBePersistent

    File: fn_persistence_shouldBePersistent.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-16 17:01:02
    Last Update: 2021-05-23 14:56:50
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Fitlers whether the OBJECT should be persistent.

    Parameter(s):
        _object - the OBJECT under persistence consideration [OBJECT, default: objNull]
        _range - a RANGE about which to consider objects [SCALAR, default: KPLIB_param_fobs_range]
        _markerNames - an array of MARKER NAMES to consider [ARRAY, default: KPLIB_sectors_fobs]

    Returns:
        Whether the OBJECT may be perisstent [BOOL]

    References:
        https://github.com/mwpowellhtx/KP-Liberation/issues/39
 */

params [
    ["_object", objNull, [objNull]]
    , ["_range", KPLIB_param_fobs_range, [0]]
    , ["_markerNames", +KPLIB_sectors_fobs, [[]]]
];

if (isNull _object) exitWith { false; };

// TODO: TBD: does not exactly validate "all" factory storages...
// TODO: TBD: that level of QC should perhaps occur in the calling function...
[
    _object isKindOf "Man"
    , alive _object
    , vehicle _object isEqualTo _object
    , [_object] call KPLIB_fnc_common_getAltitudeDelta
    , [_object] call KPLIB_fnc_common_getMomentum
    , _object getVariable ["KPLIB_captured", false]
    , _object getVariable ["KPLIB_fobs_fobUuid", ""]
    , _object getVariable ["KPLIB_sectors_markerName", ""]
    , fullCrew [_object, "", true] // All slots including empty ones, if available
    , { (markerPos _x distance2D _object) <= _range; } count _markerNames
] params [
    "_man"
    , "_alive"
    , "_objectIsObject"
    , "_altATL"
    , "_momentum"
    , "_captured"
    , "_fobUuid"
    , "_sectorMarker"
    , "_fullCrewRaw"
    , "_markerProximityCount"
];

[
    count _fullCrewRaw
    , { isNull (_x#0); } count _fullCrewRaw
    , _sectorMarker in _markerNames
    , !(_fobUuid isEqualTo "")
] params [
    "_fullCrewCount"
    , "_actualDisembarkedCount"
    , "_markerValid"
    , "_uuidValid"
];

private _maxAltATL = 1;
private _maxMomentum = 1;

// Matches when criteria are:
!_man
    && _alive
    && _objectIsObject
    && _altATL <= _maxAltATL
    && _momentum <= _maxMomentum
    && (_captured || _markerValid || _uuidValid)
    && (_fullCrewCount == 0 || _actualDisembarkedCount == _fullCrewCount)
    && _markerProximityCount > 0
    ;
