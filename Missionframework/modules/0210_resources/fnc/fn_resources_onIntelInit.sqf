#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_resources_onIntelInit

    File: fn_resources_onIntelInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 18:55:49
    Last Update: 2021-04-26 18:55:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Adds ability to GATHER INTEL resource from the target object.

    Parameter(s):
        _target - the TARGET object for which INTEL may be gathered [OBJECT, default: objNull]

    Returns:
        The event handler completed [BOOL]

    References:
        https://community.bistudio.com/wiki/addAction
        https://www.w3schools.com/colors/colors_picker.asp
 */

params [
    [Q(_target), objNull, [objNull]]
];

private _targetClassName = typeOf _target;

if (_targetClassName in MPRESET(_intelClassNames)) then {

    _target setVariable [QMVAR(_intel), [_targetClassName] call MFUNC(_getIntelValue)];

    // TODO: TBD: should consider issuing this on player machine...
    // TODO: TBD: why because of localize...
    [] call {

        // TARGET is the INTEL object, THIS is the player
        private _condition = "
            alive _target
                && alive _this
                && _this isEqualTo vehicle _this
        ";

        // TODO: TBD: may localize this to string table...
        // TODO: TBD: may also capture colors a bit differently...
        [_target, "STR_KPLIB_RESOURCES_ACTION_GATHER_INTEL", [
            { _this call MFUNC(_onGatherIntel); }
            , []
            , KPLIB_ACTION_PRIORITY_GATHER_INTEL
            , true
            , true
            , ""
            , _condition
            , MPARAM(_gatherIntelRange)
        ], "#cccc33"] call KPLIB_fnc_common_addAction;
    };
};

true;
