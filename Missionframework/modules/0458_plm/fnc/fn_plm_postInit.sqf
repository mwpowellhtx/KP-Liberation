#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_plm_postInit

    File: fn_plm_postInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-08-31
    Last Update: 2021-05-24 10:11:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (isServer) then {
    ["[fn_plm_postInit] Initializing...", "POST] [PLM", true] call KPLIB_fnc_common_log;
};

// Player section
if (hasInterface) then {

    // Load settings, if available
    private _settings = profileNamespace getVariable ["KPPLM_Settings", []];

    if (!(_settings isEqualTo [])) then {
        KPLIB_plm_viewFoot = _settings#0;
        KPLIB_plm_viewVeh = _settings#1;
        KPLIB_plm_viewAir = _settings#2;
        KPLIB_plm_terrain = _settings#3;
        KPLIB_plm_tpv = _settings#4;
        KPLIB_plm_radio = _settings#5;
        KPLIB_plm_soundVeh = _settings#6;
    };

    // Add event handler
    player addEventHandler ["GetInMan", {[] call KPLIB_fnc_plm_getInOut}];
    player addEventHandler ["GetOutMan", {[] call KPLIB_fnc_plm_getInOut}];

    // TODO: TBD: we may need to refactor in terms of proper 'KPLIB_player_redeploy' event callback to a SETUP PLAYER ACTIONS...
    [
        [
            "STR_KPLIB_ACTION_PLAYER_MANAGEMENT"
            , { [] call KPLIB_fnc_plm_openDialog; }
            , []
            , KPLIB_ACTION_PRIORITY_PLAYER_MANAGEMENT
            , false
            , true
            , ""
            , "
                _target isEqualTo vehicle _target
                    && _target isEqualTo _originalTarget
            "
            , -1
        ]
        , [["_color", "#ff8000"]]
    ] call KPLIB_fnc_common_addPlayerAction;

    // Apply default/loaded values
    [] call KPLIB_fnc_plm_apply;
};

if (isServer) then {
    ["[fn_plm_postInit] Initialized", "POST] [PLM", true] call KPLIB_fnc_common_log;
};

true;
