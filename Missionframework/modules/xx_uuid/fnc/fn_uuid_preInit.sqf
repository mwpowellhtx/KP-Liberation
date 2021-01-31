/*
    KPLIB_fnc_uuid_preInit

    File: fn_uuid_preInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-26 13:48:56
    Last Update: 2021-01-26 13:48:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:

    Parameter(s):

    Returns:

    Reference:
*/

["Module initializing...", "PRE] [UUID", true] call KPLIB_fnc_common_log;

// Zero UUID value
KPLIB_uuid_zero = "00000000000000000000000000000000";
//                 01234567890123456789012345678901
//                 0         1         2         3

["Module initialized", "PRE] [UUID", true] call KPLIB_fnc_common_log;

true
