/*
    KPLIB_fnc_logisticsMgr_lnbConvoy_onLoad

    File: fn_logisticsMgr_lnbConvoy_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 09:57:10
    Last Update: 2021-02-28 09:57:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Responds to the CONVOY LISTNBOX 'onLoad' event.

    Parameters:
        _lnbConvoy - the logistics convoy LISTNBOX control [CONTROL, default: controlNull]
        _config - the config [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/lnbAddRow
        https://community.bistudio.com/wiki/lnbSetPicture
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
 */

params [
    ["_lnbConvoy", controlNull, [controlNull]]
    , ["_config", configNull, [configNull]]
];

// TODO: TBD: and perhaps some logging...
if (!([_lnbConvoy] call KPLIB_fnc_logisticsMgr_lnbConvoy_onClear)) exitWith {
    false;
};

// Which will have been relayed indirectly to the client by the server via selected 'KPLIB_logisticsMgr_lnbLines' ...
private _convoy = _lnbConvoy getVariable ["KPLIB_logisticsMgr_convoy", []];

private _numberPlaceholder = "";

private _onAddConvoyTransport = {

    private _transportValue = _x;
    // Remember LNBSIZE is [_row, _col]
    private _transportNumber = str ((lnbSize _lnbConvoy)#0);
    //                              ^^^^^^^^^^^^^^^^^^^^^^
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

    _rowIndex >= 0;
};

private _added = _convoy select _onAddConvoyTransport;

count _added == count _convoy;
