/*
    KPLIB_fnc_productionMgr_btnEnqueue_onButtonClick

    File: fn_productionMgr_btnEnqueue_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 19:17:51
    Last Update: 2021-02-10 19:17:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Apply the pending changes to the server for consideration.

    Parameter(s):
        _ctrl - the button control [CONTROL, default: controlNull, unused]
        _resourceIndex - the resource to enqueue, three values are accepted [SCALAR, default: -1]
            [0] supply
            [1] ammo
            [2] fuel

    Returns:
        The module event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

params [
    ["_ctrl", controlNull, [controlNull]]
    , ["_args", [], [[]]]
];

_args params [
    ["_resourceIndex", -1, [0]]
];

if (_debug) then {
    [format ["[fn_productionMgr_btnEnqueue_onButtonClick] Entering: _args: %1"
        , str _args], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};


if (_debug) then {
    ["[fn_productionMgr_btnEnqueue_onButtonClick] Finished.", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
