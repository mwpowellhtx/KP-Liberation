/*
    KPLIB_fnc_logisticsSM_getLineUuids

    File: fn_logisticsSM_getLineUuids.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-08 12:11:37
    Last Update: 2021-03-08 12:11:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns an array of the logistic line UUIDs.

    Parameter(s):
        NONE

    Returns:
        A view of the logistic line UUID values [ARRAY]
 */

private _getUuidView = {

    private _bundle = [_x, [
        ["KPLIB_logistics_uuid", ""]
    ]] call KPLIB_fnc_namespace_getVars;

    (_bundle#0);
};

KPLIB_logistics_namespaces apply _getUuidView;
