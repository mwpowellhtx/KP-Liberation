/*
    KPLIB_fnc_logisticsSM_onLogisticsMgrOpened

    File: fn_logisticsSM_onLogisticsMgrOpened.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 09:32:54
    Last Update: 2021-02-28 09:32:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Client Logistics Manager dialog announced to the server.

    Parameters:
        _cid - the 'clientOwner' announced to the server [SCALAR, default: -1]

    Returns:
        Whether the announcement was valid and received [BOOL]
 */

private _debug = [
    [
        {KPLIB_logisticsSM_onLogisticsMgrOpened_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_logisticsSM_onLogisticsMgrOpened] Entering: [_cid]: %1"
        , str [_cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: and perhaps do some logging...
if (_cid < 0) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsSM_onLogisticsMgrOpened] Invalid client identifier: [_cid]: %1"
            , str [_cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _cids = KPLIB_logisticsSM_namespace getVariable ["KPLIB_logistics_cids", []];

private _cidCount = count _cids;

private _cidsToAdd = [_cid];

_cidsToAdd select {
    _cids pushBackUnique _x;
    true;
};

// The only thing we want to be doing here is cataloging the '_cid' itself
KPLIB_logisticsSM_namespace setVariable ["KPLIB_logistics_cids", _cids];

// This is because other controls and message sources will request lines to be published
private _retval = count _cids > _cidCount;

if (_debug) then {
    [format ["[fn_logisticsSM_onLogisticsMgrOpened] Fini: [_cid, count _cids, _cidCount]: %1"
        , str [_cid, count _cids, _cidCount]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

_retval;

