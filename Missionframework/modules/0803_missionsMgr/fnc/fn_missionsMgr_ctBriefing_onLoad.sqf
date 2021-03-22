#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_ctBriefing_onLoad

    File: fn_missionsMgr_ctBriefing_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-21 20:24:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the BRIEFING CT_CONTROLS_TABLE opens, 'onLoad'.

    Parameter(s):
        _ctBriefing - the BRIEFING CT_CONTROLS_TABLE control opened [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/createDialog
        https://community.bistudio.com/wiki/CT_CONTROLS_TABLE
 */

params [
    [Q(_ctBriefing), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

{
    uiNamespace setVariable _x;
} forEach [
    [QMVAR(_ctBriefing), _ctrl]
    , [QMVAR(_ctBriefing_config), _config]
];

private _allCtrlNames = +MVAR(_ctBriefing_allCtrlNames);

// Such that we are priming the briefing controls once and only once
private _getCtrls = { _allCtrlNames apply {
        uiNamespace getVariable [_x, controlNull]
    };
};

private _ctrls = [] call _getCtrls;

// So that we may disabuse ourselves of the IDC pooling during refresh moments
if ({ (!isNull _x) } count _ctrls == count _allCtrlNames) exitWith {
    true;
};

{
    private _text = _x;
    private _briefingIndex = _forEachIndex;

    ([MVAR(_ctBriefing_titles), MVAR(_ctBriefing_rowNames)] apply { _x select _briefingIndex; }) params [
        Q(_title)
        , Q(_rowName)
    ];

    // For bookkeeping later on...
    ctAddRow _ctBriefing params [Q(_rowIndex), Q(_row)];
    _row params [Q(_ctrlBG), Q(_lblTitle), Q(_lblDescription)];

    {
        _x params [
            [Q(_ctrlName), "", [""]]
            , [Q(_ctrl), controlNull, [controlNull]]
            , [Q(_text), "", [""]]
        ];
        private _ctrlFullName = [_rowName, _ctrlName] joinString "";
        uiNamespace setVariable [_ctrlFullName, _ctrl];
        _ctrl ctrlSetText _text;
    } forEach [
        [Q(_ctrlBG), _ctrlBG]
        , [Q(_lblTitle), _lblTitle, _title]
        , [Q(_lblDescription), _lblDescription, _text]
    ];
} forEach KPLIB_mission_zeroBriefing;

true;
