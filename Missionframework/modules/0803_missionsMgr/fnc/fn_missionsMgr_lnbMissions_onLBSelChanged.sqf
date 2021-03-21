#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_lnbMissions_onLBSelChanged

    File: fn_missionsMgr_lnbMissions_onLBSelChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the MISSIONS LISTNBOX opens, 'onLoad'.

    Parameter(s):
        _lnbMissions - the MISSIONS LISTNBOX control opened [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLBSelChanged
 */

params [
    [Q(_lnbMissions), controlNull, [controlNull]]
    , [Q(_selectedIndex), -1, [0]]
];

private _missions = uiNamespace getVariable [QMVAR(_missions), []];

private _mission = if (_selectedIndex < 0) then { []; } else {
    +(_missions select _selectedIndex);
};

uiNamespace setVariable [QMVAR(_selectedMission), _mission];

{
    _x params [
        [Q(_ctrlName), "", [""]]
        , [Q(_toViewData), {}, [{}]]
        , [Q(_onRefresh), {}, [{}]]
    ];
    private _ctrl = uiNamespace getVariable [_ctrlName, controlNull];
    private _viewData = [_mission] call _toViewData;
    _ctrl setVariable [QMVAR(_viewData), _viewData];
    [_ctrl] call _onRefresh;
} forEach [
    [QMVAR(_lnbTelemetry), MFUNC(_lnbTelemetry_toViewData), MFUNC(_lnbTelemetry_onRefresh)]
    , [QMVAR(_imgBriefing), MFUNC(_imgBriefing_toViewData), MFUNC(_imgBriefing_onRefresh)]
    , [QMVAR(_txtBriefing), MFUNC(_txtBriefing_toViewData), MFUNC(_txtBriefing_onRefresh)]
    , [QMVAR(_txtSuccess), MFUNC(_txtSuccess_toViewData), MFUNC(_txtSuccess_onRefresh)]
    , [QMVAR(_txtFailure), MFUNC(_txtFailure_toViewData), MFUNC(_txtFailure_onRefresh)]
];

true;
