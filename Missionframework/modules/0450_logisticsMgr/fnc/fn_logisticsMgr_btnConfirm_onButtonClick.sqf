/*
    KPLIB_fnc_logisticsMgr_btnConfirm_onButtonClick

    File: fn_logisticsMgr_btnConfirm_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 14:05:40
    Last Update: 2021-03-04 14:05:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Confirm mission button 'onButtonClick' event handler.

    Parameters:
        _btnConfirm - the Confirm mission CT_BUTTON [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_serverEvent-sqf.html
 */

params [
    ["_btnConfirm", controlNull, [controlNull]]
];

private _line = uiNamespace getVariable ["KPLIB_logisticsMgr_selectedLine", []];

_line params [
    ["_lineUuid", "", [""]]
];

private _onGetEndpointCbo = { uiNamespace getVariable [_x, controlNull]; };

private _onGetSelectedEndpointArray = {
    // Important that we obtain a copy, different reference, of the source array
    +([_x] call KPLIB_fnc_logisticsMgr_cboEndpoint_getSelectedEndpoint);
};

private _onLiftBillValue = { parseNumber (ctrlText _x) };

private _endpointCbos = ["KPLIB_logisticsMgr_cboAlpha", "KPLIB_logisticsMgr_cboBravo"] apply _onGetEndpointCbo;

private _endpoints = _endpointCbos apply _onGetSelectedEndpointArray;

_endpoints params ["_alpha", "_bravo"];

private _alphaBillValue = KPLIB_logisticsMgr_ctrls_mayConfigureAlpha apply _onLiftBillValue;
private _bravoBillValue = KPLIB_logisticsMgr_ctrls_mayConfigureBravo apply _onLiftBillValue;

_alpha pushBack _alphaBillValue;
_bravo pushBack _bravoBillValue;

// TODO: TBD: lift the bits necessary to fulfill the server event args...
[KPLIB_logisticsCO_requestMissionConfirm, [_lineUuid, [_alpha, _bravo], clientOwner]] call CBA_fnc_serverEvent;

true;
