#include "defines.hpp"
/*
    KPLIB_fnc_productionMgr_onProductionStatePublished

    File: fn_productionMgr_onProductionStatePublished.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-11 09:13:11
    Last Update: 2021-02-21 11:12:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Client module 'onProductionElemResponse' event handler, responds to the
        'KPLIB_productionMgr_onProductionElemResponse' CBA owner event.

    Parameter(s):
        _productionState - _this, corresponds with the production state that got
            updated in response to a server request [ARRAY, default: []]

    Returns:
        Event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
 */

private _debug = [
    [
        {KPLIB_param_productionMgr_lnbSectors_debug}
        , {KPLIB_param_productionMgr_onProductionStatePublished_debug}
    ]
] call KPLIB_fnc_productionMgr_debug;

params [
    ["_productionState", [], [[]]]
];

if (_debug) then {
    ["[fn_productionMgr_onProductionStatePublished] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: so... this is an ALL OR NOTHING proposition... if ANY are invalid then ALL are invalid...
if (({ !([_x] call KPLIB_fnc_production_verifyArray); } count _productionState) > 0) exitWith {
    if (_debug) then {
        ["[fn_productionMgr_onProductionStatePublished] Invalid production state", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

if (_debug) then {
    [format ["[fn_productionMgr_onProductionStatePublished] Setting display production state: %1 factories"
        , count _productionState], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

// Just replace the known '_productionState' and be done with it
_display setVariable ["_productionState", _productionState];

// TODO: TBD: might introduce the "reload" bits here as well...
// TODO: TBD: do we need to inject any config? i.e. 
[_display displayCtrl KPLIB_IDC_PRODUCTIONMGR_LNBSECTORS] call KPLIB_fnc_productionMgr_lnbSectors_onLoad;

if (_debug) then {
    ["[fn_productionMgr_onProductionStatePublished] Finished", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
