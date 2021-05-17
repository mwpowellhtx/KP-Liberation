#include "script_component.hpp"
/*
    KPLIB_fnc_resources_onGatherIntel

    File: fn_resources_onGatherIntel.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 19:33:44
    Last Update: 2021-04-27 16:46:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when a PLAYER clicks the GATHER INTEL action menu item.

    Parameter(s):
        _targetObj - the TARGET OBJECT for which INTEL may be gathered [OBJECT, default: objNull]
        _caller - the CALLER, should be the player clicking the action menu [OBJECT, default: objNull]

    Returns:
        The event handler completed [BOOL]
 */

params [
    [Q(_targetObj), objNull, [objNull]]
    , [Q(_caller), objNull, [objNull]]
];

private _debug = MPARAM(_onGatherIntel_debug)
    || (_targetObj getVariable [QMVAR(_onGatherIntel_debug), false])
    || (_caller getVariable [QMVAR(_onGatherIntel_debug), false]);

if (isNull _targetObj || isNull _caller || !isPlayer _caller) exitWith {
    false;
};

private _intel = _targetObj getVariable [QMVAR(_intel), 0];

// TARGET OBJECT intel is not going to occur anywhere else but within BASE PROXIMITY
private _markerName = [KPLIB_param_sectors_capRange, getPos _targetObj, KPLIB_sectors_military] call KPLIB_fnc_core_getNearestMarker;
//                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^                     ^^^^^^^^^^^^^^^^^^^^^^

// TODO: TBD: leaving this in for the time being
/*
// TODO: TBD: this is a plausible strategy for intel placement during garrison...
// TODO: TBD: should not leave this here obviously, this is a scratch pad with a snippet that might be useful
_type = selectRandom keys KPLIB_preset_resources_intelMap;
_marker = [KPLIB_param_sectors_actRange, getPos player, KPLIB_sectors_military] call KPLIB_fnc_core_getNearestMarker;
_buildings = nearestObjects [markerPos _marker, ['Building'], 100, true];
_buildings = _buildings select { !((_x buildingPos -1) isEqualTo []); };
_building = selectRandom _buildings;
_pos = selectRandom (_building buildingPos -1);
_obj = createVehicle [_type, _pos vectorAdd [0, 0, 0.5], [], 1, 'can_collide'];
[_building, _obj];
*/

[_intel, format ["'%1' gathered %2 intel", markerText _markerName, _intel], _markerName] call MFUNC(_addIntel);

[_targetObj] call MFUNC(_onIntelGC);

true;
