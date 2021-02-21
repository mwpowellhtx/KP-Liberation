/*
    KPLIB_fnc_production_onPreInit

    File: fn_production_onPreInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-02-02
    Last Update: 2021-02-18 21:08:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Callback registered on pre initialization phase.

    Parameter(s):
        NONE

    Returns:
        Module preInit finished [BOOL]
*/

if (isServer) then {
    ["[fn_production_onPreInit] Initializing...", "PRE] [PRODUCTION", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
*/


/*
    ----- Module Initialization -----
*/

// Process CBA Settings
[] call KPLIB_fnc_production_settings;

if (isServer) then {
    // Server section (dedicated and player hosted)

    // Register load and save event callbacks
    ["KPLIB_doLoad", {[] call KPLIB_fnc_production_onLoadData;}] call CBA_fnc_addEventHandler;
    ["KPLIB_doSave", {[] call KPLIB_fnc_production_onSaveData;}] call CBA_fnc_addEventHandler;

    KPLIB_production_markerNameDefault = "";

    // TODO: TBD: verify and/or establish events when sectors are won (or lost) ...
    // TODO: TBD: identify when those sectors are considered factories...
    // TODO: TBD: and respond accordingly here by informing the production FSMs...

    /* First things first, we will estalish the shape of the production tuple. This
     * is the shape of the tuple that is used to facilitate ordered production,
     * capabilities, storage composition, scheduling, so on and so forth.
     *
     * Note that storage assets, storage objects, are to be built, persisted, and serialized,
     * apart from the presence of production tuples themselves.
     */

    // Corresponds to the 'KPLIB_eden_factory' or abbreviated 'KPLIB_eden_f' sector markers
    KPLIB_production_ident_default = ["", ""];
    //           1.     _markerName:  ^^
    //           2. _baseMarkerText:      ^^

    /*
        [
            // Identification tuple useful for the most common bits informing display markers
            [
                _markerName - used to identify the production sector
                , _baseMarkerText - the base text used to inform the marker text on display
            ]
            // Timer tuple - see timers module for details, _duration informs production scheduling
            , [_duration, _startTime, _elapsedTime, _timeRemaining]
            , _capability // See below.
            , _summary // See below.
            , _queue // See below.
        ]
     */

    /*
        Defaults used to inform the production tuples, some of which based on the crates:

            _capabilities - 'false' based on 'KPLIB_resources_crateClassesF'
            _summary - 0 based on 'KPLIB_resources_crateClassesF'

        Assumes that the 'KPLIB_resources_crateClassesF' are arranged by:
        [[S]upply, [A]mmo, [F]uel], or [S, A, F] for short.
     */
    KPLIB_production_cap_default = KPLIB_resources_indexes apply {false};
    KPLIB_production_cap_complete = KPLIB_resources_indexes apply {true};
    KPLIB_production_sum_default = KPLIB_resources_indexes apply {0};

    /*
        Indexes into the crate classes is used to inform production, which is also
        coordinated with cap, sum, etc. Indicates a priority queue in which the first
        element is the next element.
    */
    KPLIB_production_queue_default = [];

    // Sets up a default production tuple.
    KPLIB_production_default = +[
        KPLIB_production_ident_default
        , KPLIB_timers_default
        , [
            KPLIB_production_cap_default
            , KPLIB_production_sum_default
            , KPLIB_production_queue_default
        ]
    ];

    KPLIB_production_i_ident = 0;
    KPLIB_production_i_timer = 1;
    KPLIB_production_i_info = 2;

    KPLIB_production_ident_i_markerName = 0;
    KPLIB_production_ident_i_baseMarkerText = 1;

    KPLIB_production_info_i_cap = 0;
    KPLIB_production_info_i_sum = 1;
    KPLIB_production_info_i_queue = 2;

    // TODO: TBD: we think we will need to have some sort of push/pull capability between client/server...
    KPLIB_production_namespaces = [];

    // // // TODO: TBD: we do not want to make this public... rather clients request via events...
    // // TODO: TBD: may not want to make the array public after all...
    //publicVariable "KPLIB_production_namespaces";

    KPLIB_production_moduleData_key = "production";
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_production_onPreInit] Initialized", "PRE] [PRODUCTION", true] call KPLIB_fnc_common_log;
};

true
