/*
    KPLIB_fnc_virtual_preInit

    File: fn_virtual_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-11-18
    Last Update: 2019-05-19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The preInit function defines global variables, adds event handlers and set some vital settings which are used in this module.

    Parameter(s):
        NONE

    Returns:
        Module preInit finished [BOOL]
*/

if (isServer) then {["Module initializing...", "PRE] [VIRTUAL", true] call KPLIB_fnc_common_log;};

[] call KPLIB_fnc_virtual_settings;

/*
    ----- Module Globals -----
*/

KPLIB_virtual_fobIcons = [];

if (isServer) then {
    // Give zeus to unit when requested via event or remove it with none mode
    ["KPLIB_player_giveZeus", {
        params ["_unit", "_mode"];

        // TODO: TBD: under review, should establish zeus mode enum vars...
        switch _mode do {
            // NONE mode
            case 0: {
               _unit call KPLIB_fnc_virtual_removeCurator;
            };
            // Other modes
            default {
                _this call KPLIB_fnc_virtual_addCurator;
            };
        };
    }] call CBA_fnc_addEventHandler;

    // Handle built items
    ["KPLIB_build_item_built", {
        params [
            ["_object", objNull, [objNull]]
            , ["_markerName", "", [""]]
        ];
        // Add built item to all curators
        {
            _x addCuratorEditableObjects [[_object], true];
        } forEach allCurators;
    }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    // TODO: TBD: Change zeus watermark to KP Logo...
    ["KPLIB_curatorOpen", {
        [{
            // TODO: TBD: this looks like an oversight (?) IDD 312 (?) IDC 15717 (?)
            private _watermarkCtrl = (findDisplay 312) displayCtrl 15717;
            _watermarkCtrl ctrlSetText "KPGUI\res\kp512_ca.paa";
        }] call CBA_fnc_execNextFrame;
    }] call CBA_fnc_addEventHandler;

    // Limit curator area
    ["KPLIB_curatorOpen", {
        private _curator = getAssignedCuratorLogic player;

        // TODO: TBD: "mode" in general? or re: "curator", "zeus" (?)
        switch (_curator getVariable ["KPLIB_mode", 0]) do {
            // TODO: TBD: ditto "modes" ...
            // Limited mode
            case 1: {
                [_curator, getPosATL player] call KPLIB_fnc_virtual_curatorAreaLimit;
            };
        };
    }] call CBA_fnc_addEventHandler;
};

if (isServer) then {["Module initialized", "PRE] [VIRTUAL", true] call KPLIB_fnc_common_log;};

true
