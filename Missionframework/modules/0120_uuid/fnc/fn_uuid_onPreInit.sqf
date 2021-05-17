/*
    KPLIB_fnc_uuid_onPreInit

    File: fn_uuid_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-26 13:48:56
    Last Update: 2021-05-17 12:28:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:

    Parameter(s):

    Returns:

    Reference:
 */

["[fn_uuid_onPreInit] Initializing...", "PRE] [UUID", true] call KPLIB_fnc_common_log;

// Zero UUID value
KPLIB_uuid_zero = "00000000000000000000000000000000";
//                 01234567890123456789012345678901
//                 0         1         2         3

["[fn_uuid_onPreInit] Initialized", "PRE] [UUID", true] call KPLIB_fnc_common_log;

true;
