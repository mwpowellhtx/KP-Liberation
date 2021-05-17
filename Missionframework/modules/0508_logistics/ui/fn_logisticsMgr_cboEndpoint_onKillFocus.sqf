/*
    KPLIB_fnc_logisticsMgr_cboEndpoint_onKillFocus

    File: fn_logisticsMgr_cboEndpoint_onKillFocus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 22:17:48
    Last Update: 2021-03-01 22:17:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _cboEndpoint - [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onKillFocus
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_cboEndpoint_onSetFocus_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_cboEndpoint", controlNull, [controlNull]]    
];

uiNamespace setVariable ["KPLIB_logisticsMgr_cboEndpoint", controlNull];
