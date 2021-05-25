#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_onDeployRequested

    File: fn_fobs_onDeployRequested.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-12 08:38:56
    Last Update: 2021-05-24 17:57:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        FOB deployment request event handler.

    Parameter(s):
        _boxOrTruck - the SORUCE object of the deployment request [OBJECT, default: objNull]
        _player - the PLAYER making the request [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_boxOrTruck), objNull, [objNull]]
    , [Q(_player), objNull, [objNull]]
];

private _debug = MPARAM(_onDeployRequested_debug)
    || (_boxOrTruck getVariable [QMVAR(_onDeployRequested_debug), false])
    ;

if (_debug) then {
    [format ["[fn_fobs_onDeployRequested] Entering: [_boxOrTruck, getPos _boxOrTruck]: %1"
        , str [_boxOrTruck, getPos _boxOrTruck]], "FOBS", true] call KPLIB_fnc_common_log;
};

// Reserved for cleanup later on during item built events
_player setVariable [QMVAR(_boxOrTruck), _boxOrTruck];

// TODO: TBD: this is a better factoring for the FOB build request radius, etc...
// TODO: TBD: as a function of fob range? should be additional settings here...
[getPos _boxOrTruck, MPARAM(_range) / 2, [KPLIB_preset_fobBuildingF, 0, 0, 0]] call KPLIB_fnc_build_start_single;

if (_debug) then {
    ["[fn_fobs_onDeployRequested] Fini", "FOBS", true] call KPLIB_fnc_common_log;
};

true;
