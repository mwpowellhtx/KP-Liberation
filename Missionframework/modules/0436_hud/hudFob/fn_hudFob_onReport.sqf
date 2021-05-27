#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_onReport

    File: fn_hudFob_onReport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 01:28:06
    Last Update: 2021-05-26 01:28:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Oversees FOB HUD reporting.

    Parameters:
        _player - the PLAYER for whom the REPORT centers [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/cutRsc
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
 */

params [
    [Q(_player), player, [objNull]]
];

private _debug = MPARAM(_onReport_debug)
    || (_player getVariable [QMVAR(_onReport_debug), false])
    ;

private _report = [_player] call MFUNC(_getReport);

if (_debug) then {
    [format ["[fn_hudFob_onReport] Entering: [isNull _player, isNull _report]: %1"
        , str [isNull _player, isNull _report]], "HUDFOB", true] call KPLIB_fnc_common_log;
};

// Raises the REPORT LOCAL EVENT which delegates to specific aspects of the report
[QMVAR(_report), [_player, _report]] call CBA_fnc_localEvent;

// need to know what in order to display:
// fob marker(s): one or all, if there is only 'one' regardless of user flag then show that, otherwise show 'all'
// also whether 'which' overlay resource is currently 'in view'
// responses are:
// when: fobs: yes && rsc: no, then: cut in + refresh
// when: fobs: yes && rsc: yes, then: refresh
// when: fobs: no && rsc: yes, cut out
// when: fobs: no && rsc: no, no-op

[
    dialog
    , uiNamespace getVariable [QMVAR(_lnbFob), controlNull]
    , uiNamespace getVariable [QMVAR(_lnbFobShadow), controlNull]
    , uiNamespace getVariable [QMVAR(_lnbFobConfig), configNull]
    , uiNamespace getVariable [QMVAR(_lnbFobShadowConfig), configNull]
] params [
    Q(_dialog)
    , Q(_lnbFob)
    , Q(_lnbFobShadow)
    , Q(_lnbFobConfig)
    , Q(_lnbFobShadowConfig)
];

// The rest is pretty much predicated on the FOB MARKERS associated with the REPORT
[
    _player isEqualTo vehicle _player
    , _player getVariable [Q(KPLIB_display_open), false]
    , _player getVariable [QMVAR(_reportAllResources), false]
    , _report getVariable [Q(_fobMarkers), []]
    , { !isNull _x; } count [_lnbFob, _lnbFobShadow]
] params [
    Q(_playerIsPlayer)
    , Q(_redeploy)
    , Q(_reportAllResources)
    , Q(_fobMarkers)
    , Q(_ctrlCount)
];

if (_debug) then {
    [format ["[fn_hudFob_onReport] Switching overlay: [_dialog, _redeploy, _ctrlCount, count _fobMarkers]: %1"
        , str [_dialog, _redeploy, _ctrlCount, count _fobMarkers]], "HUDFOB", true] call KPLIB_fnc_common_log;
};

/* The main thing we want to avoid here is cutting resources IN|OUT repeatedly.
 * Conversely, we need to be able to cut resoruces IN|OUT as necessary. */
switch (true) do {
    case ((_dialog || _redeploy || (count _fobMarkers == 0) || !_playerIsPlayer) && _ctrlCount == 2): {
        if (_debug) then {
            [format ["[fn_hudFob_onReport] Cutting blank: [_className]: %1"
                , str [QMVAR(_blank)]], "HUDFOB", true] call KPLIB_fnc_common_log;
        };
        MLAYER(_overlay) cutRsc [QMVAR(_blank), MPRESET(_cutRscEffect), MPRESET(_cutRscSpeed), MPRESET(_cutRscShowInMap)];
    };

    case (!(_dialog || _redeploy) && (count _fobMarkers > 0) && _playerIsPlayer && _ctrlCount == 0): {
        if (_debug) then {
            [format ["[fn_hudFob_onReport] Cutting overlay: [_className]: %1"
                , str [QMVAR(_overlay)]], "HUDFOB", true] call KPLIB_fnc_common_log;
        };
        MLAYER(_overlay) cutRsc [QMVAR(_overlay), MPRESET(_cutRscEffect), MPRESET(_cutRscSpeed), MPRESET(_cutRscShowInMap)];
    };

    case (!(_dialog || _display) && (count _fobMarkers > 0) && _playerIsPlayer && _ctrlCount == 2): {
        if (_debug) then {
            [format ["[fn_hudFob_onReport] Refreshing: [isNull _lnbFob, isNull _lnbFobShadow, isNull _lnbFobConfig, isNull _lnbFobShadowConfig]: %1"
                , str [isNull _lnbFob, isNull _lnbFobShadow, isNull _lnbFobConfig, isNull _lnbFobShadowConfig]], "HUDFOB", true] call KPLIB_fnc_common_log;
        };
        [_lnbFob, _lnbFobConfig] call MFUNCUI(_lnbFob_onRefresh);
        [_lnbFobShadow, _lnbFobShadowConfig] call MFUNCUI(_lnbFob_onRefresh);
    };
};

if (true) then {
    [{ _this call MFUNC(_onReport); }, [], MPARAM(_reportPeriod)] call CBA_fnc_waitAndExecute;
};

if (_debug) then {
    ["[fn_hudFob_onReport] Fini", "HUDFOB", true] call KPLIB_fnc_common_log;
};

true;
