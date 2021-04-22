/*
    KPLIB_fnc_linq_preInit

    File: fn_linq_preInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-26 13:48:56
    Last Update: 2021-04-19 16:23:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    Reference:
 */

["Module initializing...", "PRE] [LINQ", true] call KPLIB_fnc_common_log;

// Created for use along the same lines as objNull, locationNull, etc
emptyHashMap = createHashMap;

["Module initialized", "PRE] [LINQ", true] call KPLIB_fnc_common_log;

true;
