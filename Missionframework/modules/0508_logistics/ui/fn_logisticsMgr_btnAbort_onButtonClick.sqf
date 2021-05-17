/*
    KPLIB_fnc_logisticsMgr_btnAbort_onButtonClick

    File: fn_logisticsMgr_btnAbort_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 14:20:15
    Last Update: 2021-03-04 14:20:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Abort mission button 'onButtonClick' event handler.

    Parameters:
        _btnAbort - the Abort mission CT_BUTTON [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_serverEvent-sqf.html
 */

params [
    ["_btnAbort", controlNull, [controlNull]]
];

private _line = uiNamespace getVariable ["KPLIB_logisticsMgr_selectedLine", []];

_line params [
    ["_lineUuid", "", [""]]
];

[KPLIB_logisticsCO_requestMissionAbort, [_lineUuid, clientOwner]] call CBA_fnc_serverEvent;

true;
