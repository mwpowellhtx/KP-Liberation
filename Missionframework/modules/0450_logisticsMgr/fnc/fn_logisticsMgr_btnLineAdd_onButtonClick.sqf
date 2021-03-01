/*
    KPLIB_fnc_logisticsMgr_btnLineAdd_onButtonClick

    File: fn_logisticsMgr_btnLineAdd_onButtonClick.sqf
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
        {KPLIB_logisticsMgr_btnLineAdd_onButtonClick_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_btnLineAdd", controlNull, [controlNull]]
];

if (_debug) then {
    ["[fn_logisticsMgr_btnLineAdd_onButtonClick] Entering...", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

// Not removing anything, only adding, UUID subs happen server side, triggered by any placeholder...
private _lineUuidPlaceholder = "";

private _args = [[_lineUuidPlaceholder], [], clientOwner];
//      _toAdd:   ^^^^^^^^^^^^^^^^^^^^

["KPLIB_logisticsSM_requestLineChange", _args] call CBA_fnc_serverEvent;

if (_debug) then {
    [format ["[fn_logisticsMgr_btnLineAdd_onButtonClick] Fini: [_args]: %1"
        , str [_args]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
