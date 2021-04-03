#include "script_component.hpp"
/*
    KPLIB_fnc_hud_onPostInit

    File: fn_hud_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameters:
        NONE

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitUntilAndExecute-sqf.html
 */

if (hasInterface) then {
    ["[fn_hud_onPostInit] Entering...", "POST] [HUD", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server side init
};

if (hasInterface) then {
    // Client side init

    ["KPLIB_player_redeploy", {
        params [
            [Q(_player), objNull, [objNull]]
        ];
        // Clear out the HUD OVERLAY variables on REDEPLOY, allows for a next cut to occur
        _player setVariable [QMVAR(_lastStatusReportAction), nil];
    }] call CBA_fnc_addEventHandler;

    // Setup some player actions
    [] call MFUNC(_setupPlayerActions);

    // TODO: TBD: trying a poor man's right alignment using some randomized data...
    private _getViewData = {
        private _get = {
            params [
                [Q(_suffix), "", [""]]
            ];
            format ["%1%2", random 10000 toFixed 0, _suffix];
        };
        private _retval = [
            ["FOB TEST", KPLIB_core_fobMarkerPath, KPLIB_core_fobColor]
            , [[] call _get, "res\ui_supplies.paa", [0, 0.8, 0, 1]]
            , [[] call _get, "res\ui_ammo.paa", [0.8, 0, 0, 1]]
            , [[] call _get, "res\ui_fuel.paa", [0.8, 0.8, 0, 1]]
            , [[] call _get, "\A3\Ui_f\data\GUI\Cfg\Ranks\general_gs.paa", KPLIB_preset_common_intelColor]
            , [[] call _get, "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa"]
            , [[] call _get, "\A3\air_f_beta\Heli_Transport_01\Data\UI\Map_Heli_Transport_01_base_CA.paa"]
            , [[] call _get, "\A3\Air_F_EPC\Plane_CAS_01\Data\UI\Map_Plane_CAS_01_CA.paa"]
            , [["%"] call _get, "\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa"]
            , [["%"] call _get, "\A3\ui_f\data\map\mapcontrol\tourism_CA.paa"]
        ];
        private _width = [_retval apply { count (_x#0); }, { (_this#0); }] call KPLIB_fnc_linq_max;
        _retval = _retval apply {
            _x params [
                [Q(_0), "", [""]]
                , Q(_1)
                , Q(_2)
            ];
            while {count _0 < _width} do { _0 = " " + _0; };
            if (isNil Q(_2)) then { [_0, _1]; } else { [_0, _1, _2]; };
        };
        _retval;
    };

    // Because ^^ can be an expensive operation, reserve it only as needed
    MVAR(_fobReport_sampleViewData) = [] call _getViewData;

    [
        {KPLIB_campaignRunning}
        , MFUNC(_onShow)
        , [player]
        , MPARAM(_showPeriod)
    ] call CBA_fnc_waitUntilAndExecute;
};

if (hasInterface) then {
    ["[fn_hud_onPostInit] Finished", "POST] [HUD", true] call KPLIB_fnc_common_log;
};

true;
