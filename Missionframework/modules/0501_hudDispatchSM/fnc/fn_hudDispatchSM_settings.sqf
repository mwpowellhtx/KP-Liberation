#include "script_component.hpp"

// ...

// TODO: TBD: stand up proper CBA settings instead...
MPARAM(_dispatchPeriod)                         = 2;
MPARAM(_sectorReportRangeCoefficient)           = 5; // 1.25; // TODO: TBD: extended to 5 for now in order to test

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
MPARAM(_onReportSector_progressBar_debug)       = true;
MPARAM(_onReportSector_timer_debug)             = false;
MPARAM(_onStandby_debug)                        = false;
MPARAM(_onStandbyEntered_debug)                 = false;
MPARAM(_renderScalar_debug)                     = false;

true;
