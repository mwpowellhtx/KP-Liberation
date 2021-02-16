#include "script_components.hpp"
#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_build_start_single

    File: fn_build_start_single.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-09-09
    Last Update: 2021-02-12 09:00:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Starts the building mode

    Parameter(s):
        _center - Center of building area [POSITION, default: position player]
        _radius - Allowed building radius [NUMBER, default: KPLIB_param_fobRange]

    Returns:
        Building logic object [LOCATION]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandlerArgs-sqf.html
*/

params [
    ["_center", position player, [[]], 3]
    // TODO: TBD: define sensible defaults in the CBA settings...
    , ["_radius", 50, [0]]
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

    private _confirmCtrl = (_display displayCtrl KPLIB_IDC_BUILD_CONFIRM);

    // Get pos of build mode selector
    private _confirmCtrlNewPos = (ctrlPosition ctrlParentControlsGroup (_display displayCtrl KPLIB_IDC_BUILD_TOOLBOX_MODE));
    // Save only X, Y
    _confirmCtrlNewPos resize 2;
    // Get original W, H
    _confirmCtrlNewPos append ((ctrlPosition _confirmCtrl) select [2, 2]);
    // Set the position with original W, H
    _confirmCtrl ctrlSetPosition _confirmCtrlNewPos;
    _confirmCtrl ctrlCommit 0;

    // Hide tabs, build list and background
    {
        (_display displayCtrl _x) ctrlShow false;
    } forEach KPLIB_BUILD_TABS_IDCS_ARRAY + [KPLIB_IDC_BUILD_ITEM_LIST, KPLIB_IDC_BUILD_DIALOG_AREA, KPLIB_IDC_BUILD_TOOLBOX_MODE];

    // "_thisArgs" not to be confused with the params above
    LSVAR("buildItem", _thisArgs);
};

private _onLocalBuildItemBuilt = {
    _this call _thisArgs;
    [] call KPLIB_fnc_build_stop;
};

private _onStopBuild = {
    [_thisType, _thisId] call CBA_fnc_removeEventHandler;

    _thisArgs params ["_openEhId", "_builtEhId"];

    ["KPLIB_build_display_open", _openEhId] call CBA_fnc_removeEventHandler;
    ["KPLIB_build_item_built_local", _builtEhId] call CBA_fnc_removeEventHandler;

};

// Handle item placement
private _openEhId = ["KPLIB_build_display_open", _onOpenBuildDisplay, _buildItem] call CBA_fnc_addEventHandlerArgs;
private _builtEhId = ["KPLIB_build_item_built_local", _onLocalBuildItemBuilt, _onConfirm] call CBA_fnc_addEventHandlerArgs;

// Stop all single build event handlers, handles event handler tear down
["KPLIB_build_stop", _onStopBuild, [_openEhId, _builtEhId]] call CBA_fnc_addEventHandlerArgs;

// Start build mode
[_center, _radius] call KPLIB_fnc_build_start;
