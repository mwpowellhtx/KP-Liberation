#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_fobs_setupDeployActions

    File: fn_fobs_setupDeployActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-18 17:57:14
    Last Update: 2021-05-24 16:06:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Attaches DEPLOY actions to the vehicle OBJECT.

    Parameter(s):
        _object - a vehicle OBJECT for which DEPLOY actions are to be added
            [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_object), objNull, [objNull]]
];

private _debug = MPARAM(_setupDeployActions_debug)
    || (_object getVariable [QMVAR(_setupDeployActions_debug), false])
    ;

if (_debug) then {
    [format ["[fn_fobs_setupDeployActions] Entering: [isNull _object, typeOf _object]: %1"
        , str [isNull _object, typeOf _object]], "FOBS", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: may refactor to settings...
private _deployRange = 10;

[
    _object
    , [
        "STR_KPLIB_ACTION_FOBS_DEPLOY"
        , { _this call MFUNC(_onDeployRequested); }
        , []
        , KPLIB_ACTION_PRIORITY_FOB_DEPLOY
        , true
        , true
        , ""
        , "[_target, _this] call KPLIB_fnc_fobs_canDeploy"
        , _deployRange
    ]
    , [[Q(_varName), QMVAR(_deployID)]]
] call KPLIB_fnc_common_addAction;

[
    _object
    , [
        "STR_KPLIB_ACTION_FOBS_DEPLOY_RANDOM"
        , { _this call MFUNC(_onDeployRandom); }
        , []
        , KPLIB_ACTION_PRIORITY_FOB_DEPLOY_RANDOM
        , true
        , true
        , ""
        , "[_target, _this, true] call KPLIB_fnc_fobs_canDeploy"
        , _deployRange
    ]
    , [[Q(_color), "#ff0000"], [Q(_varName), QMVAR(_deployRandomID)]]
] call KPLIB_fnc_common_addAction;

if (_debug) then {
    ["[fn_fobs_setupDeployActions] Fini", "FOBS", true] call KPLIB_fnc_common_log;
};

true;
