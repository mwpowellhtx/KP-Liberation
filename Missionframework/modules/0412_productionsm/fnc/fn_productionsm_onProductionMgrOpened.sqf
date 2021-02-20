/*
    KPLIB_fnc_productionsm_onProductionMgrOpened

    File: fn_productionsm_onProductionMgrOpened.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 20:02:58
    Last Update: 2021-02-18 20:03:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Server module 'onDialogClosed' event handler, responds when the client closes the
        dialog. Which effectively takes the client out of any further notification loops.

    Parameter(s):
        _cid - the clientOwner, A.K.A. '_clientIdentifier', A.K.A. '_cid' for short [SCALAR, default: -1]

    Returns:
        NONE
*/

private _debug = [] call KPLIB_fnc_productionsm_debug;

params [
    ["_cid", -1, [0]]
    , ["_forced", false, [false]]
];

if (_debug) then {
    [format ["[fn_productionsm_onProductionMgrOpened] Entering: [_cid, _forced]: %1"
        , str [_cid, _forced]], "PRODUCTION", true] call KPLIB_fnc_common_log;
};

if (_cid <= 0) exitWith {};

/* Must do this for each known production namespace. This is because the statemachine event
 * loop runs per production namespace, including new or existing publish notifications. */

{
    private _namespace = _x;

    if (_forced) then {
        private _forcedCids = _namespace getVariable ["_forcedCids", []];
        _forcedCids pushBackUnique _cid;
        _namespace setVariable ["_forcedCids", _forcedCids];
    };

    private _cids = _namespace getVariable ["_cids", []];
    _namespace setVariable ["_previousCids", (+_cids)];

    _cids pushBackUnique _cid;
    _namespace setVariable ["_cids", _cids];

    // Local event assuming this callback was invoked server side.
    ["KPLIB_productionsm_onPublishProductionElem", [_namespace]] call CBA_fnc_localEvent;

} forEach KPLIB_production_namespaces;

if (_debug) then {
    [format ["[fn_productionsm_onProductionMgrOpened] Finished: [_cid]: %1"
        , str [_cid]], "PRODUCTION", true] call KPLIB_fnc_common_log;
};
