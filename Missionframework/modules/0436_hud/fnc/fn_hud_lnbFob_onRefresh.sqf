#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_hud_lnbFob_onRefresh

    File: fn_hud_lnbFob_onRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes the FOB LISTNBOX control.

    Parameters:
        _lnbFob - a FOB LISTNBOX control [CONTROL, default: controlNull]
        _config - a corresponding config [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
 */

private _debug = [
    [
        {MPARAM(_lnbFob_onRefresh_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_lnbFob), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

private _viewData = [] call MFUNC(_getFobViewData);
private _viewDataCount = count _viewData;

if (_debug) then {
    [format ["[fn_hud_lnbFob_onRefresh] Entering: [isNull _lnbFob, isNull _config, _viewDataCount]: %1"
        , str [isNull _lnbFob, isNull _config, _viewDataCount]], "HUD", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: we might even consider clearing and re-adding
if (((lnbSize _lnbFob)#0) != _viewDataCount) then {
    lnbClear _lnbFob;
    private _addedRowIndexes = _viewData apply { _lnbFob lnbAddRow ["", ""]; };
    if (_debug) then {
        [format ["[fn_hud_lnbFob_onRefresh] Added rows: [_viewDataCount, _addedRowIndexes]: %1"
            , str [_viewDataCount, _addedRowIndexes]], "HUD", true] call KPLIB_fnc_common_log;
    };
};

{
    _x params [
        [Q(_report), "", [""]]
        , [Q(_imagePath), "", [""]]
        , [Q(_color), [], [[]]]
    ];

    private _rowIndex = _forEachIndex;

    _lnbFob lnbSetText [[_rowIndex, 0], _report];
    _lnbFob lnbSetPicture [[_rowIndex, 1], _imagePath];

    // Then lift either the SHADOW COLOR or use the given COLOR
    _color = _lnbFob getVariable [QMVAR(_colorShadow), _color];

    if (count _color == 4) then {
        _lnbFob lnbSetColor [[_rowIndex, 0], _color];
        _lnbFob lnbSetPictureColor [[_rowIndex, 1], _color];
    };

} forEach _viewData;

// // // TODO: TBD: leaving this bit in while we settle on an approach connecting the dots
// // TODO: TBD: with bits sketched in...
// {
//     _x params [
//         [Q(_report), "", [""]]
//         , [Q(_imagePath), "", [""]]
//         , [Q(_color), [], [[]]]
//     ];
//     private _rowIndex = _lnbFob lnbAddRow [_report, ""];
//     _lnbFob lnbSetTextRight [[_rowIndex, 0], _report];
//     _lnbFob lnbSetPicture [[_rowIndex, 1], _imagePath];
//     // Color with either the SHADOW attribute or with the given COLOR
//     _color = _lnbFob getVariable [QMVAR(_colorShadow), _color];
//     if (count _color == 4) then {
//         _lnbFob lnbSetColor [[_rowIndex, 0], _color];
//         _lnbFob lnbSetColorRight [[_rowIndex, 0], _color];
//         _lnbFob lnbSetPictureColor [[_rowIndex, 1], _color];
//     };
// } forEach MVAR(_fobReport_sampleViewData);

if (_debug) then {
    ["[fn_hud_lnbFob_onRefresh] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
