#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_onLoad

    File: fn_missionsMgr_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the dialog opens, 'onLoad'.

    Parameter(s):
        _display - the display being opened [DISPLAY, default: displayNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/createDialog
        https://community.bistudio.com/wiki/ctrlEnable
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createPerFrameHandlerObject-sqf.html
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_deletePerFrameHandlerObject-sqf.html
 */

params [
    [Q(_display), displayNull, [displayNull]]
    , [Q(_config), configNull, [configNull]]
];

uiNamespace setVariable [QMVAR(_display), _display];
uiNamespace setVariable [QMVAR(_config), _config];

[
    {
        private _display = uiNamespace getVariable [QMVAR(_display), displayNull];

        ([] call KPLIB_fnc_missionsMgr_calculateEnabledOrDisabled) params [
            [Q(_toEnable), [], [[]]]
            , [Q(_toDisable), [], [[]]]
        ];

        { _x ctrlEnable true; } forEach (_toEnable apply { _display displayCtrl _x; });
        { _x ctrlEnable false; } forEach (_toDisable apply { _display displayCtrl _x; });
    }
    , MVAR(_enableOrDisablePeriod)
    , []
    , {}
    , {}
    , {
        private _display = uiNamespace getVariable [QMVAR(_display), displayNull];
        !isNull _display;
    }
    , {
        private _display = uiNamespace getVariable [QMVAR(_display), displayNull];
        isNull _display;
    }
    , []
] call CBA_fnc_createPerFrameHandlerObject;

// Announce to the server
[KPLIB_missionsSM_missionsMgrOpened, [clientOwner]] call CBA_fnc_serverEvent;

true;
