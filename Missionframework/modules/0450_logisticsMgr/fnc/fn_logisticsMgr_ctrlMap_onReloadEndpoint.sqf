/*
    KPLIB_fnc_logisticsMgr_ctrlMap_onReloadEndpoint

    File: fn_logisticsMgr_ctrlMap_onReloadEndpoint.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-10 09:38:15
    Last Update: 2021-03-10 09:38:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Reloads the ENDPOINT in the appropriate STATUS, LOADING or UNLOADING.

    Parameters:
        _ctrlMap - the map control [CONTROL, default: controlNull]
        _endpoint - the endpoint being considered [ARRAY, default: []]
        _markerType - a marker type [STRING, default: KPLIB_logisticsMgr_loadingClassName]

    Returns:
        The marker position [ARRAY]

    References:
        https://community.bistudio.com/wiki/ctrlMapAnimAdd
 */

params [
    ["_ctrlMap", controlNull, [controlNull]]
    , ["_endpoint", [], [[]], 4]
    , ["_markerType", KPLIB_logisticsMgr_loadingClassName, [""]]
];

_endpoint params [
    ["_pos", +KPLIB_zeroPos, [[]], 3]
];

[KPLIB_logisticsMgr_markerName, _pos, _markerType] call KPLIB_fnc_markers_create;

+_pos;
