#include "script_components.hpp"
/*
    KPLIB_fnc_build_stop

    File: fn_build_stop.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-09-09
    Last Update: 2021-02-12 10:25:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Stops KP Liberation building mode

    Parameters:
        NONE

    Returns:
        Build mode was stopped [BOOL]
*/

private _debug = [] call KPLIB_fnc_build_debug;

// TODO: TBD: how does stop operate as an opposite boundary to the start?
private _logic = missionNamespace getVariable ["KPLIB_buildLogic", locationNull];

if (!(isNull _logic)) then {

    camDestroy LGVAR_D(camera,objNull);

    (_logic getVariable ["display", displayNull]) closeDisplay 0;

    {
        deleteVehicle _x;
    } forEach LGVAR_D(areaIndicators,[]);

    // Remove queue items if in building mode
    if (LGVAR_D(buildMode,KPLIB_build_buildMode_move) isEqualTo KPLIB_build_buildMode_move) then {
        {
            // TODO: TBD: in an effort to isolate the moment(s) when we have a FOB building, for instance, and any vector issues at hand...
            if (_debug) then {
                [format ["[fn_build_stop] [typeOf _x, getPos _x, vectorUp _x]: %1"
                    , str [typeOf _x, getPos _x, vectorUp _x]], "BUILD"] call KPLIB_fnc_common_log;
            };

            deleteVehicle _x;

        } forEach LGVAR_D(buildQueue,[]);
    };

    [_logic] call KPLIB_fnc_namespace_onGC;
};

["KPLIB_build_stop"] call CBA_fnc_localEvent;

true;
