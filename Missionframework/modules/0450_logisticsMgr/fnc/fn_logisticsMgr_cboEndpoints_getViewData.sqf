/*
    KPLIB_fnc_logisticsMgr_cboEndpoints_getViewData

    File: fn_logisticsMgr_cboEndpoints_getViewData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-09 09:08:29
    Last Update: 2021-03-09 09:08:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _cboEndpoint - [CONTROL, default: controlNull]

    Returns:
        VIEWDATA: [[ROWTEXT, _data], ...], ROWTEXT: [_col1, _col2, _col3, ...] [BOOL]

    References:
        https://community.bistudio.com/wiki/lbData
 */

private _debug = [
    [
        {KPLIB_param_logisticsMgr_cboEndpoints_getViewData_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_cboEndpoint", controlNull, [controlNull]]    
];

private _viewData = [];

private _size = lbSize _cboEndpoint;

// Lifts the view data, as-is, UNSELECTED rows included
for "_rowIndex" from 0 to (_size - 1) do {
    private _text = _cboEndpoint lbText _rowIndex;
    private _data = _cboEndpoint lbData _rowIndex;
    private _viewDatum = [_text, _data];
    _viewData pushBack _viewDatum;
};

_viewData;
