#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_resources_onIntelInit

    File: fn_resources_onIntelInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 18:55:49
    Last Update: 2021-04-27 16:42:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Adds ability to GATHER INTEL resource from the target OBJECT.

    Parameter(s):
        _object - the target OBJECT for which INTEL may be gathered [OBJECT, default: objNull]

    Returns:
        The event handler completed [BOOL]

    References:
        https://community.bistudio.com/wiki/addAction
        https://www.w3schools.com/colors/colors_picker.asp
 */

params [
    [Q(_object), objNull, [objNull]]
];

if (typeOf _object in MPRESET(_intelMap)) then {

    _object setVariable [QMVAR(_intel), [_object] call MFUNC(_getIntelValue)];

    [_object] remoteExecCall [Q(KPLIB_fnc_resources_setupIntelActions), 0, _object];
};

true;
