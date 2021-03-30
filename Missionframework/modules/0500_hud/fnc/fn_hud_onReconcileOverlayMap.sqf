#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/createHashMapFromArray
// https://community.bistudio.com/wiki/deleteAt
// https://community.bistudio.com/wiki/keys
// https://community.bistudio.com/wiki/allVariables

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
