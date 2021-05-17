/*
    KPLIB_fnc_productionMgr_productionElemViews_onStatus

    File: fn_productionMgr_productionElemViews_onStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 13:46:44
    Last Update: 2021-02-10 13:46:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a view based on the '_productionElem' tuple.

    Parameter(s):
        _this - the production element tuple [ARRAY, default: []]

    Returns:
        The view based on the '_productionElement' tuple.
*/

private _productionElem = _this;

(_productionElem#1) params [
    ["_duration", KPLIB_timers_disabled, [0]]
];

(_productionElem#2) params [
    ["_cap", [], [[]], 3]
    , ["_totals", [], [[]], 3]
    , ["_queue", [], [[]]]
];

private _onRenderBool = {
    private _selected = KPLIB_productionMgr_boolMap select {
        (_x#0) isEqualTo _this;
    };
    (_selected#0#1);
};

// TODO: TBD: these are enough of functions that they could even potentially be pre-compiled, ready and waiting...
// TODO: TBD: i.e. on render bool, on apply, etc...
private _view = KPLIB_resources_indexes apply {
    private _resourceIndex = _x;

    private _producing = if (_queue isEqualTo []) then {
        false;
    } else {
        /* Both of which:
         * 1. Queue has depth
         * 2. Timer is running
         */
        ((_queue#0) isEqualTo _resourceIndex)
        && (_duration > 0);
    };

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

    // TODO: TBD: all these could potentially be functional CODE, functions of the index _x... or _this, ...
    // TODO: TBD: i.e. given the [_productionElem, _x] for arguments, let's say...
    // TODO: TBD: let's just see how it renders first, then we can get fancier...
    private _total = _totals select _resourceIndex;
    private _viewData = [
        "" // Leaving room for the resource image
        , toUpper localize (KPLIB_resources_capabilityKeys select _resourceIndex)
        , (_cap select _resourceIndex) call _onRenderBool
        , _producing call _onRenderBool
        , str _total
        , str ([_total] call KPLIB_fnc_resources_estimateCrates)
    ];

    [_viewData, _resourceIndex];
    //          ^^^^^^^^^^^^^^ which is the true value of the data behind the row
};

_view;
