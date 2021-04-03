#include "script_component.hpp"
/*
    KPLIB_fnc_hud_settings

    File: fn_hud_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges for the nominal module settings.

    Parameters:
        NONE

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_addPlayerAction-sqf.html
        https://community.bistudio.com/wiki/addAction
        https://community.bistudio.com/wiki/setUserActionText
 */

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
