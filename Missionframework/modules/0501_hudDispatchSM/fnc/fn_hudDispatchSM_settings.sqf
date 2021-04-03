#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_settings

    File: fn_hudDispatchSM_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges for some nominal module settings.
 */

// TODO: TBD: stand up proper CBA settings instead...
MPARAM(_dispatchPeriod)                         = 2;

MPARAM(_debug)                                  = false;
MPARAM(_createReportContext_debug)              = false;
MPARAM(_createSM_debug)                         = false;
MPARAM(_getFobAssets_debug)                     = false;
MPARAM(_getSectorUnits_debug)                   = false;
MPARAM(_getUnits_debug)                         = false;
MPARAM(_onCompileReport_debug)                  = false;
MPARAM(_onCreateReportContext_initFob_debug)    = false;
MPARAM(_onCreateReportContext_initSector_debug) = false;
MPARAM(_onDispatchEntered_debug)                = false;
MPARAM(_onGetList_debug)                        = false;
MPARAM(_onNoOp_debug)                           = false;
MPARAM(_onPlayerConnected_debug)                = false;
MPARAM(_onPlayerDisonnected_debug)              = false;
MPARAM(_onReportFob_debug)                      = false;
MPARAM(_onReportFob_assets_debug)               = false;
MPARAM(_onReportFob_civReputation_debug)        = false;
MPARAM(_onReportFob_enemy_debug)                = false;
MPARAM(_onReportFob_intel_debug)                = false;
MPARAM(_onReportFob_markerText_debug)           = false;
MPARAM(_onReportFob_resources_debug)            = false;
MPARAM(_onReportFob_units_debug)                = false;
MPARAM(_onReportSector_debug)                   = false;
MPARAM(_onReportSector_gridref_debug)           = false;
MPARAM(_onReportSector_markerText_debug)        = false;
MPARAM(_onReportSector_progressBar_debug)       = false;
MPARAM(_onReportSector_timer_debug)             = false;
MPARAM(_onStandby_debug)                        = false;
MPARAM(_onStandbyEntered_debug)                 = false;
MPARAM(_renderScalar_debug)                     = false;

true;
