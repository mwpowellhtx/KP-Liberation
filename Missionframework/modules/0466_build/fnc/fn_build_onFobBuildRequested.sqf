/*
    KPLIB_fnc_build_onFobBuildRequested

    File: fn_build_onFobBuildRequested.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-12 08:38:56
    Last Update: 2021-05-17 20:33:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        FOB build requested local CBA event handler.

    Parameter(s):
        _boxOrTruck - the target object of the build request [OBJECT, default: objNull]
        _pos - the position of the build request [ARRAY, default: KPLIB_zeroPos]

    Returns:
        The CBA event handler has finished [BOOL]
*/

private _debug = [] call KPLIB_fnc_build_debug;

params [
    ["_boxOrTruck", objNull, [objNull]]
    , ["_pos", KPLIB_zeroPos, [[]], 3]
];

if (_debug) then {
    [format ["[fn_build_onFobBuildRequested] [_boxOrTruck, getPos _boxOrTruck]: %1"
        , str [_boxOrTruck, getPos _boxOrTruck]], "BUILD", true] call KPLIB_fnc_common_log;
};

KPLIB_build_fobBuildObject = _boxOrTruck;

if (_pos isEqualTo KPLIB_zeroPos) then {
    _pos = getPos KPLIB_build_fobBuildObject;
};

// TODO: TBD: could this be where we are missing direction, up, and any other orientation bits?
// TODO: TBD: somewhere between "here" and starting the single for the FOB building...
// TODO: TBD: something is being forgotten, dots are not connecting, especially re: dir/up vectors...
// Start single item build for fob building
// TODO: TBD: additionally instead of the nakedly public variable, should consider whether we need a variable at all...

private _onConfirm = {
    // On confirm callback, create FOB on server
    // TODO: TBD: this appears to be the point at which we handle the specifics for FOB build request confirmation...
    [(_this select 0), KPLIB_build_fobBuildObject] remoteExec ["KPLIB_fnc_build_onConfirmBuildFob", 2];
};

// TODO: TBD: this is a better factoring for the FOB build request radius, etc...
// TODO: TBD: as a function of fob range? should be additional settings here...
[_pos, (35 max KPLIB_param_fobs_range/2), [KPLIB_preset_fobBuildingF, 0, 0, 0], _onConfirm] call KPLIB_fnc_build_start_single;

true;
