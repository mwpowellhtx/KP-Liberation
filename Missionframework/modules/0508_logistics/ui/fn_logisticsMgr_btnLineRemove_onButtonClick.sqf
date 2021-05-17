/*
    KPLIB_fnc_logisticsMgr_btnLineRemove_onButtonClick

    File: fn_logisticsMgr_btnLineRemove_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 16:59:53
    Last Update: 2021-02-28 16:59:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Line Add button 'onButtonClick' event handler.

    Parameters:
        _btnLineAdd - the Line Add CT_BUTTON [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_serverEvent-sqf.html
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_btnLineRemove_onButtonClick_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

if (_debug) then {
    ["[fn_logisticsMgr_btnLineRemove_onButtonClick] Entering...", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

// Responds to the button using already-cached LINES LISTNBOX control instance...
private _lnbLines = uiNamespace getVariable ["KPLIB_logisticsMgr_lnbLines", controlNull];

private _selectedRow = lnbCurSelRow _lnbLines;

if (_selectedRow >= 0) then {

    private _lineUuid = _lnbLines lnbData [_selectedRow, 0];

    // Nothing to add, just removing...
    private _args = [[], [_lineUuid], clientOwner];
    //        _toRemove:  ^^^^^^^^^

    [KPLIB_logisticsCO_requestAddOrRemoveLines, _args] call CBA_fnc_serverEvent;

    if (_debug) then {
        [format ["[fn_logisticsMgr_btnLineRemove_onButtonClick] Line change requested: [_args]: %1"
            , str [_args]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
    };
};

if (_debug) then {
    ["[fn_logisticsMgr_btnLineRemove_onButtonClick] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
