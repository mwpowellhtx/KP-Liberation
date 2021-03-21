#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_lnbMissions_toViewData

    File: fn_missionsMgr_lnbMissions_toViewData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Transforms the MISSIONS array to a view that is useful to the MISSIONS LISTNBOX/

    Parameter(s):
        _missions - the MISSIONS TUPLES as sent from the server [ARRAY, default: []]

    Returns:
        A transformed set of MISSIONS TUPLES for use with the MISSIONS LISTNBOX [ARRAY]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/createDialog
 */

params [
    [Q(_missions), [], [[]]]
];

private _toBooleanViewDatum = {
    params [
        [Q(_value), false, [false]]
        , [Q(_trueText), Q(yes), [""]]
        , [Q(_falseText), Q(no), [""]]
    ];
    if (_value) exitWith { _trueText; };
    _falseText;
};

private _toMissionsViewDatum = {
    params [
        [Q(_mission), [], [[]]]
    ];

    _mission params [
        [Q(_uuid), "", [""]]
        , [Q(_templateUuid), "", [""]]
        , [Q(_icon), "", [""]]
        , [Q(_title), "", [""]]
        , [Q(_status), KPLIB_mission_status_standby, [0]]
    ];

    [
        _uuid isEqualTo ""
        , _status == KPLIB_mission_status_standby
    ] params [
        Q(_template)
        , Q(_standby)
    ];

    [
        [_template && _standby] call _toBooleanViewDatum
        , [!(_template || _standby)] call _toBooleanViewDatum
    ] params [
        Q(_isTemplateViewDatum)
        , Q(_isRunningViewDatum)
    ];

    [
        [_icon, toUpper _text, _isTemplateViewDatum, _isRunningViewDatum]
        , [_uuid, _templateUuid]
    ];
};

_missions apply { [_x] call _toMissionViewData; };
