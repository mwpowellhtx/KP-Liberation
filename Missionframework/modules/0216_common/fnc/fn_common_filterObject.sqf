/*
    KPLIB_fnc_common_filterObject

    File: fn_common_filterObject.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-07 16:37:01
    Last Update: 2021-06-14 16:38:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Filters an OBJECT given an ASSOCIATIVE ARRAY of OPTIONS directing how to do so.

    Parameter(s):
        _object - the OBJECT that is being filtered [OBJECT, default: objNull]
        _options - any number of ASSOCIATIVE ARRAY of OPTIONS used to direct what gets filtered [ARRAY, default: []]
            null - isNull _object [BOOL, default: true]
            alive - alive _object [BOOL, default: true]
            objIsObj - vehicle _object isEqualTo _object [BOOL, default: false]
            player - isPlayer _object [BOOL, default: false]
            maxMom - maximum momentum [SCALAR, default: -1]
            maxAlt - maximum altitude [SCALAR, default: -1]
            maxCrew - maximum crew [SCALAR, default: -1]
            kinds - object kinds, _object isKindOf _x [ARRAY, default: []]
            classNames - class names, typeOf _object == _x [ARRAY, default: []]
            sides - an array of SIDES [ARRAY, default: []]
            filters - an array of code receiving the _object, all must return BOOL, true to succeed [ARRAY, default: []]

    Returns:
        Whether the OBJECT may be considered FILTERED [BOOL]
 */

params [
    ["_object", objNull, [objNull]]
    , ["_options", [], [[]]]
];

private _optionsMap = createHashMapFromArray _options;

[
    _optionsMap getOrDefault ["null", true]
    , _optionsMap getOrDefault ["alive", true]
    , _optionsMap getOrDefault ["player", false]
    , _optionsMap getOrDefault ["objIsObj", false]
    , _optionsMap getOrDefault ["maxMom", -1]
    , _optionsMap getOrDefault ["maxAlt", -1]
    , _optionsMap getOrDefault ["maxCrew", -1]
    , _optionsMap getOrDefault ["kinds", []]
    , _optionsMap getOrDefault ["classNames", []]
    , _optionsMap getOrDefault ["sides", []]
    , _optionsMap getOrDefault ["filters", []]
    , [_object] call KPLIB_fnc_common_getMomentum
    , [_object] call KPLIB_fnc_common_getAltitudeDelta
    , [_object, ""] call KPLIB_fnc_core_getVehiclePositions
] params [
    "_null"
    , "_alive"
    , "_player"
    , "_objIsObj"
    , "_maxMom"
    , "_maxAlt"
    , "_maxCrew"
    , "_kinds"
    , "_classNames"
    , "_sides"
    , "_filters"
    , "_momentum"
    , "_altitude"
    , "_crewPos"
];

(!(_null && isNull _object))
    && (!_alive || alive _object)
    && (!_player || isPlayer _object)
    && (!_objIsObj || vehicle _object isEqualTo _object)
    && (_maxMom < 0 || _momentum <= _maxMom)
    && (_maxAlt < 0 || _altitude <= _maxAlt)
    && (_maxCrew < 0 || count _crewPos <= _maxCrew)
    && ((_kinds isEqualTo []) || ({ _object isKindOf _x; } count _kinds > 0))
    && ((_classNames isEqualTo []) || (typeOf _object in _classNames))
    && ((_sides isEqualTo []) || (side _object in _sides))
    && (_filters select { !([_object] call _x); }) isEqualTo []
    ;
