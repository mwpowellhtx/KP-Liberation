#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_btnRequest_onButtonClick

    File: fn_missionsMgr_btnRequest_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-23 20:15:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the RUN or ABORT request BUTTON was clicked, 'onButtonClick'.

    Parameter(s):
        _btnRequest - the RUN or ABORT request BUTTON control that was clicked [CONTROL, default: controlNull]
        _request - the MISSION REQUEST being performed [STRING, default: KPLIB_missionsCO_requestRun]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
 */

params [
    [Q(_btnRequest), controlNull, [controlNull]]
    , [Q(_request), KPLIB_missionsCO_requestRun, [""]]
];

private _targetUuid = [] call MFUNC(_lnbMissions_getData);

[KPLIB_missionsCO_request, [_request, _targetUuid, clientOwner]] call CBA_fnc_serverEvent;

true;
