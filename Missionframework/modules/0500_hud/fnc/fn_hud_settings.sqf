#include "script_component.hpp"

// ...

MPARAM(_showPeriod)                             = 1;

MPARAM(_debug)                                  = false;
MPARAM(_hasPlayerTimerElapsed_debug)            = false;
MPARAM(_onRefreshPlayerTimer_debug)             = false;
MPARAM(_onStatusReport_debug)                   = false;

MPARAM(_onShow_debug)                           = false;
MPARAM(_onReconcileOverlayMap_debug)            = false;
MPARAM(_onShowFob_debug)                        = false;
MPARAM(_onShowSector_debug)                     = false;

MPARAM(_getFobViewData_debug)                   = false;

MPARAM(_onLoad_debug)                           = false;
MPARAM(_onUnload_debug)                         = false;
MPARAM(_lnbFob_onLoad_debug)                    = false;
MPARAM(_lnbFob_onRefresh_debug)                 = false;

MPARAM2(Sector,_lblProgressBarCommitPeriod)     = 1;

MPARAM2(Sector,_onLoad_debug)                                   = false;
MPARAM2(Sector,_ctrlsGrpSector_lblProgressBar_onLoad_debug)     = false;
MPARAM2(Sector,_ctrlsGrpSector_lblProgressBar_onRefresh_debug)  = false;
MPARAM2(Sector,_ctrlsGrpSector_lblSectorText_onLoad_debug)      = false;
MPARAM2(Sector,_ctrlsGrpSector_lblSectorText_onRefresh_debug)   = false;
MPARAM2(Sector,_ctrlsGrpSector_lblTimer_onLoad_debug)           = false;
MPARAM2(Sector,_ctrlsGrpSector_lblTimer_onRefresh_debug)        = false;
MPARAM2(Sector,_getViewData_debug)                              = false;

true;
