#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_onMissionsPublished

    File: fn_missionsMgr_onMissionsPublished.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the dialog opens, 'onLoad'.

    Parameter(s):
        _display - the display being opened [DISPLAY, default: displayNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/createDialog
        https://community.bistudio.com/wiki/ctrlEnable
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createPerFrameHandlerObject-sqf.html
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_deletePerFrameHandlerObject-sqf.html
 */

private _debug = [
    [
        {MPARAM(_onMissionsPublished)}
    ]
] call MFUNC(_debug);

params [
    [Q(_missions), [], [[]]]
];

if (_debug) then {
    [format ["[fn_missionsMgr_onMissionsPublished] Entering: [count _missions, _missions]: %1"
        , str [count _missions, _missions]], "MISSIONSMGR", true] call KPLIB_fnc_common_log;
};

private _lnbMissions = uiNamespace getVariable [QMVAR(_lnbMissions), controlNull];

uiNamespace setVariable [QMVAR(_missions), _missions];
_lnbMissions setVariable [QMVAR(_viewData), [_missions] call MFUNC(_lnbMissions_toViewData)];

[_lnbMissions] call MFUNC(_lnbMissions_onRefresh);

if (_debug) then {
    ["[fn_missionsMgr_onMissionsPublished] Fini", "MISSIONSMGR", true] call KPLIB_fnc_common_log;
};

true;
