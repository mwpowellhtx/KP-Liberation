/*
    KPLIB_fnc_build_camCreate

    File: fn_build_camCreate.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-07-01
    Last Update: 2021-05-17 20:33:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates the build camera

    Parameter(s):
        _center - Center of building area [POSITION, defaults to position player]
        _radius - Allowed building radius [NUMBER, defaults to KPLIB_param_fobs_range]

    Returns:
        Building camera [OBJECT]
*/

params [
    ["_position", position player, [[]], 3],
    ["_radius", KPLIB_param_fobs_range, [0]]
];

private _camera = "CamCurator" camCreate (eyePos player);

_camera cameraEffect ["internal", "back"];
_camera camCommand "maxPitch 89";
_camera camCommand "minPitch -89";
// Same speed no matter the height
_camera camCommand "surfaceSpeed off";
// Do not track terrain
_camera camCommand "atl off";

_camera camCommand format ["speedDefault %1", 1];
_camera camCommand format ["speedMax %1", 1.5];
// Enable display of GUI in camera
cameraEffectEnableHUD true;

[_camera, _position, _radius] call KPLIB_fnc_build_camAreaLimiter;

_camera
