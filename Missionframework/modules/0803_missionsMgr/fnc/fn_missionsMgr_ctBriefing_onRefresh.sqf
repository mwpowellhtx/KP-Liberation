#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_ctBriefing_onLoadDummy

    File: fn_missionsMgr_ctBriefing_onLoadDummy.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-21 16:35:33
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
];

// The view data breaks the norm somewhat in this instance...
private _viewData = _ctBriefing getVariable [QMVAR(_viewData), KPLIB_mission_zeroBriefing];

private _briefingsToRefresh = [0, 1, 2] apply {
    private _briefingIndex = _x;
    [
        _viewData select _briefingIndex
        , MVAR(_ctBriefing_rowNames) select _briefingIndex
    ]
};

{
    _x params [
        [Q(_text), "", [""]]
        , [Q(_rowName), "", [""]]
    ];

    private _ctrlFullName = [_rowName, Q(_lblDescription)] joinString "";
    private _ctrl = uiNamespace getVariable [_ctrlFullName, controlNull];

    _ctrl ctrlSetText _text;

} forEach _briefingsToRefresh;

true;
