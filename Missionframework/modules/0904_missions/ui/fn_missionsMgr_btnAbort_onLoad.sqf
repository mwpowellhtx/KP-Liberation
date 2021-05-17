#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_missionsMgr_btnAbort_onLoad

    File: fn_missionsMgr_btnAbort_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-22 09:44:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the ABORT BUTTON was loaded, 'onLoad'.

    Parameter(s):
        _btnAbort - the ABORT BUTTON control that was loaded [CONTROL, default: controlNull]
        _config - the control configuration [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
 */

params [
    [Q(_btnAbort), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

{
    uiNamespace setVariable _x;
} forEach [
    [QMVAR(_btnAbort), _btnAbort]
    , [QMVAR(_btnAbort_config), _config]
];

true;
