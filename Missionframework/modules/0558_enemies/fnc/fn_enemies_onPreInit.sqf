#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_onPreInit

    File: fn_enemies_onPreInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-06-14 17:17:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/createHashMapFromArray
        https://community.bistudio.com/wiki/Category:Function_Group:_Bitwise
        https://cbateam.github.io/CBA_A3/docs/files/xeh/fnc_addClassEventHandler-sqf.html
 */

if (isServer) then {
    ["[fn_enemies_onPreInit] Initializing...", "PRE] [ENEMY", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */


/*
    ----- Module Initialization -----
 */

// Process CBA Settings, must be processed first
[] call MFUNC(_settings);

// Server section (dedicated and player hosted)
if (isServer) then {

    // Awareness of the enemy (0-100)
    MVAR(_awareness)                                                = MPARAM(_defaultAwareness);
    publicVariable QMVAR(_awareness);

    // All enemy patrols
    MVAR(_patrols)                                                  = [];

    // Strength of the enemy (0-1000)
    MVAR(_strength)                                                 = MPARAM(_defaultStrength);
    publicVariable QMVAR(_strength);

    // TODO: TBD: leaning toward refactoring civilian reputation into the ENEMY module...
    // TODO: TBD: even though it isn't really 'enemy' I cannot think of a better place to put it
    // TODO: TBD: and unless there is more of a civilian module, which is possible, do not want to intro a new module just for this just yet

    // TODO: TBD: really deserves its own module dedicated to the problem of civilian reputation
    // TODO: TBD: but for purposes of HUD, we will pencil it in here, for now...
    // TODO: TBD: while we are there we also need to define some limits, threhsolds, etc
    MVAR(_civRep)                                                   = 0;
    publicVariable QMVAR(_civRep);

    // Register load event handler
    [Q(KPLIB_doLoad), { [] call MFUNC(_loadData); }] call CBA_fnc_addEventHandler;

    // Register save event handler
    [Q(KPLIB_doSave), { [] call MFUNC(_saveData); }] call CBA_fnc_addEventHandler;

    // TODO: TBD: actually "transferring" spawned in assets (?) should be a 'mission' on its own I think...
    // Register convoy arrival event handler
    [Q(KPLIB_transferConvoy_end), { _this call MFUNC(_onTransferConvoyEnd); }] call CBA_fnc_addEventHandler;

    // Handle things ENEMY module related, assessing BDA, adding scores, etc
    [Q(KPLIB_sectors_activating), { _this call MFUNC(_onSectorActivating); }] call CBA_fnc_addEventHandler;

    { [Q(KPLIB_sectors_captured), _x] call CBA_fnc_addEventHandler; } forEach [
        { _this call MFUNC(_onSectorCaptured); }
        , { _this call MFUNC(_onBuildingsDestroyed); }
    ];

    // TODO: TBD: add "help the civilians" event as a proper 'mission'
    // TODO: TBD: CBA event handlers are assumed to occur in a guaranteed stacked order...
    // TODO: TBD: so we can depend on capture values being there when we evaluate for civilian helps

    // TODO: TBD: review this issue, so much of the old FSM 'states' no longer applicable (????)
    // TODO: TBD: https://github.com/mwpowellhtx/KP-Liberation/issues/78

    // // TODO: TBD: if we focus on "spawn buildings" buildings with buildingPos then I think we do not care about these...
    // Add building class names to ignore during the SECTOR CAPTURED BDA phase
    IGNORE_BUILDINGS(_ignoredBuildingClassNames);
    ADD_IGNORED_BUILDING(Land_Cargo_House_V1_F);
    ADD_IGNORED_BUILDING(Land_Cargo_House_V2_F);
    ADD_IGNORED_BUILDING(Land_Cargo_House_V3_F);
    ADD_IGNORED_BUILDING(Land_Cargo_HQ_V1_F);
    ADD_IGNORED_BUILDING(Land_Cargo_Patrol_V1_F);
    ADD_IGNORED_BUILDING(Land_Cargo_Tower_V1_F);
    ADD_IGNORED_BUILDING(Land_Carousel_01_F);
    ADD_IGNORED_BUILDING(Land_Communication_anchor_F);
    ADD_IGNORED_BUILDING(Land_Crane_F);
    ADD_IGNORED_BUILDING(Land_d_Addon_02_V1_F);
    ADD_IGNORED_BUILDING(Land_d_House_Big_01_V1_F);
    ADD_IGNORED_BUILDING(Land_d_House_Big_02_V1_F);
    ADD_IGNORED_BUILDING(Land_d_House_Small_01_V1_F);
    ADD_IGNORED_BUILDING(Land_d_House_Small_02_V1_F);
    ADD_IGNORED_BUILDING(Land_d_Shop_01_V1_F);
    ADD_IGNORED_BUILDING(Land_d_Shop_02_V1_F);
    ADD_IGNORED_BUILDING(Land_d_Stone_HouseBig_V1_F);
    ADD_IGNORED_BUILDING(Land_d_Stone_HouseSmall_V1_F);
    ADD_IGNORED_BUILDING(Land_d_Stone_Shed_V1_F);
    ADD_IGNORED_BUILDING(Land_d_Windmill01_F);
    ADD_IGNORED_BUILDING(Land_Dome_Big_F);
    ADD_IGNORED_BUILDING(Land_dp_transformer_F);
    ADD_IGNORED_BUILDING(Land_Flush_Light_green_F);
    ADD_IGNORED_BUILDING(Land_Flush_Light_yellow_F);
    ADD_IGNORED_BUILDING(Land_fs_feed_F);
    ADD_IGNORED_BUILDING(Land_fs_roof_F);
    ADD_IGNORED_BUILDING(Land_HighVoltageColumn_F);
    ADD_IGNORED_BUILDING(Land_HighVoltageColumnWire_F);
    ADD_IGNORED_BUILDING(Land_HighVoltageEnd_F);
    ADD_IGNORED_BUILDING(Land_HighVoltageTower_large_F);
    ADD_IGNORED_BUILDING(Land_HighVoltageTower_largeCorner_F);
    ADD_IGNORED_BUILDING(Land_IndPipe2_big_ground1_F);
    ADD_IGNORED_BUILDING(Land_IndPipe2_big_ground2_F);
    ADD_IGNORED_BUILDING(Land_IndPipe2_bigL_R_F);
    ADD_IGNORED_BUILDING(Land_LampAirport_F);
    ADD_IGNORED_BUILDING(Land_LampAirport_off_F);
    ADD_IGNORED_BUILDING(Land_LampDecor_F);
    ADD_IGNORED_BUILDING(Land_LampHalogen_F);
    ADD_IGNORED_BUILDING(Land_LampHarbour_F);
    ADD_IGNORED_BUILDING(Land_LampShabby_F);
    ADD_IGNORED_BUILDING(Land_LampSolar_F);
    ADD_IGNORED_BUILDING(Land_LampStreet_F);
    ADD_IGNORED_BUILDING(Land_LampStreet_small_F);
    ADD_IGNORED_BUILDING(Land_LifeguardTower_01_F);
    ADD_IGNORED_BUILDING(Land_nav_pier_m_F);
    ADD_IGNORED_BUILDING(Land_Pier_F);
    ADD_IGNORED_BUILDING(Land_Pier_small_F);
    ADD_IGNORED_BUILDING(Land_PierLadder_F);
    ADD_IGNORED_BUILDING(Land_PowerPoleWooden_L_F);
    ADD_IGNORED_BUILDING(Land_PowerWireBig_direct_F);
    ADD_IGNORED_BUILDING(Land_PowerWireBig_left_F);
    ADD_IGNORED_BUILDING(Land_PowerWireBig_right_F);
    ADD_IGNORED_BUILDING(Land_Research_house_V1_F);
    ADD_IGNORED_BUILDING(Land_runway_edgelight);
    ADD_IGNORED_BUILDING(Land_runway_edgelight_blue_F);
    ADD_IGNORED_BUILDING(Land_SlideCastle_F);
    ADD_IGNORED_BUILDING(Land_spp_Mirror_F);
    ADD_IGNORED_BUILDING(Land_TTowerSmall_1_F);
    ADD_IGNORED_BUILDING(Land_TTowerSmall_2_F);

    [Q(CAManBase), Q(init), {
        params [
            [Q(_target), objNull, [objNull]]
        ];

        // TODO: TBD: for now this is wired up for easier engagement and debugging during dev cycles
        // TODO: TBD: but this is not something we want to deploy in regular code
        // TODO: TBD: involve the admin bits during admin...
        // TODO: TBD: also allowing to unwire the event handler...
        // TODO: TBD: i.e. for admins or not admins, to add and remove the behavior...
        { _target addEventHandler _x; } forEach [
            [Q(Hit), { _this call KPLIB_fnc_admin_onManHit; }]
            , [Q(Killed), { _this call MFUNC(_onManKilled); }]
            , [Q(HandleRating), { _this call MFUNC(_onManHandleRating); }]
        ];

    }, true, [], true] call CBA_fnc_addClassEventHandler;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_enemies_onPreInit] Initialized", "PRE] [ENEMY", true] call KPLIB_fnc_common_log;
};

true;
