#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_onReportResources

    File: fn_hudFob_onReportResources.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 00:41:35
    Last Update: 2021-05-26 21:44:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Reports RESOURCES to the FOB HUD report.

    Parameters:
        _player - the PLAYER for whom the REPORT centers [OBJECT, default: objNull]
        _report - a REPORT for which to summarize [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_report), locationNull, [locationNull]]
];

private _debug = MPARAM(_onReportResources_debug)
    || (_player getVariable [QMVAR(_onReportResources_debug), false])
    || (_report getVariable [QMVAR(_onReportResources_debug), false])
    ;

// TODO: TBD: also include colors... images...
if (isNull _player || isNull _report || !alive _player) exitWith { false; };

private _reportAllResources = _player getVariable [QMVAR(_reportAllResources), false];

// Next identify the NEAREST FOB marker(s) for which we want to report the resources
private _fobMarkers = [
    _player getVariable [Q(KPLIB_sectors_nearestFob), ""]
    , +(missionNamespace getVariable [Q(KPLIB_sectors_fobs), []])
] call {
    params [
        [Q(_nearestFob), "", [""]]
        , [Q(_allFobMarkers), [], [[]]]
    ];
    if (_reportAllResources && (_nearestFob in _allFobMarkers)) then {
        _allFobMarkers;
    } else {
        [_nearestFob] arrayIntersect _allFobMarkers;
    };
};

private _resTotal = [
        KPLIB_resources_storageValueDefault
        , _fobMarkers apply { [_x] call KPLIB_fnc_resources_getResTotal; }
        , { (_this#0) vectorAdd (_this#1); }
    ] call KPLIB_fnc_linq_aggregate;

_resTotal params [
    [Q(_supplyTotal), 0, [0]]
    , [Q(_ammoTotal), 0, [0]]
    , [Q(_fuelTotal), 0, [0]]
];

// Pay close attention to the bouncing ball, there are many tuple levels going on here
{ _report setVariable _x; } forEach [
    [Q(_fobMarkers), _fobMarkers]
    , [Q(_fobTitle), if (_reportAllResources || _fobMarkers isEqualTo []) then {
        Q(ALL);
    } else {
        toUpper markerText (_fobMarkers#0);
    }]
    , [Q(_supplyTotal), _supplyTotal]
    , [Q(_ammoTotal), _ammoTotal]
    , [Q(_fuelTotal), _fuelTotal]
    , [Q(_fobOptions), [
        [Q(_varNames), [Q(_fobTitle)]]
        , [Q(_render), { _this apply { _x; }; }]
        , [Q(_imagePath), KPLIB_preset_fobs_markerPath]
        , [Q(_color), +KPLIB_preset_fobs_hudColor]
    ]]
    , [Q(_supplyOptions), [
        [Q(_varNames), [Q(_supplyTotal)]]
        , [Q(_imagePath), KPLIB_resources_imagePaths#0]
        , [Q(_color), +(MPRESET(_supplyColor))]
    ]]
    , [Q(_ammoOptions), [
        [Q(_varNames), [Q(_ammoTotal)]]
        , [Q(_imagePath), KPLIB_resources_imagePaths#1]
        , [Q(_color), +(MPRESET(_ammoColor))]
    ]]
    , [Q(_fuelOptions), [
        [Q(_varNames), [Q(_fuelTotal)]]
        , [Q(_imagePath), KPLIB_resources_imagePaths#2]
        , [Q(_color), +(MPRESET(_fuelColor))]
    ]]
];

true;
