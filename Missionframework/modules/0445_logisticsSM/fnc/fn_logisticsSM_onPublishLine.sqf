/*
    KPLIB_fnc_logisticsSM_onPublishLine

    File: fn_logisticsSM_onPublishLine.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 11:10:43
    Last Update: 2021-03-04 11:10:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Posts the CBA logistics namespace converted to tuple form to the requesting
        client, most typically during logistics state machine normal operations.

    Parameters:
        _namespace - the CBA logistics namespace being published [LOCATION, default: locationNull]
        _cid - the 'clientOwner' announced to the server [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_ownerEvent-sqf.html
 */

private _debug = [
    [
        {KPLIB_param_logisticsSM_onPublishLine_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_logisticsSM_onPublishLine] Entering: [_cid]: %1"
        , str [_cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: and perhaps do some logging...
if (_cid < 0) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsSM_onPublishLine] Invalid client identifier: [_cid]: %1"
            , str [_cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _line = [_namespace] call KPLIB_fnc_logistics_namespaceToArray;

// TODO: TBD: client side manager code will require an additional 'single' line published event handler...
["KPLIB_logisticsMgr_onLinePublished", [_lines], _cid] call CBA_fnc_ownerEvent;

if (_debug) then {
    [format ["[fn_logisticsSM_onPublishLine] Fini: [_cid, _line]: %1"
        , str [_cid, _line]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
