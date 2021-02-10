#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_onLoad

    File: fn_productionMgr_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-06 12:56:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module display onLoad event handler.

    Parameter(s):
        _display - the display [DISPLAY]

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
*/

params [
    ["_display", displayNull, [displayNull]]
];

// TODO: TBD: perchance to notification_system ...
systemChat "fn_productionMgr_onLoad";
//["fn_productionMgr_onLoad"] call KPLIB_fnc_notification_hit;

// TODO: TBD: ...

// Used to identify the actual storage location
createMarkerLocal ["_productionMgrStorage", KPLIB_zeroPos];
