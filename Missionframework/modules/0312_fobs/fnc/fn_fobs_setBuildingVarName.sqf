
#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_setBuildingVarName

    File: fn_fobs_setBuildingVarName.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-23 20:03:07
    Last Update: 2021-05-23 20:03:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets the BUILDINGVARNAME associated with the FOB BUILDING. Assumes that the
        FOB BUILDING has at least seen its UUID. Everything else is derived from there.

    Parameters:
        _fobBuilding - sets the associated BUILDINGVARNAME [OBJECT, default: objNull]

    Returns:
        The function has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/vehicleVarName
        https://community.bistudio.com/wiki/setVehicleVarName
        https://community.bistudio.com/wiki/missionNamespace
 */

params [
    [Q(_fobBuilding), objNull, [objNull]]
];

private _markerName = _fobBuilding getVariable [QMVAR(_markerName), ""];

if (isNull _fobBuilding || vehicleVarName _fobBuilding isEqualTo _markerName) exitWith { false; };

_fobBuilding setVehicleVarName _markerName;
missionNamespace setVariable [_markerName, _fobBuilding, true];

true;
