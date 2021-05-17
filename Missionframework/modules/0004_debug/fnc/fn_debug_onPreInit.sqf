/*
    KPLIB_fnc_debug_onPreInit

    File: fn_debug_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 13:40:34
    Last Update: 2021-02-04 13:40:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Pre initialization phase callback function.

    Parameter(s):

    Returns:

    Reference:
*/

// TODO: TBD: can probably use the logging function...
["[fn_debug_onPreInit] Initializing...", "PRE] [DEBUG", true] call KPLIB_fnc_common_log;

["[fn_debug_onPreInit] Initialized.", "PRE] [DEBUG", true] call KPLIB_fnc_common_log;

true
