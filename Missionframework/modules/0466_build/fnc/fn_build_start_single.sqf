#include "script_components.hpp"
#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_build_start_single

    File: fn_build_start_single.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-09-09
    Last Update: 2021-05-17 20:34:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Starts the building mode

    Parameter(s):
        _center - Center of building area [POSITION, default: position player]
        _radius - Allowed building radius [NUMBER, default: KPLIB_param_fobs_range]

    Returns:
        Building logic object [LOCATION]

    References:
        https://community.bistudio.com/wiki/remoteExec
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandlerArgs-sqf.html
*/

params [
    ["_center", position player, [[]], 3]
    , ["_radius", KPLIB_param_fobs_range, [0]]
    , ["_buildItem", [], [[]], 4]
    , ["_onConfirm", {}, [{}]]
];

if (!(_buildItem isEqualTypeParams KPLIB_build_buildItemTemplate)) exitWith {
    [format ["[fn_build_start_single] Incorrect build item: '%1'!", str _buildItem], "BUILD"] call KPLIB_fnc_common_log
};

private _onOpenBuildDisplay = {
    params [
        ["_display", displayNull, [displayNull]]
    ];

    private _onReposBuildButtonControl = {
        _this apply { _display displayCtrl _x; } params [
            ["_ctrl", controlNull, [controlNull]]
            , ["_referenceCtrl", controlNull, [controlNull]]
        ];
        // Obtain the coordinates of the reference control...
        private _newCtrlPos = (ctrlPosition _referenceCtrl);
        // Save only X, Y
        _newCtrlPos resize 2;
        // Get original W, H
        _newCtrlPos append ((ctrlPosition _ctrl) select [2, 2]);
        // Set the position with original W, H
        _ctrl ctrlSetPosition _newCtrlPos;
        _ctrl ctrlCommit 0;
    };

    // Yes we still want to reposition the button, but we want to align it with the search controls instead...
    [KPLIB_IDC_BUILD_BTNBUILD, KPLIB_IDC_BUILD_CATEGORY_LIST] call _onReposBuildButtonControl;

    // Hide tabs, build list and background
    {
        (_display displayCtrl _x) ctrlShow false;
    } forEach KPLIB_BUILD_TABS_IDCS_ARRAY;

    // "_thisArgs" not to be confused with the params above
    LSVAR("buildItem", _thisArgs);
};

private _onLocalBuildItemBuilt = {
    _this call _thisArgs;
    [] call KPLIB_fnc_build_stop;
};

private _onStopBuild = {
    [_thisType, _thisId] call CBA_fnc_removeEventHandler;

    // Clear the marker(s) from the player
    KPLIB_build_player setVariable ["KPLIB_core_repackageFobMarker", nil, true];
    KPLIB_build_player = nil;

    _thisArgs params ["_openEhId", "_builtEhId"];

    ["KPLIB_build_display_open", _openEhId] call CBA_fnc_removeEventHandler;
    ["KPLIB_build_item_built_local", _builtEhId] call CBA_fnc_removeEventHandler;

    // TODO: TBD: may see about doing this one conditionally...
    // TODO: TBD: i.e. only if anything changed during build... i.e. was built, moved, etc...
    [] spawn {
        ["fn_build_start_single"] remoteExec ["KPLIB_fnc_init_save", 2];
    };
};

// Handle item placement
private _openEhId = ["KPLIB_build_display_open", _onOpenBuildDisplay, _buildItem] call CBA_fnc_addEventHandlerArgs;
private _builtEhId = ["KPLIB_build_item_built_local", _onLocalBuildItemBuilt, _onConfirm] call CBA_fnc_addEventHandlerArgs;

// Stop all single build event handlers, handles event handler tear down
["KPLIB_build_stop", _onStopBuild, [_openEhId, _builtEhId]] call CBA_fnc_addEventHandlerArgs;

// Start build mode
[_center, _radius] call KPLIB_fnc_build_start;
