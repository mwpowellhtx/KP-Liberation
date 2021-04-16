#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_onPreInit

    File: fn_hudDispatchSM_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-16 09:05:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module initialziation phase event handler.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (isServer) then {
    ["[fn_hudDispatchSM_onPreInit] Initializing...", "PRE] [HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// Setup DISPATCH settings
[] call MFUNC(_settings);

MVAR(_dispatchStatus)                   = QMVAR(_dispatchStatus);
MVAR(_dispatchReport)                   = QMVAR(_dispatchReport);

MVAR(_fobReportPrefix)                  = QMVAR(_fobReport);
MVAR(_sectorReportPrefix)               = QMVAR(_sectorReport);

// This is defined both client and server because it serves as HUD function argument defaults
MVAR(_dispatchTimer)                    = QMVAR(_dispatchTimer);

if (isServer) then {
    // Server side init

    // TODO: TBD: this is a placeholder...
    // TODO: TBD: really deserves its own module dedicated to the problem of civilian reputation
    // TODO: TBD: but for purposes of HUD, we will pencil it in here, for now...
    // TODO: TBD: while we are there we also need to define some limits, threhsolds, etc
    KPLIB_civilian_civRep                       =    0;
    // TODO: TBD: will also need to slot that in for persistence load/save...
    KPLIB_param_civilian_maxCivRep              = 1000;
    // TODO: TBD: we double it, and triple it, depending on the circumstance, and desired game effect...
    // TODO: TBD: therefore, should be bounded to something like 30-33 ...
    KPLIB_param_civilian_civRepBaseThreshold    = 0.25;
    KPLIB_civilian_killedPenalty                =    0;

    MPRESET(_enemy_low)                         = 0.25;
    MPRESET(_enemy_medium)                      = 0.65;
    MPRESET(_enemy_high)                        = 0.85;

    MVAR(_className)                    = Q(KPLIB_hudDispatchSM);

    MVAR(_objSM)                        = locationNull;
    MVAR(_configSM)                     = configNull;

    // For use with stackable player connected/disconnected events
    MVAR(_playerConnected)              = Q(PlayerConnected);
    MVAR(_playerDisconnected)           = Q(PlayerDisconnected);

    MVAR(_standbyStatus)                = QMVAR(_standbyStatus);
    MVAR(_standbyReport)                = QMVAR(_standbyReport);

    MVAR(_reportFob)                    = QMVAR(_reportFob);
    MVAR(_reportSector)                 = QMVAR(_reportSector);

    MVAR(_unitsPath)                    = "\A3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_CA.paa";

    MVAR(_rotaryPath)                   = "\A3\air_f_beta\Heli_Transport_01\Data\UI\Map_Heli_Transport_01_base_CA.paa";
    MVAR(_fixedWingPath)                = "\A3\Air_F_EPC\Plane_CAS_01\Data\UI\Map_Plane_CAS_01_CA.paa";

    MVAR(_civRepPath)                   = "\A3\ui_f\data\map\mapcontrol\tourism_CA.paa";

    MVAR(_awarenessRatioPath)           = "\A3\ui_f\data\map\markers\handdrawn\unknown_CA.paa";
    MVAR(_strengthRatioPath)            = "\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa";
};

if (hasInterface) then {

    // TODO: TBD: this is a tighter view data form factor we think...
    // TODO: TBD: the only rub appears to be, we cannot get right aligned text to work quite right
    MVAR(_lnbFob_viewDataKeys)              = [
        [QMVAR(_fobReport_markerText)       , QMVAR(_fobReport_markerPath)          , QMVAR(_fobReport_markerColor)     ]
        , [QMVAR(_fobReport_supply)         , QMVAR(_fobReport_supplyPath)          , QMVAR(_fobReport_supplyColor)     ]
        , [QMVAR(_fobReport_ammo)           , QMVAR(_fobReport_ammoPath)            , QMVAR(_fobReport_ammoColor)       ]
        , [QMVAR(_fobReport_fuel)           , QMVAR(_fobReport_fuelPath)            , QMVAR(_fobReport_fuelColor)       ]
        , [QMVAR(_fobReport_intel)          , QMVAR(_fobReport_intelPath)           , QMVAR(_fobReport_intelColor)      ]
        , [QMVAR(_fobReport_unitsCount)     , QMVAR(_fobReport_unitsPath)                                               ]
        , [QMVAR(_fobReport_rotaryCount)    , QMVAR(_fobReport_rotaryPath)                                              ]
        , [QMVAR(_fobReport_fixedWingCount) , QMVAR(_fobReport_fixedWingPath)                                           ]
        , [QMVAR(_fobReport_civRep)         , QMVAR(_fobReport_civRepPath)          , QMVAR(_fobReport_civRepColor)     ]
        , [QMVAR(_fobReport_awareness)      , QMVAR(_fobReport_awarenessPath)       , QMVAR(_fobReport_awarenessColor)  ]
        , [QMVAR(_fobReport_strength)       , QMVAR(_fobReport_strengthPath)        , QMVAR(_fobReport_strengthColor)   ]
    ];

    MVAR(_sectorReport_lnbTimerText_viewDataKeys)       = [
        QMVAR(_sectorReport_timer)
        , QMVAR(_sectorReport_timerColor)
    ];

    // Does not care about the PROGRESS BAR, but rather we need to know DEFENDING COLOR
    MVAR(_sectorReport_lnbSectorText_viewDataKeys)      = [
        QMVAR(_sectorReport_markerText)
        , QMVAR(_sectorReport_gridref)
        , QMVAR(_sectorReport_defendingColor)
    ];

    MVAR(_sectorReport_progressBar_viewDataKeys)        = [
        QMVAR(_sectorReport_lblPbOpfor_widthCoefficient)
    ];


    // Aggregate 'flattens' the keys
    MVAR(_fobReportKeys)                    = [[], MVAR(_lnbFob_viewDataKeys)] call KPLIB_fnc_linq_aggregate;

    // /* Empty arrays herein are not a mistake, because remember, added
    //  * CT_CONTROLS_TABLE HEADER/ROW sets include a BACKGROUND CTRL,
    //  * in the form: ['_lblBg', '_lblReport', '_lblPicture'] */

    // MVAR(_ctrlHashMapKeys)              = [
    //     // [
    //     //     []
    //     //     , [QMVAR(_fobReport_markerText), QMVAR(_fobReport_markerColor)]
    //     //     , [QMVAR(_fobReport_markerPath), QMVAR(_fobReport_markerColor)]
    //     // ]
    //     // , [
    //     //     []
    //     //     , [QMVAR(_fobReport_supply), QMVAR(_fobReport_supplyColor)]
    //     //     , [QMVAR(_fobReport_supplyPath), QMVAR(_fobReport_supplyColor)]
    //     // ]
    //     // , [
    //     //     []
    //     //     , [QMVAR(_fobReport_ammo), QMVAR(_fobReport_ammoColor)]
    //     //     , [QMVAR(_fobReport_ammoPath), QMVAR(_fobReport_ammoColor)]
    //     // ]
    //     // , [
    //     //     []
    //     //     , [QMVAR(_fobReport_fuel), QMVAR(_fobReport_fuelColor)]
    //     //     , [QMVAR(_fobReport_fuelPath), QMVAR(_fobReport_fuelColor)]
    //     // ]
    //     // , [
    //     //     []
    //     //     , [QMVAR(_fobReport_unitsCount)]
    //     //     , [QMVAR(_fobReport_unitsCountPath)]
    //     // ]
    //     // , [
    //     //     []
    //     //     , [QMVAR(_fobReport_rotaryCount)]
    //     //     , [QMVAR(_fobReport_rotaryCountPath)]
    //     // ]
    //     // , [
    //     //     []
    //     //     , [QMVAR(_fobReport_fixedWingCount)]
    //     //     , [QMVAR(_fobReport_fixedWingCountPath)]
    //     // ]
    //     // , [
    //     //     []
    //     //     , [QMVAR(_fobReport_awareness), QMVAR(_fobReport_awarenessColor)]
    //     //     , [QMVAR(_fobReport_awarenessPath), QMVAR(_fobReport_awarenessColor)]
    //     // ]
    //     // , [
    //     //     []
    //     //     , [QMVAR(_fobReport_strength), QMVAR(_fobReport_strengthColor)]
    //     //     , [QMVAR(_fobReport_strengthPath), QMVAR(_fobReport_strengthColor)]
    //     // ]
    //     // , [
    //     //     []
    //     //     , [QMVAR(_fobReport_civRep), QMVAR(_fobReport_civRepColor)]
    //     //     , [QMVAR(_fobReport_civRepPath), QMVAR(_fobReport_civRepColor)]
    //     // ]
    //     // , [
    //     //     []
    //     //     , [QMVAR(_fobReport_intel), QMVAR(_fobReport_intelColor)]
    //     //     , [QMVAR(_fobReport_intelPath), QMVAR(_fobReport_intelColor)]
    //     // ]
    // ];
};

if (isServer) then {
    ["[fn_hudDispatchSM_onPreInit] Initialized", "PRE] [HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

true;
