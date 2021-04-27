#include "script_component.hpp"
/*
    KPLIB_fnc_resources_preInit

    File: fn_resources_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell
    Created: 2018-12-13
    Last Update: 2021-04-21 10:50:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/xeh/fnc_addClassEventHandler-sqf.html
 */

if (isServer) then {
    ["Module initializing...", "PRE] [RESOURCES", true] call KPLIB_fnc_common_log;
};


/*
    ----- Module Globals -----
 */

MVAR(_resourceKind_sup) = "Supply";
MVAR(_resourceKind_amm) = "Ammo";
MVAR(_resourceKind_fue) = "Fuel";

MVAR(_resourceKinds) = [
    MVAR(_resourceKind_sup)
    , MVAR(_resourceKind_amm)
    , MVAR(_resourceKind_fue)
];

// TODO: TBD: is a Z offset even necessary? when we have different offsets for different crate class names...
// TODO: TBD: or perhaps would be better to establish a base offset, then the crate offset is an offset from the offset...
MVAR(_storageOffsetZ)                       = 0.6;

// TODO: TBD: there's got to be a better way to align these than a hard-coded table...
// TODO: TBD: i.e. never heard of a matrix for loop?

// TODO: TBD: we can probably rinse and repeat this same thing assembling transport vehicle configs as well...
// Large storage area placement position offsets
MVAR(_storageOffsetsLarge)                  = [
    [-5.59961, -3.99902, -2.39941, -0.799805, 0.800781, 2.40039, 4.00098, 5.60059]
    , [3.60938, 1.80859, 0.00976563, -1.79102, -3.58984]
] call KPLIB_fnc_resources_registerStoragePositions;

// Small storage area placement position offsets
MVAR(_storageOffsetsSmall)                  = [
    [-2.34961, -0.75, 0.850586, 2.4502]
    , [1.80078, 0, -1.79883]
] call KPLIB_fnc_resources_registerStoragePositions;

// Configuration settings for crates transported by vehicles ["classname", distance from vehicle center to unload crate, attachTo positions for each box].
// Set and filtered on the server
if (isServer) then {

    // Intel currency resource amount
    MVAR(_intel)                            = 0;

    MVAR(_transportConfigs)                 = [[
        ["B_Heli_Transport_03_F",                        7.5, [[0.00,  2.20, -1.00], [0.00,  0.50, -1.00], [0.00, -1.20, -1.00]                                            ]],
        ["B_Heli_Transport_03_unarmed_F",                7.5, [[0.00,  2.20, -1.00], [0.00,  0.50, -1.00], [0.00, -1.20, -1.00]                                            ]],
        ["B_T_Truck_01_covered_F",                       6.5, [[0.00, -0.40,  0.40], [0.00, -2.10,  0.40], [0.00, -3.80,  0.40]                                            ]],
        ["B_T_Truck_01_transport_F",                     6.5, [[0.00, -0.40,  0.40], [0.00, -2.10,  0.40], [0.00, -3.80,  0.40]                                            ]],
        ["B_T_VTOL_01_infantry_F",                       7.5, [[0.00,  4.70, -4.88], [0.00,  3.00, -4.88], [0.00,  1.30, -4.88], [0.00, -0.40, -4.88], [0.00, -2.10, -4.88]]],
        ["B_T_VTOL_01_vehicle_F",                        7.5, [[0.00,  4.70, -4.88], [0.00,  3.00, -4.88], [0.00,  1.30, -4.88], [0.00, -0.40, -4.88], [0.00, -2.10, -4.88]]],
        ["B_Truck_01_covered_F",                         6.5, [[0.00, -0.40,  0.40], [0.00, -2.10,  0.40], [0.00, -3.80,  0.40]                                            ]],
        ["B_Truck_01_transport_F",                       6.5, [[0.00, -0.40,  0.40], [0.00, -2.10,  0.40], [0.00, -3.80,  0.40]                                            ]],
        ["CUP_B_Wolfhound_GMG_GB_W",                     6.5, [[0.00, -3.50,  2.30]                                                                                        ]],
        ["CUP_B_Wolfhound_HMG_GB_W",                     6.5, [[0.00, -3.50,  2.30]                                                                                        ]],
        ["CUP_B_Wolfhound_LMG_GB_W",                     6.5, [[0.00, -3.50,  2.30]                                                                                        ]],
        ["C_Offroad_01_F",                               6.5, [[0.00, -1.70,  0.40]                                                                                        ]],
        ["C_Truck_02_covered_F",                         6.5, [[0.00,  0.30,  0.05], [0.00, -1.30,  0.05], [0.00, -2.90,  0.05]                                            ]],
        ["C_Truck_02_transport_F",                       6.5, [[0.00,  0.30,  0.05], [0.00, -1.30,  0.05], [0.00, -2.90,  0.05]                                            ]],
        ["C_Van_01_transport_F",                         6.5, [[0.00, -1.10,  0.25], [0.00, -2.60,  0.25]                                                                  ]],
        ["I_C_Van_01_transport_F",                       6.5, [[0.00, -1.10,  0.25], [0.00, -2.60,  0.25]                                                                  ]],
        ["I_G_Offroad_01_F",                             6.5, [[0.00, -1.70,  0.40]                                                                                        ]],
        ["I_G_Van_01_transport_F",                       6.5, [[0.00, -1.10,  0.25], [0.00, -2.60,  0.25]                                                                  ]],
        ["I_Heli_Transport_02_F",                        6.5, [[0.00,  4.20, -1.45], [0.00,  2.50, -1.45], [0.00,  0.80, -1.45], [0.00, -0.90, -1.45]                      ]],
        ["LOP_TAK_Civ_Ural",                             6.5, [[0.00, -0.20,  0.55], [0.00, -1.40,  0.55], [0.00, -2.55,  0.55]                                            ]],
        ["LOP_TAK_Civ_Ural_open",                        6.5, [[0.00, -0.20,  0.55], [0.00, -1.40,  0.55], [0.00, -2.55,  0.55]                                            ]],
        ["O_G_Offroad_01_F",                             6.5, [[0.00, -1.70,  0.40]                                                                                        ]],
        ["O_G_Van_01_transport_F",                       6.5, [[0.00, -1.10,  0.25], [0.00, -2.60,  0.25]                                                                  ]],
        ["O_T_Truck_03_covered_ghex_F",                  6.5, [[0.00, -0.80,  0.40], [0.00, -2.40,  0.40], [0.00, -4.00,  0.40]                                            ]],
        ["O_T_Truck_03_transport_ghex_F",                6.5, [[0.00, -0.80,  0.40], [0.00, -2.40,  0.40], [0.00, -4.00,  0.40]                                            ]],
        ["O_Truck_03_covered_F",                         6.5, [[0.00, -0.80,  0.40], [0.00, -2.40,  0.40], [0.00, -4.00,  0.40]                                            ]],
        ["O_Truck_03_transport_F",                       6.5, [[0.00, -0.80,  0.40], [0.00, -2.40,  0.40], [0.00, -4.00,  0.40]                                            ]],
        ["RHS_CH_47F",                                   7.5, [[0.00,  2.20, -1.70], [0.00,  0.50, -1.70], [0.00, -1.20, -1.70]                                            ]],
        ["RHS_CH_47F_10",                                7.5, [[0.00,  2.20, -1.70], [0.00,  0.50, -1.70], [0.00, -1.20, -1.70]                                            ]],
        ["RHS_CH_47F_light",                             7.5, [[0.00,  2.20, -1.70], [0.00,  0.50, -1.70], [0.00, -1.20, -1.70]                                            ]],
        ["RHS_Ural_Civ_03",                              6.5, [[0.00, -0.20,  0.55], [0.00, -1.40,  0.55], [0.00, -2.55,  0.55]                                            ]],
        ["RHS_Ural_MSV_01",                              6.5, [[0.00, -0.20,  0.55], [0.00, -1.40,  0.55], [0.00, -2.55,  0.55]                                            ]],
        ["RHS_Ural_Open_Civ_03",                         6.5, [[0.00, -0.20,  0.55], [0.00, -1.40,  0.55], [0.00, -2.55,  0.55]                                            ]],
        ["RHS_Ural_Open_MSV_01",                         6.5, [[0.00, -0.20,  0.55], [0.00, -1.40,  0.55], [0.00, -2.55,  0.55]                                            ]],
        ["UK3CB_BAF_Merlin_HC3_18_DPMT",                 7.5, [[0.25,  3.70, -1.50], [0.25,  1.60, -1.50], [0.25, -0.40, -1.50]                                            ]],
        ["UK3CB_BAF_Merlin_HC3_32_MTP",                  7.5, [[0.25,  3.70, -1.50], [0.25,  1.60, -1.50], [0.25, -0.40, -1.50]                                            ]],
        ["UK3CB_BAF_Merlin_HC3_CSAR_MTP",                7.5, [[0.25,  3.70, -1.50], [0.25,  1.60, -1.50], [0.25, -0.40, -1.50]                                            ]],
        ["rhsusf_M1078A1P2_B_M2_d_flatbed_fmtv_usarmy",  5.0, [[0.00, -0.20,  0.45], [0.00, -1.90,  0.45]                                                                  ]],
        ["rhsusf_M1078A1P2_B_M2_wd_flatbed_fmtv_usarmy", 5.0, [[0.00, -0.20,  0.45], [0.00, -1.90,  0.45]                                                                  ]],
        ["rhsusf_M1078A1P2_d_flatbed_fmtv_usarmy",       5.0, [[0.00, -0.20,  0.45], [0.00, -1.90,  0.45]                                                                  ]],
        ["rhsusf_M1078A1P2_wd_flatbed_fmtv_usarmy",      5.0, [[0.00, -0.20,  0.45], [0.00, -1.90,  0.45]                                                                  ]],
        ["rhsusf_M1083A1P2_B_M2_d_flatbed_fmtv_usarmy",  5.0, [[0.00, -0.20,  0.45], [0.00, -1.90,  0.45]                                                                  ]],
        ["rhsusf_M1083A1P2_B_M2_wd_flatbed_fmtv_usarmy", 5.0, [[0.00, -0.20,  0.45], [0.00, -1.90,  0.45]                                                                  ]],
        ["rhsusf_M1083A1P2_d_fmtv_usarmy",               5.0, [[0.00, -0.20,  0.45], [0.00, -1.90,  0.45]                                                                  ]],
        ["rhsusf_M1083A1P2_d_open_fmtv_usarmy",          5.0, [[0.00, -0.20,  0.45], [0.00, -1.90,  0.45]                                                                  ]],
        ["rhsusf_M1083A1P2_wd_fmtv_usarmy",              5.0, [[0.00, -0.20,  0.45], [0.00, -1.90,  0.45]                                                                  ]],
        ["rhsusf_M1083A1P2_wd_open_fmtv_usarmy",         5.0, [[0.00, -0.20,  0.45], [0.00, -1.90,  0.45]                                                                  ]],
        ["rhsusf_M977A4_BKIT_M2_usarmy_d",               6.5, [[0.00,  0.40,  0.70], [0.00, -1.30,  0.70], [0.00, -3.00,  0.70]                                            ]],
        ["rhsusf_M977A4_BKIT_M2_usarmy_wd",              6.5, [[0.00,  0.40,  0.70], [0.00, -1.30,  0.70], [0.00, -3.00,  0.70]                                            ]],
        ["rhsusf_M977A4_BKIT_usarmy_d",                  6.5, [[0.00,  0.40,  1.40], [0.00, -1.30,  1.40], [0.00, -3.00,  1.40]                                            ]],
        ["rhsusf_M977A4_BKIT_usarmy_wd",                 6.5, [[0.00,  0.40,  1.40], [0.00, -1.30,  1.40], [0.00, -3.00,  1.40]                                            ]],
        ["rhsusf_m998_d_2dr_halftop",                    4.5, [[0.00, -0.90, -0.20]                                                                                        ]],
        ["rhsusf_m998_w_2dr_halftop",                    4.5, [[0.00, -0.90, -0.20]                                                                                        ]]
    ]] call KPLIB_fnc_init_filterMods;

    // Plain transport vehicle classnames array
    MVAR(_transportVehicles)                = MVAR(_transportConfigs) apply { _x select 0; };

    // Send filtered lists to clients
    publicVariable "KPLIB_resources_transportConfigs";
    publicVariable "KPLIB_resources_transportVehicles";
};


/*
    ----- Module Initialization -----
 */

// Process CBA Settings
[] call MFUNC(_settings);

// TODO: TBD: may capture in terms of CBA settings...
MPARAM(_loadRange)                          = 20;

MVAR(_i_sup)                                = 0;
MVAR(_i_amm)                                = 1;
MVAR(_i_fue)                                = 2;

MVAR(_indexes)                              = [
    MVAR(_i_sup)
    , MVAR(_i_amm)
    , MVAR(_i_fue)
];

MVAR(_capDefault)                           = MVAR(_indexes) apply { false; };
MVAR(_storageValueDefault)                  = MVAR(_indexes) apply { 0; };

/* We will require these when we begin coordinating with proper transactional
 * based accounting. Especially to align indices with their types. */
MVAR(_crateClassesF)                        = [
    KPLIB_preset_crateSupplyF
    , KPLIB_preset_crateAmmoF
    , KPLIB_preset_crateFuelF
];

MVAR(_storageClassesF)                      = [
    KPLIB_preset_storageSmallF
    , KPLIB_preset_storageLargeF
];

// Some globals defined here on the server as the used preset variables aren't present on the clients yet but needed in initial loading
// All valid crate classnames
MVAR(_crateClasses)                         = [
    KPLIB_preset_crateSupplyF
    , KPLIB_preset_crateAmmoF
    , KPLIB_preset_crateFuelF
    , KPLIB_preset_crateSupplyE
    , KPLIB_preset_crateAmmoE
    , KPLIB_preset_crateFuelE
];

// All valid storage classnames
MVAR(_storageClasses)                       = [
    KPLIB_preset_storageSmallE
    , KPLIB_preset_storageSmallF
    , KPLIB_preset_storageLargeE
    , KPLIB_preset_storageLargeF
];

// Storage classnames concerning factory sectors
MVAR(_factoryStorageClasses)                = [
    KPLIB_preset_storageSmallE
    , KPLIB_preset_storageSmallF
];

if (isServer) then {
    // Arrange some debug flags
    MPARAM(_pay_debug)                      = false;
};

// Server section (dedicated and player hosted)
if (isServer) then {

    // Specify in biggest to smallest order
    MPRESET(_intelClassNames)               = [
        Q(Land_MobilePhone_smart_F)         // Mobile smart phone
        , Q(Land_Laptop_F)                  // Laptop
        , Q(Land_Document_01_F)             // Top secret documents
    ];

    MPARAM(_gatherIntelRange)               = 10;

    {
        private _className = _x;
        [_className, Q(init), MFUNC(_onIntelInit), true, [], true] call CBA_fnc_addClassEventHandler;
    } forEach MPRESET(_intelClassNames);

    MPARAM(_refreshStorageValuePeriodSeconds) = 5;

    // Register load event handler
    ["KPLIB_doLoad", { [] call MFUNC(_loadData); }] call CBA_fnc_addEventHandler;

    // Register save event handler
    ["KPLIB_doSave", { [] call MFUNC(_saveData); }] call CBA_fnc_addEventHandler;

    // Adding actions to spawned crates and storages
    ["KPLIB_vehicle_spawned", { _this call MFUNC(_addActions); }] call CBA_fnc_addEventHandler;

    // TOOD: TBD: may not neecd to public anything as long as these are defined for all...
    publicVariable "KPLIB_resources_crateClassesF";
    publicVariable "KPLIB_resources_storageClassesF";

    // Publish variables to clients
    publicVariable "KPLIB_resources_crateClasses";
    publicVariable "KPLIB_resources_storageClasses";

    // Array for all spawned resource crates
    MVAR(_allCrates) = [];

    // Array for all storages
    MVAR(_allStorages) = [];
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

MVAR(_imagePaths) = [
    "res\ui_supplies.paa"
    , "res\ui_ammo.paa"
    , "res\ui_fuel.paa"
];

MVAR(_capabilityKeys) = [
    "STR_KPLIB_PRODUCTION_CAPABILITY_SUPPLY"
    , "STR_KPLIB_PRODUCTION_CAPABILITY_AMMO"
    , "STR_KPLIB_PRODUCTION_CAPABILITY_FUEL"
];

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["Module initialized", "PRE] [RESOURCES", true] call KPLIB_fnc_common_log;
};

true;
