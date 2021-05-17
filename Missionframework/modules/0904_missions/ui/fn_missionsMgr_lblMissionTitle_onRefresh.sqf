#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_missionsMgr_lblMissionTitle_onRefresh

    File: fn_missionsMgr_lblMissionTitle_onRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-22 19:47:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the MISSION TITLE LBL refreshes, 'onRefresh'.

    Parameter(s):
        _lblMissionTitle - the MISSION TITLE LBL control opened [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
 */

params [
    [Q(_lblMissionTitle), uiNamespace getVariable [QMVAR(_lblMissionTitle), controlNull], [controlNull]]
];

private _viewData = _lblMissionTitle getVariable [QMVAR(_viewData), toUpper localize "STR_KPLIB_MISSIONSMGR_LBL_MISSION_TITLE_NA"];

_lblMissionTitle ctrlSetText _viewData;

true;
