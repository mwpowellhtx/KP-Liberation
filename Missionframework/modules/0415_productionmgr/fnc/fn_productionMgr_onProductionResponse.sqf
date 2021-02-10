#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_onProductionResponse

    File: fn_productionMgr_onProductionResponse.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-09 21:06:42
    Last Update: 2021-02-09 21:06:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _display
        _args - [_production]

    Returns:
        Module event handler finished [BOOL]
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_onProductionResponse] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

params [
    ["_display", displayNull, [displayNull]]
    , ["_args", [], [[]]]
];

_args params [
    ["_production", [], [[]]]
];

if (_debug) then {
    [format ["[fn_productionMgr_onProductionResponse] [count _production]: %1"
        , str [count _production]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

_display setVariable ["_production", _production];

[_display displayCtrl KPLIB_IDC_PRODUCTIONMGR_LNBSECTORS] spawn KPLIB_fnc_productionMgr_lnbSectors_onLoad;

true;
