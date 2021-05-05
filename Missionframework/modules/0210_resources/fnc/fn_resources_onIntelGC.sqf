#include "script_component.hpp"
/*
    KPLIB_fnc_resources_onIntelGC

    File: fn_resources_onIntelGC.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-27 12:39:44
    Last Update: 2021-05-05 11:14:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Performs bookkeeping GC duties given a TARGET INTEL OBJECT.

    Parameter(s):
        _targetObj - a garrisoned INTEL OBJECT [OBJECT, default: objNull]

    Returns:
        The function has returned [BOOL]

    References:
        https://community.bistudio.com/wiki/buildingPos
        https://community.bistudio.com/wiki/createVehicle
        https://community.bistudio.com/wiki/nearestObjects
        https://community.bistudio.com/wiki/BIS_fnc_arrayShuffle
        https://dictionary.com/browse/stochastic
        https://sciencedirect.com/topics/earth-and-planetary-sciences/stochasticity
        https://en.wikipedia.org/wiki/Stochastic
 */

params [
    [Q(_targetObj), objNull, [objNull]]
];

private _debug = MPARAM(_onIntelGC_debug)
    || (_targetObj getVariable [QMVAR(_onIntelGC_debug), false]);

[
    _targetObj getVariable [Q(_targetNamespace), locationNull]
    , _targetObj getVariable [Q(KPLIB_garrison_uuid), ""]
] params [
    Q(_namespace)
    , Q(_targetUuid)
];

// Unable to GC the TARGET INTEL OBJECT if is was not an expected class name
if (isNull _targetObj || !(typeOf _targetObj in KPLIB_preset_resources_intelMap)) exitWith {
    false;
};

private _intel = _namespace getVariable [Q(KPLIB_garrison_intel), []];

// Select remaining INTEL OBJECTS minus the TARGET one
_namespace setVariable [Q(KPLIB_garrison_intel), _intel select {
    private _intelUuid = _x getVariable [Q(KPLIB_garrison_uuid), ""];
    !(_intelUuid isEqualTo _targetUuid);
}];

deleteVehicle _targetObj;

true;
