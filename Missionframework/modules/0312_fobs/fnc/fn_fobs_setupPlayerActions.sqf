#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_fobs_setupPlayerActions

    File: fn_fobs_setupPlayerActions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-28
    Last Update: 2021-05-24 10:07:22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization of actions availible to players. Redeploy occurs following PLAYER
        KIA and/or respawn, of course. It also 'just occurs', PLAYER did not necessarily
        respawn, just 'moved' positions, so we do not want to pile on duplicate menus, so
        we trap for that condition by screening the action ID.

    Parameters:
        _player - the PLAYER who just redeployed [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_addPlayerAction-sqf.html
        https://community.bistudio.com/wiki/addAction
 */

params [
    [Q(_player), player, [objNull]]
];

private _debug = MPARAM(_setupPlayerActions_debug)
    || (_player getVariable [QMVAR(_setupPlayerActions_debug), false])
    ;

if (_debug) then {
    ["[fn_fobs_setupPlayerActions] Entering...", "FOBS", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: these really need to be actions on the building itself, not with each player...
[[
    "STR_KPLIB_ACTION_REDEPLOY"
    , { [Q(KPLIB_respawn_requested), _this] call CBA_fnc_localEvent; }
    , []
    , KPLIB_ACTION_PRIORITY_REDEPLOY
    , false
    , true
    , ""
    , "
        _target isEqualTo vehicle _target
            && _target isEqualTo _originalTarget
            && (_target getVariable ['KPLIB_sectors_markerName', '']) in (KPLIB_sectors_fobs + KPLIB_sectors_startbases);
    "
    , -1
], [["_varName", QMVAR(_redeployID)]]] call KPLIB_fnc_common_addPlayerAction;

// TODO: TBD: refactor these to building targeted action menus...
{
    _x params [
        ["_key", "", [""]]
        , ["_args", [], [[]]]
        , ["_priority", -1, [0]]
        , ["_action", "", [""]]
    ];

    // TODO: TBD: also consider permissions, commander? logistics? build?
    if ((_player getVariable [_action, -1]) < 0) then {
        if (_debug) then {
            [format ["[fn_fobs_setupPlayerActions] Adding PACK: [_key, _args]: %1"
                , str [_key, _args]], "FOBS", true] call KPLIB_fnc_common_log;
        };

        [[
            _key
            , { _this call MFUNC(_onRepackageRequested); }
            , _args
            , _priority
            , false
            , true
            , ""
            , "
                _target isEqualTo vehicle _target
                    && _target isEqualTo _originalTarget
                    && (_target getVariable ['KPLIB_sectors_markerName', '']) in KPLIB_sectors_fobs
            "
            , -1
        ], [["_varName", _action]]] call KPLIB_fnc_common_addPlayerAction;
    };

} forEach [
    [
        "STR_KPLIB_ACTION_FOBS_PACK_BOX"
        , [KPLIB_preset_fobBoxF]
        , KPLIB_ACTION_PRIORITY_FOB_PACK_BOX
        , QMVAR(_packFobBoxID)
    ]
    , [
        "STR_KPLIB_ACTION_FOBS_PACK_TRUCK"
        , [KPLIB_preset_fobTruckF]
        , KPLIB_ACTION_PRIORITY_FOB_PACK_TRUCK
        , QMVAR(_packFobTruckID)
    ]
];

if (_debug) then {
    ["[fn_fobs_setupPlayerActions] Fini", "FOBS", true] call KPLIB_fnc_common_log;
};

true;
