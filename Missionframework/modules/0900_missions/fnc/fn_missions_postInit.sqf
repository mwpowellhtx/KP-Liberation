/*
    KPLIB_fnc_missions_postInit

    File: fn_missions_postInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-06-22
    Last Update: 2019-06-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The postInit function of a module takes care of starting/executing the modules functions or scripts.
        Basically it starts/initializes the module functionality to make all provided features usable.

    Parameter(s):
        NONE

    Returns:
        Module postInit finished [BOOL]
*/

// TODO: TBD: "this" module likely going away, instead will redefine in terms of "actual" missions...
if (isServer) then {

    ["Module initializing...", "POST] [MISSIONS", true] call KPLIB_fnc_common_log;

    // // TODO: TBD: this is what? an 'example' mission?
    // [
    //     "Example",
    //     {true},
    //     false,
    //     [10, 0, 0, 0],
    //     10,
    //     10,
    //     "modules\0900_missions\example\start.sqf",
    //     "modules\0900_missions\example\abort.sqf"
    // ] call KPLIB_fnc_mission_registerMission;

};



if (isServer) then {["Module initialized", "POST] [MISSIONS", true] call KPLIB_fnc_common_log;};

true
