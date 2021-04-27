#include "script_component.hpp"
/*
    KPLIB_fnc_resources_onGatherIntel

    File: fn_resources_onGatherIntel.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 19:33:44
    Last Update: 2021-04-26 19:33:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when a PLAYER clicks the GATHER INTEL action menu item.

    Parameter(s):
        _target - the TARGET object for which INTEL may be gathered [OBJECT, default: objNull]
        _caller - the CALLER, should be the player clicking the action menu [OBJECT, default: objNull]

    Returns:
        The event handler completed [BOOL]
 */

params [
    [Q(_target), objNull, [objNull]]
    , [Q(_caller), objNull, [objNull]]
];

private _debug = MPARAM(_onGatherIntel_debug)
    || (_target getVariable [QMVAR(_onGatherIntel_debug), false])
    || (_caller getVariable [QMVAR(_onGatherIntel_debug), false]);

if (isNull _target || isNull _caller || !isPlayer _caller) exitWith {
    false;
};

private _intel = _target getVariable [QMVAR(_intel), 0];

// Intel is not going to occur anywhere else but within BASE PROXIMITY
private _markerName = [KPLIB_param_sectors_capRange, getPos _target, KPLIB_sectors_military] call KPLIB_fnc_core_getNearestMarker;
//                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^                  ^^^^^^^^^^^^^^^^^^^^^^

systemChat format ["[%1, %2] '%3' gathered %4 intel", typeOf _target, typeOf _caller, markerText _markerName, _intel];

[_intel, format ["'%1' gathered %2 intel", markerText _markerName, _intel], _markerName] call MFUNC(_addIntel);

deleteVehicle _target;

true;
