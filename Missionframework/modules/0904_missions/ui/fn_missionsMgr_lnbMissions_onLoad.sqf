#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_missionsMgr_lnbMissions_onLoad

    File: fn_missionsMgr_lnbMissions_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the MISSIONS LISTNBOX opens, 'onLoad'.

    Parameter(s):
        _lnbMissions - the MISSIONS LISTNBOX control opened [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/createDialog
 */

params [
    [Q(_lnbMissions), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

{
    uiNamespace setVariable _x;
} forEach [
    [QMVAR(_lnbMissions), _lnbMissions]
    , [QMVAR(_lnbMissions_config), _config]
];

true;
