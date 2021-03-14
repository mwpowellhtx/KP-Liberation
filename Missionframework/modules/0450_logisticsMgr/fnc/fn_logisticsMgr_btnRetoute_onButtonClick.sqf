/*
    KPLIB_fnc_logisticsMgr_btnRetoute_onButtonClick

    File: fn_logisticsMgr_btnRetoute_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-13 17:00:14
    Last Update: 2021-03-13 17:00:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Reroute mission button 'onButtonClick' event handler.

    Parameters:
        _btnReroute - the Reroute mission CT_BUTTON [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_serverEvent-sqf.html
 */

params [
    ["_btnReroute", controlNull, [controlNull]]
];

private _line = uiNamespace getVariable ["KPLIB_logisticsMgr_selectedLine", []];

_line params [
    ["_lineUuid", "", [""]]
];

[KPLIB_logisticsCO_requestMissionReroute, [_lineUuid, clientOwner]] call CBA_fnc_serverEvent;

true;
