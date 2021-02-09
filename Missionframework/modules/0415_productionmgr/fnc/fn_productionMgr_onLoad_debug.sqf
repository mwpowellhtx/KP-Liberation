#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_onLoad_debug

    File: fn_productionMgr_onLoad_debug.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-09 14:11:36
    Last Update: 2021-02-09 14:11:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        ...

    Parameter(s):
        _ctrl
        _config

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
*/

params [
    ["_ctrl", controlNull, [controlNull]]
    , "_config"
];

[format ["[fn_productionMgr_onLoad_debug] [ctrlClassName, text, x, y, w, h]: %1"
    , str [
        ctrlClassName _ctrl
        , getText (_config >> "text")
        , getNumber (_config >> "x")
        , getNumber (_config >> "y")
        , getNumber (_config >> "w")
        , getNumber (_config >> "h")
    ]
], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;

// TODO: TBD: ...
