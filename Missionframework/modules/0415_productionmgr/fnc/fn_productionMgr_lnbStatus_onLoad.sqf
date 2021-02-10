#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_lnbStatus_onLoad

    File: fn_productionMgr_lnbStatus_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-06 12:56:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module status list box onLoad event handler.

    Parameter(s):
        _lnbStatus - the list box control [CONTROL]

    Returns:
        Module event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/lnbAddRow
        https://community.bistudio.com/wiki/lnbSetPicture
        https://community.bistudio.com/wiki/lnbSetValue
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

params [
    ["_lnbStatus", controlNull, [controlNull]]
];

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _markerName = [_lnbStatus] call KPLIB_fnc_productionMgr_getSelectedMarkerName;

private _productionElem = [_lnbStatus, _markerName] call KPLIB_fnc_productionMgr_getProductionElement;

if (_debug) then {
    [format ["[fn_productionMgr_lnbStatus_onLoad] [_markerName, _productionElem]: %1", str [_markerName, _productionElem]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

lnbClear _lnbStatus;

// TODO: TBD: should be refactored on load of the overall dialog... and tucked away as a variable...

private _columns = ["_resource", "_capability", "_producing", "_total", "_crates"];
private _onRenderColumn = { toUpper (_x splitString "" select [1, count _x - 1] joinString ""); };

private _headerIndex = _lnbStatus lnbAddRow ([""] + (_columns apply _onRenderColumn));

// Show at least the header row
_lnbStatus lnbSetValue [[_headerIndex, 0], -1];

if (_productionElem isEqualTo []) exitWith {
    true;
};

private _onRenderBool = {
    private _selected = KPLIB_productionMgr_boolMap select {
        (_x#0) isEqualTo _this;
    };
    (_selected#0#1);
};

// TODO: TBD: these are enough of functions that they could even potentially be pre-compiled, ready and waiting...
// TODO: TBD: i.e. on render bool, on apply, etc...
private _elemData = KPLIB_productionMgr_resourceIndexes apply {
    private _resourceIndex = _x;
    private _status = (_productionElem#2);

    /*
        _row: [
            _img (blank: replaced by picture)
            , _label
            , _cap
            , _prod
            , _total
            , _crates
        ]
     */
    (_status) params [
        ["_cap", [], [[]], 3]
        , ["_totals", [], [[]], 3]
        , ["_queue", [], [[]]]
    ];

    private _enqueued = if (_queue isEqualTo []) then {
        false;
    } else {
        (_queue#0) isEqualTo _resourceIndex;
    };

    // TODO: TBD: all these could potentially be functional CODE, functions of the index _x... or _this, ...
    // TODO: TBD: i.e. given the [_productionElem, _x] for arguments, let's say...
    // TODO: TBD: let's just see how it renders first, then we can get fancier...
    private _total = _totals select _resourceIndex;
    private _row = [
        ""
        , toUpper localize (KPLIB_productionMgr_capabilityKeys select _resourceIndex)
        , (_cap select _resourceIndex) call _onRenderBool
        , _enqueued call _onRenderBool
        , str _total
        , str ([_total] call KPLIB_fnc_resources_estimateCrates)
    ];

    [_row, _resourceIndex];
};

{
    private _rowIndex = _lnbStatus lnbAddRow (_x#0);
    private _resourceIndex = (_x#1);

    private _key = [_rowIndex, 0];

    _lnbStatus lnbSetPicture [_key, (KPLIB_productionMgr_resourceImages select _resourceIndex)];

    // For use when coordinating production resource management
    _lnbStatus lnbSetValue [_key, _resourceIndex];

} forEach _elemData;

true;
