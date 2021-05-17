/*
    KPLIB_fnc_persistence_postInit

    File: fn_persistence_postInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-02-16 15:45:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module post initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        Event handler finished [BOOL]
 */

private _debug = [] call KPLIB_fnc_persistence_debug;

if (isServer) then {
    ["[fn_persistence_postInit] Initializing...", "POST] [PERSISTENCE", true] call KPLIB_fnc_common_log;
};


/*
    ----- Module Globals -----
*/


/*
    ----- Module Initialization -----
*/

// Server section (dedicated and player hosted)
if (isServer) then {

    if (_debug) then {
        [format ["[fn_persistence_postInit] [count KPLIB_sectors_fobs, count KPLIB_persistence_objects]: %1"
            , str [count KPLIB_sectors_fobs, count KPLIB_persistence_objects]], "POST] [PERSISTENCE"] call KPLIB_fnc_common_log;
    };
};

if (isServer) then {
    // Using just one per frame handler object to refresh all persistent assets
    [] call KPLIB_fnc_persistence_createRefreshAssetPersistence;
};

if (isServer) then {
    ["[fn_persistence_postInit] Initialized", "POST] [PERSISTENCE", true] call KPLIB_fnc_common_log;
};

true;
