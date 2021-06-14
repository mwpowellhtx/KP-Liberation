#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_onReportSitRep

    File: fn_hudSector_onReportSitRep.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-12 02:34:41
    Last Update: 2021-06-14 17:02:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameters:
        _player - the PLAYER for whom the REPORT centers [OBJECT, default: objNull]
        _report - the REPORT for which the event handler centers [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_player), player, [objNull]]
    , [Q(_report), locationNull, [locationNull]]
];

private _debug = MPARAM(_onReportSitRep_debug)
    || (_player getVariable [QMVAR(_onReportSitRep_debug), false])
    || (_report getVariable [QMVAR(_onReportSitRep_debug), false])
    ;

if (_debug) then {
    [format ["[fn_hudSector_onReportSitRep] Entering: [isNull _player, isNull _report, %1]: %2"
        , QMPRESETUI(_meters)
        , str [isNull _player, isNull _report, MPRESETUI(_meters)]
        ], "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

if (isNil { MPRESETUI(_meters); }) exitWith { false; };
if (!([_report, MVAR(_reportUuid)] call KPLIB_fnc_hud_aligned)) exitWith { false; };

// TODO: TBD: we could now separate the concerns as well...
[
    _report getVariable [Q(KPLIB_sectors_markerName), ""]
    , _report getVariable [Q(KPLIB_sectors_blufor), false]
] params [
    Q(_markerName)
    , Q(_blufor)
];

// // TODO: TBD: the marker bits would probably go better at the server side SITREP compilation level...
// TODO: TBD: for now, simply the 'markerText'
// TODO: TBD: should consider reformatting some of them, i.e. factories, without capability
// TODO: TBD: that or somehow add cap labels apart from the marker itself
// TODO: TBD: also radio towers are a bit awkward, especially considering we would like to include gridref for 'all' sectors...
// TODO: TBD: if this is not already a function it should be on its own...
private _markerNameText = markerText _markerName;
private _markerPos = markerPos _markerName;
private _gridref = mapGridPosition _markerPos;

private _markerText = switch (true) do {
    case (_markerName in KPLIB_sectors_tower):      { _markerNameText;                              };
    case (_markerName in KPLIB_sectors_factory):    { [_gridref, _markerNameText] joinString " - "; };
    default                                         { [_gridref, _markerNameText] joinString " - "; };
};

if (_debug) then {
    [format ["[fn_hudSector_onReportSitRep] Marker: [_markerName, _markerText]: %1"
        , str [_markerName, _markerText]], "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

// Assumes that if proximity is determined then there are controls present to receive the request
[_markerText, _blufor] call MFUNC(_setMarkerText);

[
    _report getVariable [Q(KPLIB_sectors_capUnitDividend), 0]
    , _report getVariable [Q(KPLIB_sectors_capUnitDivisor), 0]
    , _report getVariable [Q(KPLIB_sectors_capTankDividend), 0]
    , _report getVariable [Q(KPLIB_sectors_capTankDivisor), 0]
    , _report getVariable [Q(KPLIB_sectors_capCivResDividend), 0]
    , _report getVariable [Q(KPLIB_sectors_capCivResDivisor), 0]
] params [
    Q(_capUnitDividend)
    , Q(_capUnitDivisor)
    , Q(_capTankDividend)
    , Q(_capTankDivisor)
    , Q(_capCivResDividend)
    , Q(_capCivResDivisor)
];

private _meterMap = MPRESETUI(_meters) createHashMapFromArray [
    [_capUnitDividend, _capUnitDivisor, [0, 0, 0.9, 1], [0.9, 0, 0, 1]]
    , [_capTankDividend, _capTankDivisor, [0, 0, 0.9, 1], [0.9, 0, 0, 1]]
    , [_capCivResDividend, _capCivResDivisor, [0, 0.9, 0, 1], [0.72, 0, 0.9, 1]]
];

{
    private _meter = _x;

    _y params [Q(_dividend), Q(_divisor), Q(_alphaColor), Q(_bravoColor)];

    if (_debug) then {
        [format ["[fn_hudSector_onReportSitRep] Position: [_meter, _dividend, _divisor, _alphaColor, _bravoColor]: %1"
            , str [_meter, _dividend, _divisor, _alphaColor, _bravoColor]], "HUDSECTOR", true] call KPLIB_fnc_common_log;
    };

    [_meter, _dividend, _divisor, _alphaColor, _bravoColor] call MFUNC(_setMeterPosition);

} forEach _meterMap;

if (_debug) then {
    ["[fn_hudSector_onReportSitRep] Fini", "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

true;
