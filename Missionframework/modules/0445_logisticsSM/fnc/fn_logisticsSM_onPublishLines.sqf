/*
    KPLIB_fnc_logisticsSM_onPublishLines

    File: fn_logisticsSM_onPublishLines.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 16:48:59
    Last Update: 2021-02-28 16:49:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Posts the CBA logistics namespaces converted to tuple form to the requesting
        client, especially responding to the 'KPLIB_logistics_requestLogistics' server
        side event.

    Parameters:
        _cid - the 'clientOwner' announced to the server [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_ownerEvent-sqf.html
 */

private _debug = [
    [
        {KPLIB_logisticsSM_onPublishLines_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_logisticsSM_onPublishLines] Entering: [_cid]: %1"
        , str [_cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: and perhaps do some logging...
if (_cid < 0) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsSM_onPublishLines] Invalid client identifier: [_cid]: %1"
            , str [_cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _lines = KPLIB_logistics_namespaces apply {
    private _namespace = _x;
    // We are 'there', publication shall not be required, for awhile anyway...
    [_namespace] call KPLIB_fnc_logisticsSM_clearPublicationRequired;
    [_namespace] call KPLIB_fnc_logistics_namespaceToArray;
};

["KPLIB_logisticsMgr_onLinesPublished", [_lines], _cid] call CBA_fnc_ownerEvent;

if (_debug) then {
    [format ["[fn_logisticsSM_onPublishLines] Fini: [_cid]: %1"
        , str [_cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
