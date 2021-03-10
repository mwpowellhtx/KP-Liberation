/*
    KPLIB_fnc_logisticsMgr_ctrlMap_onReloadUnloading

    File: fn_logisticsMgr_ctrlMap_onReloadUnloading.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-10 09:21:06
    Last Update: 2021-03-10 09:21:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _ctrlMap - the map control [CONTROL, default: controlNull]
        _bravo - the BRAVO ENDPOINT being considered [ARRAY, default: []]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_ctrlMap", controlNull, [controlNull]]
    , ["_bravo", [], [[]]]
];

[_ctrlMap, _bravo, KPLIB_logisticsMgr_unloadingClassName] call KPLIB_fnc_logisticsMgr_ctrlMap_onReloadEndpoint;
