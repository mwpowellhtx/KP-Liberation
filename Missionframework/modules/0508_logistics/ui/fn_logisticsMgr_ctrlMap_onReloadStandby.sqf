/*
    KPLIB_fnc_logisticsMgr_ctrlMap_onReloadStandby

    File: fn_logisticsMgr_ctrlMap_onReloadStandby.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-10 11:25:15
    Last Update: 2021-03-10 11:25:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Deletes the logistics map marker when in STANDBY STATUS.

    Parameters:
        _ctrlMap - the map control [CONTROL, default: controlNull]

    Returns:
        A marker 3D position [ARRAY]
 */

params [
    ["_ctrlMap", controlNull, [controlNull]]
];

// When STATUS STANDBY there is no marker, and allow the caller to center focus
[KPLIB_logisticsMgr_markerName] call KPLIB_fnc_markers_delete;

+KPLIB_zeroPos;
