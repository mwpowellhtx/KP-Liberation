/*
    KPLIB_fnc_persistence_onReconcilePersistenceObjects

    File: fn_persistence_onReconcilePersistenceObjects.sqf
    Author: Michael W. Powell
    Created: 2021-02-15 13:21:49
    Last Update: 2021-02-15 13:21:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Reconciles the '_objects' with the 'KPLIB_persistence_objects'.
        Appends any new ones, and drops any dead ones.

    Parameters:
        _callbackType - overall the callback type invoking the request [STRING, default: ""]
        _objects - the objects being reconciled with the known 'KPLIB_persistence_objects' [ARRAY, default: []]

    Returns:
        The callback completed [BOOL]
 */

private _debug = [] call KPLIB_fnc_persistence_debug;

params [
    ["_callbackType", "", [""]]
    , ["_objects", [], [[]]]
];

private _eligible = _objects select { !isNull _x };

if (_debug) then {

    [format ["[fn_persistence_onReconcilePersistenceObjects] [_callbackType, count _objects, count _eligible]: %1"
        , str [_callbackType, count _objects, count _eligible]], "PERSISTENCE"] call KPLIB_fnc_common_log;

    [format ["[fn_persistence_onReconcilePersistenceObjects] [_callbackType, _eligible apply {[alive _x, typeOf _x]}]: %1"
        , str [_callbackType, _eligible apply {[alive _x, typeOf _x]}]], "PERSISTENCE"] call KPLIB_fnc_common_log;

};

// TODO: TBD: before we actually mutate the array, let's verify that we would via the callbacks...
{
    [_x] call KPLIB_fnc_persistence_makePersistent;
} forEach _eligible;

true;
