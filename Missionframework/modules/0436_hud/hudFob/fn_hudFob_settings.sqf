#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_settings

    File: fn_hudFob_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 01:30:59
    Last Update: 2021-05-26 22:10:51
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

MPARAM(_reportPeriod)                           = 3;

MPARAM(_enemyLow)                               = 0.25;
MPARAM(_enemyMedium)                            = 0.65;
MPARAM(_enemyhigh)                              = 0.85;

MPARAM(_getReport_debug)                        = false;
MPARAM(_onReport_debug)                         = true;
MPARAM(_onReportAssets_debug)                   = false;
MPARAM(_onReportCivilian_debug)                 = false;
MPARAM(_onReportEnemy_debug)                    = false;
MPARAM(_onReportFriendly_debug)                 = false;
MPARAM(_onReportIntel_debug)                    = false;
MPARAM(_onReportResources_debug)                = false;

MPARAM(_getViewData_debug)                      = false;
MPARAM(_getViewDatum_debug)                     = false;

MPARAMUI(_onLoad_debug)                         = true;
MPARAMUI(_lnbFob_onLoad_debug)                  = true;
MPARAMUI(_lnbFob_onRefresh_debug)               = true;

true;
