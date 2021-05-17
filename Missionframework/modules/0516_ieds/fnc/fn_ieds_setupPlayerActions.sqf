#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_ieds_setupPlayerActions

    File: fn_ieds_setupPlayerActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-06 23:11:35
    Last Update: 2021-05-07 11:58:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets up player action menu items.

    Parameter(s):
        _player - the PLAYER object for whom menus are being arranged [OBJECT, default: player]

    Returns:
        The callback has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/addAction
 */

private _debug = MPARAM(_setupPlayerActions_debug);

params [
    [Q(_player), player, [objNull]]
];

if (hasInterface) then {
    ["[fn_ieds_setupPlayerActions] Entering...", "IEDS", true] call KPLIB_fnc_common_log;
};

if (hasInterface) then {
    // Player section

    [_player, Q(STR_KPLIB_RESOURCES_ACTION_DISARM_IED), [
        { _this call MFUNC(_onDisarm); }
        , []
        , KPLIB_ACTION_PRIORITY_DISARM_IED
        , true
        , true
        , ""
        , "_this call KPLIB_fnc_ieds_canDisarm"
        , -1
    ], "#ff9900"] call KPLIB_fnc_common_addAction;
};

if (hasInterface) then {
    ["[fn_ieds_setupPlayerActions] Fini", "IEDS", true] call KPLIB_fnc_common_log;
};

true;
