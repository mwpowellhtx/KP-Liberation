#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_settings

    File: fn_hudSector_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-28 10:59:29
    Last Update: 2021-06-14 17:02:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges for the nominal module settings.

    Parameters:
        NONE

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/settings/fnc_addSetting-sqf.html
 */

MPARAM(_notifyPeriod)                           = 1;
MPARAM(_reportPeriod)                           = 3;

MPARAM(_lblProgressBarCommitPeriod)             = 1;

MPARAM(_onLoad_debug)                           = false;

MPARAM(_onNotifySectors_debug)                  = true;
MPARAM(_onNotifySectorOne_debug)                = true;

MPARAM(_onReport_debug)                         = true;

// MPARAM(_onReportingMarkerText_debug)            = true;
// MPARAM(_onReportingUnits_debug)                 = true;
// MPARAM(_onReportingTanks_debug)                 = true;
// MPARAM(_onReportingCivRes_debug)                = true;
MPARAM(_onReportingSitRep_debug)                = true;

// MPARAM(_onReportMarkerText_debug)               = true;
// MPARAM(_onReportUnits_debug)                    = true;
// MPARAM(_onReportTanks_debug)                    = true;
// MPARAM(_onReportCivRes_debug)                   = true;
MPARAM(_onReportSitRep_debug)                   = true;

MPARAM(_setMeterPosition_debug)                 = true;
MPARAMUI(_MeterElement_onLoad_debug)            = false;
MPARAMUI(_lblMarkerText_onLoad_debug)           = false;

true;
