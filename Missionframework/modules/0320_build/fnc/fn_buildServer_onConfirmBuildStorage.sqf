/*
    KPLIB_fnc_buildServer_onConfirmBuildStorage

    File: fn_buildServer_onConfirmBuildStorage.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-15 11:53:15
    Last Update: 2021-02-15 11:53:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles confirmation of build factory sector storage container request.

    Parameters:
        _storageContainer - the storage container object that was built [OBJECT, default: objNull]
        _markerName - the marker name associated with the build request [STRING, default: ""]

    Returns:
        Confirm build storage completed [BOOL]
 */

private _debug = [] call KPLIB_fnc_build_debug;

// TODO: TBD: could potentially be fitted to support similar scenarios like deploy FOB building, for instance
// TODO: TBD: the factoring needs to be smarter, more general...
// TODO: TBD: ...anything that is case specific should be within the scope of those callbacks, and so on
params [
    ["_storageContainer", objNull, [objNull]]
    , ["_markerName", "", [""]]
];

if (_debug) then {
    [format ["[fn_buildServer_onConfirmBuildStorage] Entering: [isNull _storageContainer, _markerName]: %1"
        , str [isNull _storageContainer, _markerName]], "BUILD"] call KPLIB_fnc_common_log;
};

if (isNull _storageContainer) exitWith {
    ["[fn_buildServer_onConfirmBuildStorage] Unable to build storage container", "BUILD"] call KPLIB_fnc_common_log;
    false;
};

if (_debug) then {
    [format ["[fn_buildServer_onConfirmBuildStorage] [typeOf _storageContainer, getPos _storageContainer, vectorUp _storageContainer, KPLIB_dragPos, KPLIB_dragVectorUp]: %1"
        , str [typeOf _storageContainer, getPos _storageContainer, vectorUp _storageContainer, _storageContainer getVariable ["KPLIB_dragPos", [-1, -1, -1]]
            , _storageContainer getVariable ["KPLIB_dragVectorUp", [-1, -1, -1]]]], "BUILD"] call KPLIB_fnc_common_log;
};

// So that when there are overlapping factory sectors, we do not confuse storage containers
_storageContainer setVariable ["KPLIB_sector_markerName", _markerName, true];

// Emit the built event consistent with other build object sequences
["KPLIB_build_item_built", [_storageContainer, _markerName]] call CBA_fnc_globalEvent;

true;
