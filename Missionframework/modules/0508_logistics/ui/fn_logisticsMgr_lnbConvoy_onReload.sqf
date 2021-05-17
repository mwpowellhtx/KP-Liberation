/*
    KPLIB_fnc_logisticsMgr_lnbConvoy_onReload

    File: fn_logisticsMgr_lnbConvoy_onReload.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 09:45:13
    Last Update: 2021-03-01 09:45:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Reloads the content of the CONVOY LISTNBOX, typically responding to 'onLoad' event,
        but also with any change in LINES LISTNBOX selection, client server publication, and
        so forth. Operates entirely from the cached controls from the UI namespace.

    Parameters:
        NONE

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/lnbAddRow
        https://community.bistudio.com/wiki/lnbSetPicture
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_lnbConvoy_onReload_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

private _lnbConvoy = uiNamespace getVariable ["KPLIB_logisticsMgr_lnbConvoy", controlNull];

// Which will have been relayed indirectly to the client by the server via selected 'KPLIB_logisticsMgr_lnbLines' ...
private _convoy = uiNamespace getVariable ["KPLIB_logisticsMgr_convoy", []];

if (_debug) then {
    [format ["[fn_logisticsMgr_lnbConvoy_onReload] Entering: [isNull _lnbConvoy, count _convoy, _convoy]: %1"
        , str [isNull _lnbConvoy, count _convoy, _convoy]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: and perhaps some logging...
if (!([_lnbConvoy] call KPLIB_fnc_logisticsMgr_lnbConvoy_onClear)) exitWith {
    false;
};

private _numberPlaceholder = "";

private _getRowCount = {
    params [
        ["_lnb", _lnbConvoy, [controlNull]]
    ];
    (lnbSize _lnb)#0;
};

private _onAddConvoyTransport = {

    private _transportValue = _x;
    // Remember LNBSIZE is [_row, _col]
    private _transportNumber = str ([] call _getRowCount);
    //                              ^^^^^^^^^^^^^^^^^^^^
    private _renderedTransportValue = _transportValue apply { (_x toFixed 0); };

    private _rowIndex = _lnbConvoy lnbAddRow [
        _transportNumber
        , _numberPlaceholder
        , (_renderedTransportValue#0)
        , _numberPlaceholder
        , (_renderedTransportValue#1)
        , _numberPlaceholder
        , (_renderedTransportValue#2)
    ];

    // Which includes comprehension of the header row
    _rowIndex > 0;
};

private _added = _convoy select _onAddConvoyTransport;

private _retval = count _added == count _convoy;

if (_debug) then {
    ["[fn_logisticsMgr_lnbConvoy_onReload] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

_retval;
