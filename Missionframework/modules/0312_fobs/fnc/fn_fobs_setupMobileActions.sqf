#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_fobs_setupDeployActions

    File: fn_fobs_setupDeployActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-18 17:57:14
    Last Update: 2021-05-25 10:50:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Attaches DEPLOY actions to the VEHICLE object.

    Parameter(s):
        _vehicle - a VEHICLE object for which DEPLOY actions are to be added
            [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_vehicle), objNull, [objNull]]
];

// TODO: TBD: this one needs sorting out as well... big time...

////// TODO: TBD: "KPLIB_respawn" is already "in use" in a manner of speaking...
////// TODO: TBD: we think it is a bad idea to confuse terminology, usage, when it should be a "class CfgRespawnTemplates {...}" member.
//// Set vehicle as mobile respawn
//_vehicle setVariable ["KPLIB_respawn", true, true];

// Handle some additional MR bookkeeping.
//// TODO: TBD: don't think we care about setting a UUID on the object itself any longer...
//_vehicle setVariable ["KPLIB_uuid", [] call KPLIB_fnc_uuid_create_string, true];

//// TODO: TBD: because we are walking away from the notion of "sector type" ...
//_vehicle setVariable ["KPLIB_sectorType", KPLIB_sectorType_mob, true];

// TODO: TBD we need to refactor these bits...

// // Add redeploy action globaly and for JIP
// [
//     // TODO: TBD: was: "_this == vehicle _this"
//     // TODO: TBD: the action condition is very similar to actually "querying" for available mobile respawns we think...
//     // TODO: TBD: max speed 5, setup a parameter (?)
//     // TODO: TBD: max alt, setup a parameter (?)
//     _vehicle
//     , "STR_KPLIB_ACTION_REDEPLOY"
//     , [
//         { ["KPLIB_respawn_requested", _this] call CBA_fnc_localEvent; }
//         , []
//         , KPLIB_ACTION_PRIORITY_REDEPLOY
//         , false
//         , true
//         , ""
//         , "
//             _this isEqualTo vehicle _this
//                 && !([KPLIB_sectors_startbases, { (markerPos _x distance _target) <= KPLIB_param_eden_startbaseRadius; }] call KPLIB_fnc_linq_any)
//                 && !isNull ([_target, KPLIB_param_fobs_range] call KPLIB_fnc_fobs_getNearestBuilding)
//                 && ([_target] call KPLIB_fnc_common_getMomentum) <= 5
//                 && ([_target] call KPLIB_fnc_common_getAltitudeDelta) <= 5
//         "
//         , 10
//     ]
// ] remoteExecCall ["KPLIB_fnc_common_addAction", 0, _vehicle];

// TODO: TBD: refactor in terms of proper CBA settings...
// TODO: TBD: also add overall general perhaps max momentum settings...
// TODO: TBD: also consider general max alt or at least max alt diff...
private _redeployRange = 10;

// TODO: TBD "can redeploy" condition should be more of a function...
// TODO: TBD: and then we should refactor this to respawn... eventually...

// TODO: TBD: rename to KPLIB_fobs_...
[
    _vehicle
    , "STR_KPLIB_ACTION_REDEPLOY"
    , [
        { ["KPLIB_respawn_requested", _this] call CBA_fnc_localEvent; }
        , []
        , KPLIB_ACTION_PRIORITY_REDEPLOY
        , false
        , true
        , ""
        , "
            vehicle _this isEqualTo _this
                && ([_target] call KPLIB_fnc_common_getMomentum) <= 5
                && ([_this, _target] call KPLIB_fnc_common_getAltitudeDelta) <= 5
                && !([KPLIB_sectors_startbases, { (markerPos _x distance _target) <= KPLIB_param_eden_startbaseRadius; }] call KPLIB_fnc_linq_any)
                && ({ (markerPos _x distance _target) <= KPLIB_param_fobs_range; } count KPLIB_sectors_fobs) == 0
        "
        , _redeployRange
    ]
] call KPLIB_fnc_common_addAction;

true;
