#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_onUnload

    File: fn_missionsMgr_onUnload.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the dialog closes, 'onUnload'.

    Parameter(s):
        _display - the display being opened [DISPLAY, default: displayNull]
        _exitCode - an exit code on close [SCALAR, default: 0]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/createDialog
 */

params [
    [Q(_display), displayNull, [displayNull]]
    , [Q(_exitCode), 0, [0]]
];

// Announce to the server that dialog is now gone away
[KPLIB_missionsSM_missionsMgrClosed, [clientOwner]] call CBA_fnc_serverEvent;

private _onUnloadCtrlByName = {
    uiNamespace setVariable [_x, nil];
};

_onUnloadCtrlByName forEach MVAR(_ctBriefing_allCtrlNames);

_onUnloadCtrlByName forEach [
   QMVAR(_display)
    , QMVAR(_config)
    , QMVAR(_lnbMissions)
    , QMVAR(_lnbMissions_config)
    , QMVAR(_btnRun)
    , QMVAR(_btnRun_config)
    , QMVAR(_btnAbort)
    , QMVAR(_btnAbort_config)
    , QMVAR(_lblMissionTitle)
    , QMVAR(_lblMissionTitle_config)
    , QMVAR(_lnbTelemetry)
    , QMVAR(_lnbTelemetry_config)
    , QMVAR(_imgBriefing)
    , QMVAR(_imgBriefing_config)
    , QMVAR(_ctBriefing)
    , QMVAR(_ctBriefing_config)
];

true;
