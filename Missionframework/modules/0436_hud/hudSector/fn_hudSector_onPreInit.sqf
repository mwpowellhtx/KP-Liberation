#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_onPreInit

    File: fn_hudSector_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-06-14 17:03:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameters:
        NONE

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_rscLayer
 */

if (hasInterface || isServer) then {
    ["[fn_hudSector_onPreInit] Initializing...", "PRE] [HUDSECTOR", true] call KPLIB_fnc_common_log;
};

// Ensure presets and settings are applied
[] call MFUNC(_presets);
[] call MFUNC(_settings);


// // The view mode set on PLAYER variables [BOOL, default: false]
// MVAR(_reportAllResources)                   = QMVAR(_reportAllResources);

// // We use the flags to indicate which bits require an update
// MSTATUS(_standby)                           = 0;
// /* Meaning, no report is NO REPORT, nothing to report, which is
//  * still a REPORT, and which potentially blanks an overlay. */
// MSTATUS(_noReport)                          = 1;
// MSTATUS(_fob)                               = 2;
// MSTATUS(_sector)                            = 4;

// // Which signals to handle the HUD OVERLAY state
// MSTATUS(_overlay)                           = MSTATUS(_fob) + MSTATUS(_sector);


// // // TODO: TBD: This module does not have to do much lifting when it comes to presenting us with useful UI bits
// // // TODO: TBD: Instead the HUDDISPATCHSM module itself tell us what it intends to report
// // // TODO: TBD: And we will simply roll with that meta data in order to populate the control tables
// // Setup some variables which reach across client and server for purposes of coordinating reports
// MFOB(_markerText)                           = QMFOB(_markerText);
// MFOB(_supply)                               = QMFOB(_supply);
// MFOB(_ammo)                                 = QMFOB(_ammo);
// MFOB(_fuel)                                 = QMFOB(_fuel);
// MFOB(_intel)                                = QMFOB(_intel);
// MFOB(_enemyAwareness)                       = QMFOB(_enemyAwareness);
// MFOB(_enemyStrength)                        = QMFOB(_enemyStrength);
// MFOB(_unitCount)                            = QMFOB(_unitCount);
// MFOB(_rotaryCount)                          = QMFOB(_rotaryCount);
// MFOB(_fixedWingCount)                       = QMFOB(_fixedWingCount);

// MSECTOR(_markerText)                        = QMSECTOR(_markerText);
// MSECTOR(_gridref)                           = QMSECTOR(_gridref);
// MSECTOR(_captured)                          = QMSECTOR(_captured);
// MSECTOR(_engaged)                           = QMSECTOR(_engaged);
// MSECTOR(_tower)                             = QMSECTOR(_tower);
// MSECTOR(_bluforCount)                       = QMSECTOR(_bluforCount);
// MSECTOR(_opforCount)                        = QMSECTOR(_opforCount);
// MSECTOR(_civilianCount)                     = QMSECTOR(_civilianCount);
// MSECTOR(_resistanceCount)                   = QMSECTOR(_resistanceCount);

// MOVERLAY(_fobSitrep)                        = QMOVERLAY(_fobSitrep);
// MOVERLAY(_sectorSitrep)                     = QMOVERLAY(_sectorSitrep);


// TODO: TBD: we could count more/other things as well, but this gets us parity, more or less, with legacy
if (hasInterface) then {

    // See POST, for use internal use screening event handler callbacks
    MVAR(_reportUuid)                                   = "";

    // Wire up REPORTING+REPORT events
    { [Q(KPLIB_hud_reporting), _x] call CBA_fnc_addEventHandler; } forEach [
        { _this call MFUNC(_onReportingSitRep);    }
    ];

    { [Q(KPLIB_hud_report), _x] call CBA_fnc_addEventHandler; } forEach [
        { _this call MFUNC(_onReport); }
        , { _this call MFUNC(_onReportSitRep); }
    ];

    [Q(KPLIB_player_redeploy), { _this call MFUNC(_setupPlayerActions); }] call CBA_fnc_addEventHandler;
};

if (isServer) then {
    // Server side init
};

if (hasInterface) then {
    // Client side init

    // MVAR(_ctSector_ctrlIdcs)                    = [];
    // MVAR(_ctFob_ctrlIdcs)                       = [];


    // MVAR2(Sector,_action_blank)                 = Q(blank);
    // MVAR2(Sector,_action_overlay)               = Q(overlay);

    // MVAR2(Sector,_pbSide_blufor)                = "blufor";
    // MVAR2(Sector,_pbSide_opfor)                 = "opfor";

    // TODO: TBD: status should be sufficient to determine whether we have one report or another
    // TODO: TBD: but just in case, we bundle the report names for use throughout

    // // Which can be useful when determining whether report include FOB
    // MFOB(_variableNames)                        = [
    //     MFOB(_markerText)
    //     , MFOB(_supply)
    //     , MFOB(_ammo)
    //     , MFOB(_fuel)
    //     , MFOB(_unitCount)
    //     , MFOB(_rotaryCount)
    //     , MFOB(_fixedWingCount)
    //     , MFOB(_awareness)
    //     , MFOB(_strength)
    //     , MFOB(_civRep)
    //     , MFOB(_intel)
    // ];

    // // Ditto including SECTOR bits
    // MSECTOR(_variableNames)                     = [
    //     MSECTOR(_markerText)
    //     , MSECTOR(_gridref)
    //     , MSECTOR(_captured)
    //     , MSECTOR(_engaged)
    //     , MSECTOR(_tower)
    //     , MSECTOR(_bluforCount)
    //     , MSECTOR(_opforCount)
    //     , MSECTOR(_civilianCount)
    //     , MSECTOR(_resistanceCount)
    // ];

    // // TODO: TBD: starting small baby steps, get these couple of scenarios working first
    // // TODO: TBD: work out the wrinkles, achieve a seamless rinse and repeat approach...
    // MVAR(_sectorOverlayIdcsToSet)               = [
    //     KPLIB_IDC_HUD_GRPSECTOR_LBLMARKERTEXT
    // ];

    // MVAR(_fobOverlayIdcsToSet)                  = [
    //     KPLIB_IDC_HUD_GRPFOB_LBLMARKERTEXT
    //     , KPLIB_IDC_HUD_GRPFOB_LBLMARKERPICTURE
    // ];
};

if (hasInterface || isServer) then {
    ["[fn_hudSector_onPreInit] Finished", "PRE] [HUDSECTOR", true] call KPLIB_fnc_common_log;
};

true;