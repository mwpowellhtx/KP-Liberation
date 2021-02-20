#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_onProductionElemPublished

    File: fn_productionMgr_onProductionElemPublished.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-11 09:13:11
    Last Update: 2021-02-20 12:15:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Client module 'onProductionElemResponse' event handler, responds to the
        'KPLIB_productionMgr_onProductionElemResponse' CBA owner event.

    Parameter(s):
        _productionElem - _this, corresponds with the production element that
            got updated in response to a server request [ARRAY, default: []]

    Returns:
        Event handler finished [BOOL]

    References:
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

params [
    ["_productionElem", [], [[]]]
];

if (_debug) then {
    ["[fn_productionMgr_onProductionElemPublished] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

if (!([_productionElem] call KPLIB_fnc_production_verifyArray)) exitWith {
    if (_debug) then {
        ["[fn_productionMgr_onProductionElemPublished] Invalid production element", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _production = _display getVariable ["_production", []];

private _elemIndex = _production findIf { (_x#0#0) isEqualTo (_productionElem#0#0); };

if (_elemIndex >= 0) then {
    _production set [_elemIndex, _productionElem];
} else {
    // TODO: TBD: ordering here might be enough...
    // TODO: TBD: or we allow the LNB itself to do the ordering for us...
    // TODO: TBD: which as long as we end up looking up anything by marker name, then maybe that's okay...
    _production pushBackUnique _productionElem;
    _production = [
        _production
        , []
        , {
            private _pos = markerPos (_x#0#0);
            //          _markerName:  ^^^^^^
            private _ref = mapGridPosition _pos;
            parseNumber _ref;
        }
    ] call BIS_fnc_sortBy;
};

_display setVariable ["_production", (+_production)];

// TODO: TBD: may want to coordinate with current selections...
// TODO: TBD: do we need to inject any config? i.e. https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
[_lnbSectors] spawn KPLIB_fnc_productionMgr_lnbSectors_onLoad;

if (_debug) then {
    ["[fn_productionMgr_onProductionElemPublished] Finished", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
