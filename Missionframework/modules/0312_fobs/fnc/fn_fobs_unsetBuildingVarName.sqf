#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_unsetBuildingVarName

    File: fn_fobs_unsetBuildingVarName.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-23 19:59:15
    Last Update: 2021-05-23 19:59:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Unsets the VEHICLEVARNAME associated with the FOB BUILDING. Assumes that the
        FOB BUILDING has at least seen its UUID. Everything else is derived from there.
        In this instance, we work from a previously set VEHICLEVARNAME.

    Parameters:
        _fobBuilding - unsets the associated BUILDINGVARNAME [OBJECT, default: objNull]

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

if (isNull _fobBuilding || _markerName isEqualTo "") exitWith { false; };

_fobBuilding setVehicleVarName "";
missionNamespace setVariable [_markerName, nil, true];

true;
