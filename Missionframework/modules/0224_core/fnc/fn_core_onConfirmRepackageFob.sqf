/*
    KPLIB_fnc_core_onConfirmRepackageFob

    File: fn_core_onConfirmRepackageFob.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-12 18:39:24
    Last Update: 2021-03-12 18:39:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles confirmation of FOB repackaging sequence. Uses the marker name in order
        to clean up any previous references to the FOB, arrays, containers, etc.

    Parameters:
        _repackagedObj - the repackaged FOB object that was built [OBJECT, default: objNull]
        _markerName - the marker name associated with the build request [STRING, default: ""]

    Returns:
        Confirm FOB repackaging completed [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_core_onConfirmRepackageFob_debug}
    ]
] call KPLIB_fnc_debug_debug;

// TODO: TBD: could potentially be fitted to support similar scenarios like deploy FOB building, for instance
// TODO: TBD: the factoring needs to be smarter, more general...
// TODO: TBD: ...anything that is case specific should be within the scope of those callbacks, and so on
params [
    ["_repackagedFob", objNull, [objNull]]
    , ["_markerName", "", [""]]
    , ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_core_onConfirmRepackageFob] Entering: [isNull _repackagedFob, _markerName]: %1"
        , str [isNull _repackagedFob, _markerName]], "CORE"] call KPLIB_fnc_common_log;
};

if (isNull _repackagedFob) exitWith {
    ["[fn_core_onConfirmRepackageFob] Unable to build repackaged FOB", "CORE"] call KPLIB_fnc_common_log;
    false;
};

[KPLIB_core_tearDownFob, [_markerName]] call CBA_fnc_serverEvent;

if (_debug) then {
    [format ["[fn_core_onConfirmRepackageFob] [typeOf _repackagedFob, getPos _repackagedFob]: %1"
        , str [typeOf _repackagedFob, getPos _repackagedFob]], "CORE"] call KPLIB_fnc_common_log;
};

// Emit the built event consistent with other build object sequences
["KPLIB_build_item_built", [_repackagedFob, _markerName]] call CBA_fnc_globalEvent;

true;
