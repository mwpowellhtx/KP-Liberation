/*
    KPLIB_fnc_logisticsSM_onLogisticsMgrClosed

    File: fn_logisticsSM_onLogisticsMgrClosed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 09:32:54
    Last Update: 2021-02-28 09:32:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Logistics Manager dialog closed by the client.

    Parameters:
        _cid - the 'clientOwner' which closed his dialog [SCALAR, default: -1]

    Returns:
        Whether the announcement was valid and received [BOOL]
 */

private _debug = [
    [
        {KPLIB_logisticsSM_onLogisticsMgrClosed_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_logisticsSM_onLogisticsMgrClosed] Entering: [_cid]: %1"
        , str [_cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: and perhaps do some logging...
if (_cid < 0) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsSM_onLogisticsMgrClosed] Invalid client identifier: [_cid]: %1"
            , str [_cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _cids = KPLIB_logisticsSM_namespace getVariable ["KPLIB_logistics_cids", []];

private _cidCount = count _cids;

private _cidsToRemove = _cids select { _x == _cid; };

_cids = _cids - _cidsToRemove;

KPLIB_logisticsSM_namespace setVariable ["KPLIB_logistics_cids", _cids];

private _retval = _cidCount > count _cids;

if (_debug) then {
    [format ["[fn_logisticsSM_onLogisticsMgrClosed] Fini: [_cid, _cidCount, count _cids]: %1"
        , str [_cid, _cidCount, count _cids]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

_retval;
