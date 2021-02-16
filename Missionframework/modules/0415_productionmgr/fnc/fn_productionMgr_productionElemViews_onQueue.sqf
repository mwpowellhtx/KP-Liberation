/*
    KPLIB_fnc_productionMgr_productionElemViews_onQueue

    File: fn_productionMgr_productionElemViews_onQueue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 14:59:46
    Last Update: 2021-02-10 14:59:49
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

[
    (_productionElem#0#0)
    , (_productionElem#2#2)
] params [
    "_markerName"
    , "_queue"
];

private _view = _queue apply {
    private _resourceIndex = _x;
    private _viewData = [
        "" // Leaving room for the image
        , toUpper localize (KPLIB_resources_capabilityKeys select _resourceIndex)
    ];
    [_viewData, _resourceIndex];
    //          ^^^^^^^^^^^^^^ which is the true value of the data behind the row
};

_view;
