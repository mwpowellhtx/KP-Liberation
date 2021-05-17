#include "script_component.hpp"
/*
    KPLIB_fnc_hud_onReconcileOverlayMap

    File: fn_hud_onReconcileOverlayMap.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Reconciles the OVERLAP HASHMAP with an incoming DISPATCH STATUS REPORT.
        Removes keys that were not in the current report, adds or updates keys
        that were included in the incoming report.

    Parameters:
        _player - player for whom reconciliation shall occur [OBJECT, default: objNull]
        _dispatchStatus - the DISPATCH STATUS bitmask flags [SCALAR, default: MSTATUS(_standby)]
        _dispatchReport - the DISPATCH REPORT key value pair array [ARRAY, default: []]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/createHashMapFromArray
        https://community.bistudio.com/wiki/deleteAt
        https://community.bistudio.com/wiki/keys
        https://community.bistudio.com/wiki/allVariables
 */

private _debug = [
    [
        {MPARAM(_onReconcileOverlayMap_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_dispatchStatus), MSTATUS(_standby), [0]]
    , [Q(_dispatchReport), [], [[]]]
];

if (_debug) then {
    [format ["[fn_hud_onReconcileOverlapMap] Entering: [isNull _player, _dispatchStatus, count _dispatchReport]: %1"
        , str [isNull _player, _dispatchStatus, count _dispatchReport]], "HUD", true] call KPLIB_fnc_common_log;
};

[
    // Mimics allVariables response, i.e. toLower
    _dispatchReport apply { toLower (_x#0); }
] params [
    Q(_dispatchKeys)
];

if (_debug) then {
    [format ["[fn_hud_onReconcileOverlapMap] Dispatch keys: [_dispatchStatus, count _dispatchKeys, _dispatchKeys]: %1"
        , str [_dispatchStatus, count _dispatchKeys, _dispatchKeys]], "HUD", true] call KPLIB_fnc_common_log;
};

// Just reconcile the STATUS itself
uiNamespace setVariable [QMVAR(_overlayStatus), _dispatchStatus];

// Create a new HASHMAP capturing the DISPATCH REPORT when necessary
private _overlayMap = if (toLower QMVAR(_overlayMap) in allVariables uiNamespace) then {
    uiNamespace getVariable QMVAR(_overlayMap);
} else {
    private _newOverlayMap = createHashMapFromArray _dispatchReport;
    uiNamespace setVariable [QMVAR(_overlayMap), _newOverlayMap];
    _newOverlayMap;
};

if (_debug) then {
    [format ["[fn_hud_onReconcileOverlapMap] Overlay map: [count _overlayMap, _overlayMap]: %1"
        , str [count _overlayMap, _overlayMap]], "HUD", true] call KPLIB_fnc_common_log;
};

private _overlayKeys = keys _overlayMap;

private _removed = _overlayKeys select { !(toLower _x in _dispatchKeys); } apply { _overlayMap deleteAt _x; };
// Remove existing HASHMAP keys ...                                                ^^^^^^^^^^^^^^^^^^^^^^^
// ... not in DISPATCH REPORT            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

if (_debug) then {
    [format ["[fn_hud_onReconcileOverlapMap] Removed: [count _removed, _removed]: %1"
        , str [count _removed, _removed]], "HUD", true] call KPLIB_fnc_common_log;
};

// Then SET the DISPATCH REPORT key/value pairs
{ _overlayMap set _x; } forEach _dispatchReport;

if (_debug) then {
    ["[fn_hud_onReconcileOverlapMap] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
