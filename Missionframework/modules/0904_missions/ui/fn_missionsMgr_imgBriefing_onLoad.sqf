#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_missionsMgr_imgBriefing_onLoad

    File: fn_missionsMgr_imgBriefing_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the BRIEFING IMAGE opens, 'onLoad'. Really, this is a kind of TEXT
        CONTROL, we must set in terms of a STRUCTURED TEXT.

    Parameter(s):
        _imgBriefing - the BRIEFING IMAGE control opened [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/createDialog
 */

params [
    [Q(_imgBriefing), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

{
    uiNamespace setVariable _x;
} forEach [
    [QMVAR(_imgBriefing), _imgBriefing]
    , [QMVAR(_imgBriefing_config), _config]
];

true;
