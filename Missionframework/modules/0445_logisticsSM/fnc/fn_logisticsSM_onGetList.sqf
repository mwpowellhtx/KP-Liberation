/*
    KPLIB_fnc_logisticsSM_onGetList

    File: fn_logisticsSM_onGetList.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 08:35:05
    Last Update: 2021-03-04 08:35:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Publishes logistics lines to registered managers, as well as returning the
        list for use with the state machine.

    Parameter(s):
        NONE

    Returns:
        The array of CBA logistics namespaces [ARRAY]
 */

[] call KPLIB_fnc_logisticsSM_onRemoveLines;

[] call KPLIB_fnc_logisticsSM_onAddLines;

// This is the "one" time when broadcast may occur, i.e. when lines are refreshed during SM operation...
[] call KPLIB_fnc_logisticsSM_onBroadcastLines;

// This is the "only" thing that this now does, having refactored add/remove logistics lines to a per frame handler
+KPLIB_logistics_namespaces;
