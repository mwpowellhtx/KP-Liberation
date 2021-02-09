#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_ctrlBg_title_onLoad

    File: fn_productionMgr_ctrlBg_title_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-08 17:31:33
    Last Update: 2021-02-08 17:31:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        ...

    Parameter(s):
        _ctrl - the control [CONTROL]
        _config

    Returns:
        NONE

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
*/

// TODO: TBD: can we know this from the control itself?
params [
    ["_ctrl", controlNull, [controlNull]]
    , "_config"
];

systemChat format ["[fn_productionMgr_ctrlBg_title_onLoad] [ctrlClassName, x, y, w, h]: %1"
    , str [
        ctrlClassName _ctrl
        , getNumber (_config >> "x")
        , getNumber (_config >> "y")
        , getNumber (_config >> "w")
        , getNumber (_config >> "h")
    ]
];
