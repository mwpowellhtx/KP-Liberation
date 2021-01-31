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

    Returns:
*/

["Module initializing...", "POST] [EDEN", true] call KPLIB_fnc_common_log;

if (isServer) then {

    // TODO: TBD: we may also pursue more of a "losing" end game scenario in which it is possible for Edens to be lost
    // TODO: TBD: or specify just what those end game conditions must be in lieu of that
    // TODO: TBD: which also implies that, at some level, we are serializing Edens as well and reconciling with those we discovered in the mission
    // TODO: TBD: HOWEVER, HOWEVER, ... NOT, NOT, NOT during this sprint (v0.98 S1) / 2021-01-28 13:18:00
    private _edens = [];

    // TODO: TBD: we think that we possibly also need to serialize some aspect of these...
    // TODO: TBD: then also merge in key bits with the thing, i.e. for "side", things of this nature...
    _edens = [] call KPLIB_fnc_eden_enumerate;

    KPLIB_sectors_edens = _edens;

    publicVariable "KPLIB_sectors_edens";

    [format ["Initialized Edens: %1", str KPLIB_sectors_edens], "POST] [EDEN", true] call KPLIB_fnc_common_log;
};

["Module initialized", "POST] [EDEN", true] call KPLIB_fnc_common_log;

true
