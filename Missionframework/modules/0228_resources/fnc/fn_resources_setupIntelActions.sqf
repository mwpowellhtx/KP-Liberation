#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_resources_setupIntelActions

    File: fn_resources_setupIntelActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-24 16:12:08
    Last Update: 2021-05-24 16:12:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Adds ability to GATHER INTEL resource from the target OBJECT.

    Parameter(s):
        _object - the target OBJECT for which INTEL may be gathered [OBJECT, default: objNull]

    Returns:
        The callback completed [BOOL]

    References:
        https://community.bistudio.com/wiki/addAction
        https://www.w3schools.com/colors/colors_picker.asp
 */

params [
    [Q(_object), objNull, [objNull]]
];

if (isNull _object) exitWith { false; };

[
    _object
    , [
        "STR_KPLIB_RESOURCES_ACTION_GATHER_INTEL"
        , { _this remoteExec [QMFUNC(_onGatherIntel), 2]; }
        , []
        , KPLIB_ACTION_PRIORITY_GATHER_INTEL
        , true
        , true
        , ""
        , "
            _this isEqualTo vehicle _this
                && alive _this
                && !isNull _target
        "
        , MPARAM(_gatherIntelRange)
    ]
    , [[Q(_color), "#cccc33"]]
] call KPLIB_fnc_common_addAction;

true;
