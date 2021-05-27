#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_onReportAssets

    File: fn_hudFob_onReportAssets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 00:56:56
    Last Update: 2021-05-27 14:09:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the HUD SUBSCRIPTION REPORTING events are raised. Reports
        FIXED WING and ROTARY ASSET COUNTS and MAXES to the FOB HUD report.

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

private _debug = MPARAM(_onReportAssets_debug)
    || (_player getVariable [QMVAR(_onReportAssets_debug), false])
    || (_report getVariable [QMVAR(_onReportAssets_debug), false])
    ;

if (!([_report, MVAR(_reportUuid)] call KPLIB_fnc_hud_aligned)) exitWith { false; };

// TODO: TBD: also parse through colors, images...
if (isNull _player || isNull _report || !alive _player) exitWith { false; };

// Only lift the MOBILES+STATICS objects x1 time
private _mobiles = [MPRESET(_mobileClassNames)] call KPLIB_fnc_assets_getMobileAssets;
private _statics = [+KPLIB_sectors_fobs, MPRESET(_staticClassNames)] call KPLIB_fnc_assets_getStaticAssets;

// Then we may parse and dissect the results
private _assets = [
    [_mobiles, MPRESET(_mobileClassNames)]
    , [_statics, MPRESET(_staticClassNames)]
] apply {
    _x params [
        [Q(_objects), [], [[]]]
        , [Q(_classNames), [], [[]]]
    ];
    _classNames apply {
        private _className = _x;
        [_objects, { typeof _this isEqualTo _className; }] call KPLIB_fnc_getAssetTally;
    };
};

_assets params [
    [Q(_mobileTallies), [], [[]]]
    , [Q(_staticTallies), [], [[]]]
];

_mobileTallies params [
    [Q(_fixedWingCount), 0, [0]]
    , [Q(_rotaryCount), 0, [0]]
];

_staticTallies params [
    [Q(_flightCtrlCount), 0, [0]]
    , [Q(_fixedWingMax), 0, [0]]
    , [Q(_rotaryMax), 0, [0]]
];

// Pay close attention to the bouncing ball, there are many tuple levels going on here
{ _report setVariable _x; } forEach [
    [Q(_flightCtrlCount), _flightCtrlCount]
    , [Q(_rotaryCount), _rotaryCount]
    , [Q(_rotaryMax), _rotaryMax]
    , [Q(_fixedWingCount), _fixedWingCount]
    , [Q(_fixedWingMax), _fixedWingMax]
    , [Q(_flightCtrlOptions), [
        [Q(_varNames), [Q(_flightCtrlCount)]]
        , [Q(_imagePath), MPRESET(_flightCtrlPath)]
    ]]
    , [Q(_rotaryOptions), [
        [Q(_varNames), [Q(_rotaryCount), Q(_rotaryMax)]]
        , [Q(_formatString), MPRESET(_formatStringCountOf)]
        , [Q(_imagePath), MPRESET(_rotaryPath)]
    ]]
    , [Q(_fixedWingOptions), [
        [Q(_varNames), [Q(_fixedWingCount), Q(_fixedWingMax)]]
        , [Q(_formatString), MPRESET(_formatStringCountOf)]
        , [Q(_imagePath), MPRESET(_fixedWingPath)]
    ]]
];

true;
