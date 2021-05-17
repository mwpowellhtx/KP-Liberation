#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_plm_postInit

    File: fn_plm_postInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2017-08-31
    Last Update: 2019-04-23
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

if (isServer) then {["Module initializing...", "POST] [PLM", true] call KPLIB_fnc_common_log;};

// Player section
if (hasInterface) then {
    // Load settings, if available
    private _settings = profileNamespace getVariable ["KPPLM_Settings", []];
    if !(_settings isEqualTo []) then {
        KPLIB_plm_viewFoot = _settings select 0;
        KPLIB_plm_viewVeh = _settings select 1;
        KPLIB_plm_viewAir = _settings select 2;
        KPLIB_plm_terrain = _settings select 3;
        KPLIB_plm_tpv = _settings select 4;
        KPLIB_plm_radio = _settings select 5;
        KPLIB_plm_soundVeh = _settings select 6;
    };

    // Add event handler
    player addEventHandler ["GetInMan", {[] call KPLIB_fnc_plm_getInOut}];
    player addEventHandler ["GetOutMan", {[] call KPLIB_fnc_plm_getInOut}];

    // Action to open the dialog
    private _actionArray = [
        "<t color='#FF8000'>" + localize "STR_KPLIB_ACTION_PLAYER_MANAGEMENT" + "</t>"
        , {[] call KPLIB_fnc_plm_openDialog;}
        , nil
        , KPLIB_ACTION_PRIORITY_PLAYER_MANAGEMENT
        , false
        , true
        , ""
        , '
            _target isEqualTo _originalTarget
        '
        , -1
    ];

    [_actionArray] call CBA_fnc_addPlayerAction;

    // Apply default/loaded values
    [] call KPLIB_fnc_plm_apply;
};

if (isServer) then {["Module initialized", "POST] [PLM", true] call KPLIB_fnc_common_log;};

true
