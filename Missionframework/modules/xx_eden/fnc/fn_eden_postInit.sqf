/*
    KPLIB_fnc_eden_postInit

    File: fn_eden_postInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 11:20:08
    Last Update: 2021-01-28 11:20:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:

    Parameter(s):
        NONE

    Returns:
*/

["Module initializing...", "POST] [EDEN", true] call KPLIB_fnc_common_log;

if (isServer) then {

    KPLIB_sectors_edens = [] call KPLIB_fnc_eden_enumerate;

    {
        private _tuple = [_forEachIndex] + _x;
        [format ["Initialized Edens: [_i]+_eden: %1", str _tuple], "POST] [EDEN", true] call KPLIB_fnc_common_log;
    } forEach KPLIB_sectors_edens;

    // TODO: TBD: we may need to put some timers on any of these things to continually refresh clients with public vars...
    publicVariable "KPLIB_sectors_edens";
};

["Module initialized", "POST] [EDEN", true] call KPLIB_fnc_common_log;

true
