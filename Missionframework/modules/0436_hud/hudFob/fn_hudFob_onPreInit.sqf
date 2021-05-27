#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_onPreInit

    File: fn_hudFob_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-25 17:12:09
    Last Update: 2021-05-27 13:34:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

[] call MFUNC(_settings);
[] call MFUNC(_presets);

if (hasInterface) then {
    // User interface section

    // See POST, for use internal use screening event handler callbacks
    MVAR(_reportUuid)                                   = "";

    // Wire up REPORTING+REPORT events
    { [Q(KPLIB_hud_reporting), _x] call CBA_fnc_addEventHandler; } forEach [
        { _this call MFUNC(_onReportResources);     }
        , { _this call MFUNC(_onReportIntel);       }
        , { _this call MFUNC(_onReportFriendly);    }
        , { _this call MFUNC(_onReportAssets);      }
        , { _this call MFUNC(_onReportCivilian);    }
        , { _this call MFUNC(_onReportEnemy);       }
    ];
    [Q(KPLIB_hud_report), { _this call MFUNC(_onReport); }] call CBA_fnc_addEventHandler;

    [Q(KPLIB_player_redeploy), { _this call MFUNC(_setupPlayerActions); }] call CBA_fnc_addEventHandler;
};

true;
