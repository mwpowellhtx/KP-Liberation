#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onPreInit

    File: fn_garrison_onPreInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-18
    Last Update: 2021-05-06 14:28:12
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
    ["[fn_garrison_onPreInit] Initializing...", "PRE] [GARRISON", true] call KPLIB_fnc_common_log;
};

[] call MFUNC(_settings);

/*
    ----- Module Globals -----
 */

/*
    ----- Module Initialization -----
 */

if (isServer) then {

    { missionNamespace setVariable [_x, _forEachIndex]; } forEach [
        QMPRESET(_garrisonIndex_units)
        , QMPRESET(_garrisonIndex_lightVehicles)
        , QMPRESET(_garrisonIndex_heavyVehicles)
        , QMPRESET(_garrisonIndex_intel)
        , QMPRESET(_garrisonIndex_ieds)
        , QMPRESET(_garrisonIndex_resources)
    ];

    // Include BLUFOR bits during mission serialization
    [KPLIB_sectors_serializationRegistry, [
            QMVAR(_bluforUnits), QMVAR(_bluforGrps)
            , QMVAR(_bluforLightVehicles), QMVAR(_bluforHeavyVehicles)
        ]
    ] call KPLIB_fnc_namespace_registerSerializationVars;

    // // // TODO: TBD: 
    // // Array to collect active garrison units
    // MVAR(_active) = [];

    // // Array which contains all garrisons
    // MVAR(_array) = [];

    // TODO: TBD: indexing matters here... not including civilian?
    // For use when serializing to/from client UI, during module data serialization, etc
    MPRESET(_allSides)                         = [
        KPLIB_preset_sideE
        , KPLIB_preset_sideF
        , KPLIB_preset_sideC
        , KPLIB_preset_sideR
    ];

    // Register LOAD+SAVE event handlers
    [Q(KPLIB_doLoad), { [] call MFUNC(_onLoadData); }] call CBA_fnc_addEventHandler;
    [Q(KPLIB_doSave), { [] call MFUNC(_onSaveData); }] call CBA_fnc_addEventHandler;

    // TODO: TBD: are these "garrison" events? or "sector" events?
    // Register SECTOR event handlers
    // [KPLIB_sector_activated, { _this call MFUNC(_onSectorActivated); }] call CBA_fnc_addEventHandler;
    // [KPLIB_sector_captured, { _this call MFUNC(_onSectorCaptured); }] call CBA_fnc_addEventHandler;
    [KPLIB_sector_deactivating, { _this call MFUNC(_onSectorDeactivating); }] call CBA_fnc_addEventHandler;
    // [KPLIB_sector_deactivated, { _this call MFUNC(_onSectorDeactivated); }] call CBA_fnc_addEventHandler;
};

// TODO: TBD: instead of BOOL gates, we may check whether a variable 'exists' (?)
// Indicator for presets initialization
MVAR(_presetInitE) = false;
MVAR(_presetInitF) = false;

// TODO: TBD: we think that this is highly unnecessary... best case is misplaced, should be done in the INIT module...
// Register preset change event handler (The if is needed, because this event is also fired on mission start, not only on change)
[Q(CBA_SettingChanged), {
    params [
        [Q(_setting), "", [""]]
        , Q(_value)
    ];

    // Detect if BLUFOR or OPFOR setting is changed
    switch (_setting) do {
        case Q(KPLIB_param_presetE): {
            // Don't fire on normal mission start
            if (!MVAR(_presetInitE)) then {
                MVAR(_presetInitE) = true;
            } else {
                // If it was changed mid game, reload preset variables, reinitialize sector garrisons and publish variables to clients
                if (isServer) then {
                    [] call KPLIB_fnc_init_loadPresets;
                    // TODO: TBD: we may also require for SECTOR module response to the same...
                    // TODO: TBD: i.e. (re-)set status, activation, etc (?) and let things re-activate 'naturally' (?)
                    [] call MFUNC(_onSideChangedClearSectorNamespaces);
                } else {
                    [] spawn KPLIB_fnc_init_receiveInit;
                };
                // Give the server admin a hint that a full server restart is recommended
                if (hasInterface && ([] call KPLIB_fnc_permission_hasAdminPermission)) then {
                    hint parseText format ["<t color='#ff0000' align='center' size='2'>%1</t><br />%2", localize "STR_KPLIB_HINT_REQUIRERESTART1", localize "STR_KPLIB_HINT_REQUIRERESTART2"];
                };
            };
        };
        case Q(KPLIB_param_presetF): {
            // Don't fire on normal mission start
            if (!MVAR(_presetInitF)) then {
                MVAR(_presetInitF) = true;
            } else {
                // If it was changed mid game, reload preset variables, reinitialize sector garrisons and publish variables to clients
                if (isServer) then {
                    [] call KPLIB_fnc_init_loadPresets;
                    // TODO: TBD: ditto above, for starters...
                    [] call MFUNC(_onSideChangedClearSectorNamespaces);
                } else {
                    [] spawn KPLIB_fnc_init_receiveInit;
                };
                // Give the server admin a hint that a full server restart is recommended
                if (hasInterface && ([] call KPLIB_fnc_permission_hasAdminPermission)) then {
                    hint parseText format ["<t color='#ff0000' align='center' size='2'>%1</t><br />%2", localize "STR_KPLIB_HINT_REQUIRERESTART1", localize "STR_KPLIB_HINT_REQUIRERESTART2"];
                };
            };
        };
        default {};
    };
}] call CBA_fnc_addEventHandler;

if (isServer) then {
    ["[fn_garrison_onPreInit] Initialized", "PRE] [GARRISON", true] call KPLIB_fnc_common_log;
};

true;