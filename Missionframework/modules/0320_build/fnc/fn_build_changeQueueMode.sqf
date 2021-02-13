#include "script_components.hpp"
#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_build_changeQueueMode

    File: fn_build_changeQueueMode.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-29
    Last Update: 2021-01-26 12:57:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Changes build system queue mode.

    Parameter(s):
        _control - Clicked control [CONTROL, defaults to controlNull]

    Returns:
        Queue mode was changed [BOOL]
*/
params [
    ["_control", controlNull, [controlNull]]
];

private _display = ctrlParent _control;
private _confirmBtnControl = _display displayCtrl KPLIB_IDC_BUILD_CONFIRM;
private _buildList = _display displayCtrl KPLIB_IDC_BUILD_ITEM_LIST;

// TODO: TBD: preserve and restore current build queue
switch (LGVAR_D(buildMode, KPLIB_build_buildMode_move)) do {
    case KPLIB_build_buildMode_move: {
        _control ctrlSetText localize "STR_KPLIB_DIALOG_BUILD_MODE_MOVE";
        LSVAR("buildMode", KPLIB_build_buildMode_build);
        LSVAR("buildItem", []);
        _confirmBtnControl ctrlEnable false;
        _buildList ctrlEnable false;

        private _markerName = [] call KPLIB_fnc_common_getPlayerFob;
        // TODO: TBD: yes, so we need another event loop that watches persistence objects relative to FOBs...
        private _movableItems = (KPLIB_persistence_objects select {([_x] call KPLIB_fnc_common_getPlayerFob) isEqualTo _markerName}) select {!isNull _x};
        LSVAR("buildQueue_buy", _currentItems);
        LSVAR("buildQueue", _movableItems);
    };

    case KPLIB_build_buildMode_build: {
        _control ctrlSetText localize "STR_KPLIB_DIALOG_BUILD_MODE_BUILD";
        LSVAR("buildMode", KPLIB_build_buildMode_move);
        _confirmBtnControl ctrlEnable true;
        _buildList ctrlEnable true;

        private _buyableItems = LGVAR(buildQueue_buy);
        LSVAR("buildQueue_buy", nil);

        LSVAR("buildQueue", _buyableItems);
    };
};

true
