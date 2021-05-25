#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_onTearDownBuilding

    File: fn_fobs_onTearDownBuilding.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-19 11:06:22
    Last Update: 2021-05-24 23:24:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Tears down the specified FOB BUILDING object.

    Parameter(s):
        _fobBuilding - an FOB BUILDING object [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_fobBuilding), objNull, [objNull]]
];

private _debug = MPARAM(_onTearDown_debug)
    || (_fobBuilding getVariable [QMVAR(_onTearDown_debug), false])
    ;

if (isNull _fobBuilding) exitWith { false; };

// Remove the FOB BUILDING from the ALL BUILDINGS array
MVAR(_allBuildings) = MVAR(_allBuildings) - [_fobBuilding];

// TODO: TBD: remember to unregister triggers, etc...
private _militaryAlpha = _fobBuilding getVariable [QMVAR(_militaryAlpha), "Unknown"];

[
    Q(KPLIB_notification_blufor)
    , [
        "KP LIBERATION - FOB"
        , MPRESET(_markerPath)
        , format [localize "STR_KPLIB_FOBS_FOB_PACK_FORMAT", _militaryAlpha]
    ]
    , allPlayers
] call KPLIB_fnc_notification_show;

// Draw down the variable prior to resequencing
[vehicleVarName _fobBuilding] call {
    params [
        [Q(_buildingVarName), "", [""]]
    ];
    if (!(_buildingVarName isEqualTo "")) then {
        _fobBuilding setVehicleVarName "";
        missionNamespace setVariable [_buildingVarName, nil, true];
    };
};

// TODO: TBD: from 'tear down', there really needs to be a proper GC that rolls up all the steps: markers, vehicle vars, etc...
[_fobBuilding] call MFUNC(_unsetBuildingVarName);
deleteMarker (_fobBuilding getVariable [QMVAR(_markerName), ""]);
deleteVehicle _fobBuilding;

// Resequence the remaining FOB BUILDINGS
[] call MFUNC(_resequence);

// And remember to SAVE afterwards
["fn_fobs_onTearDownBuilding"] spawn KPLIB_fnc_init_save;

true;
