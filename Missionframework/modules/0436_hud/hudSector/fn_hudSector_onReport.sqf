#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_onReport

    File: fn_hudSector_onReport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 01:28:06
    Last Update: 2021-06-14 17:02:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the HUD SUBSCRIPTION REPORT event is raised. Handles
        delegating the current REPORT state to the appropriate RESOURCE layer.

    Parameters:
        _player - the PLAYER for whom the REPORT centers [OBJECT, default: objNull]
        _report - the REPORT for which the event handler centers [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/cutRsc
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
 */

params [
    [Q(_player), player, [objNull]]
    , [Q(_report), locationNull, [locationNull]]
];

private _debug = MPARAM(_onReport_debug)
    || (_player getVariable [QMVAR(_onReport_debug), false])
    || (_report getVariable [QMVAR(_onReport_debug), false])
    ;

if (!([_report, MVAR(_reportUuid)] call KPLIB_fnc_hud_aligned)) exitWith { false; };

if (_debug) then {
    [format ["[fn_hudSector_onReport] Entering: [isNull _player, isNull _report]: %1"
        , str [isNull _player, isNull _report]], "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

[
    dialog
    , uiNamespace getVariable [QMVAR(_ctrlMap), createHashMap]
] params [
    Q(_dialog)
    , Q(_ctrlMap)
];

[
    _ctrlMap getOrDefault ["units", controlNull]
    , _ctrlMap getOrDefault ["units_bg", controlNull]
    , _ctrlMap getOrDefault ["tanks", controlNull]
    , _ctrlMap getOrDefault ["tanks_bg", controlNull]
    , _ctrlMap getOrDefault ["civres", controlNull]
    , _ctrlMap getOrDefault ["civres_bg", controlNull]
] params [
    Q(_lblUnitsMeter)
    , Q(_lblUnitsMeterBg)
    , Q(_lblTanksMeter)
    , Q(_lblTanksMeterBg)
    , Q(_lblCivResMeter)
    , Q(_lblCivResMeterBg)
];

// The rest is pretty much predicated on the FOB MARKERS associated with the REPORT
[
    _player getVariable [Q(KPLIB_display_open), false]
    , _report getVariable [QMVAR(_ack), false]
    , _report getVariable [Q(KPLIB_hud_rscLayerID), ""]
    , { !isNull _x; } count [_lblUnitsMeter, _lblTanksMeter, _lblCivResMeter]
    , { !isNull _x; } count [_lblUnitsMeterBg, _lblTanksMeterBg, _lblCivResMeterBg]
] params [
    Q(_redeploy)
    , Q(_ack)
    , Q(_rscLayerID)
    , Q(_ctrlCount)
    , Q(_bgCtrlCount)
];

if (_debug) then {
    [format ["[fn_hudSector_onReport] Switching overlay: [_dialog, _redeploy, _ack, _ctrlCount, _bgCtrlCount]: %1"
        , str [_dialog, _redeploy, _ack, _ctrlCount, _bgCtrlCount]], "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

/* The main thing we want to avoid here is cutting resources IN|OUT repeatedly.
 * Conversely, we need to be able to cut resoruces IN|OUT as necessary. */
private _rscClassName = switch (true) do {
    case ((_dialog || _redeploy || !_ack) && (_ctrlCount + _bgCtrlCount) == 6): {
        if (_debug) then {
            [format ["[fn_hudSector_onReport] Cutting blank: [_rscLayerID, _className]: %1"
                , str [_rscLayerID, QMVARUI(_blank)]], "HUDSECTOR", true] call KPLIB_fnc_common_log;
        };
        QMVARUI(_blank);
    };

    case (!(_dialog || _redeploy) && _ack && (_ctrlCount + _bgCtrlCount) == 0): {
        if (_debug) then {
            [format ["[fn_hudSector_onReport] Cutting overlay: [_rscLayerID, _className]: %1"
                , str [_rscLayerID, QMVARUI(_overlay)]], "HUDSECTOR", true] call KPLIB_fnc_common_log;
        };
        QMVARUI(_overlay);
    };

    // A no-op in CUTRSC LAYER terms
    case (!(_dialog || _redeploy) && _ack && (_ctrlCount + _bgCtrlCount) == 6): {
        if (_debug) then {
            ["[fn_hudSector_onReport] Refreshing...", "HUDSECTOR", true] call KPLIB_fnc_common_log;
        };
        "";
    };

    default { ""; };
};

if (_rscClassName != "") then {
    _rscLayerID cutRsc [_rscClassName, KPLIB_preset_hud_cutRscEffect
        , KPLIB_preset_hud_cutRscSpeed, KPLIB_preset_hud_cutRscShowInMap
    ];
};

if (_debug) then {
    ["[fn_hudSector_onReport] Fini", "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

true;
