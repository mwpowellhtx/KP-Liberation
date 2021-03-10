/*
    KPLIB_fnc_logisticsMgr_ctrlMap_onReloadLoading

    File: fn_logisticsMgr_ctrlMap_onReloadLoading.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-10 09:21:06
    Last Update: 2021-03-10 09:21:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Presents a marker corresponding to the ALPHA ENDPOINT .

    Parameters:
        _ctrlMap - the map control [CONTROL, default: controlNull]
        _alpha - the ELPHA ENDPOINT being considered [ARRAY, default: []]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_ctrlMap", controlNull, [controlNull]]
    , ["_alpha", [], [[]]]
];

[_ctrlMap, _alpha, KPLIB_logisticsMgr_loadingClassName] call KPLIB_fnc_logisticsMgr_ctrlMap_onReloadEndpoint;
