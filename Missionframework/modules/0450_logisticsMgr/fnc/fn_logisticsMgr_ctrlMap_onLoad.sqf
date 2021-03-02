/*
    KPLIB_fnc_logisticsMgr_ctrlMap_onLoad

    File: fn_logisticsMgr_ctrlMap_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 22:02:06
    Last Update: 2021-03-01 22:02:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _ctrlMap - [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/ctrlMapAnimAdd
 */

params [
    ["_ctrlMap", controlNull, [controlNull]]
];

uiNamespace setVariable ["KPLIB_logisticsMgr_ctrlMap", _ctrlMap];

[nil, player] call KPLIB_fnc_logisticsMgr_ctrlMap_onReload;

true;
