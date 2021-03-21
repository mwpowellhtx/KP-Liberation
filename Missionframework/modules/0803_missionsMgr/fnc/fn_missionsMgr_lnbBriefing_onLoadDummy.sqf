#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_lnbBriefing_onLoadDummy

    File: fn_missionsMgr_lnbBriefing_onLoadDummy.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the BRIEFING LISTNBOX opens, 'onLoad'.

    Parameter(s):
        _lnbBriefing - the BRIEFING LISTNBOX control opened [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/createDialog
 */

params [
    [Q(_lnbBriefing), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

{
    uiNamespace setVariable _x;
} forEach [
    [QMVAR(_lnbBriefing), _ctrl]
    , [QMVAR(_lnbBriefing_config), _config]
];

private _getSpam = {
    params [
        [Q(_text), "", [""]]
        , [Q(_count), 99, [0]]
    ];
    private _bits = [];
    _bits resize _count;
    _bits apply { _text; } joinString " ";
};

[
    [Q(_overview)] call _getSpam
    , [Q(_success)] call _getSpam
    , [Q(_failure)] call _getSpam
] params [
    Q(_overview)
    , Q(_success)
    , Q(_failure)
];

// For purposes of dummy data...
private _mission = +[
    ""
    , ""
    , ""
    , ""
    , ""
    , KPLIB_mission_status_standby
    , KPLIB_zeroPos
    , KPLIB_timers_default
    , [_overview, _success, _failure]
];

private _viewData = [_mission] call MFUNC(_lnbBriefing_toViewData);

_lnbBriefing setVariable [QMVAR(_viewData), _viewData];

[_lnbBriefing] call MFUNC(_lnbBriefing_onRefresh);

true;
