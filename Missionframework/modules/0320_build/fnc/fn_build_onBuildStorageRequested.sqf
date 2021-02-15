/*
    KPLIB_fnc_build_onBuildStorageRequested

    File: fn_build_onBuildStorageRequested.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-14 22:09:01
    Last Update: 2021-02-14 22:09:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Factory sector storage container build requested local CBA event handler.

    Parameter(s):
        _boxOrTruck - the target object of the build request [OBJECT, default: objNull]
        _pos - the position of the build request [ARRAY, default: KPLIB_zeroPos]

    Returns:
        The CBA event handler has finished [BOOL]
*/

private _debug = [] call KPLIB_fnc_build_debug;

params [
    ["_pos", KPLIB_zeroPos, [[]], 3]
];

if (_debug) then {
    [format ["[fn_build_onBuildStorageRequested] [_pos]: %1"
        , str [_pos]], "BUILD", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: report message, unable to perform build...
if (_pos isEqualTo KPLIB_zeroPos) exitWith {
    false;
};

// TODO: TBD: could this be where we are missing direction, up, and any other orientation bits?
// TODO: TBD: somewhere between "here" and starting the single for the FOB building...
// TODO: TBD: something is being forgotten, dots are not connecting, especially re: dir/up vectors...
// Start single item build for fob building
// TODO: TBD: additionally instead of the nakedly public variable, should consider whether we need a variable at all...

private _onConfirm = {
    // TODO: TBD: this appears to be the point at which we handle the specifics for FOB build request confirmation...
    [(_this#0)] remoteExec ["KPLIB_fnc_build_onConfirmBuildStorage", 2];
};

// TODO: TBD: this is a better factoring for the FOB build request radius, etc...
// TODO: TBD: as a function of fob range? should be additional settings here...
[_pos, KPLIB_param_sectorCapRange, [KPLIB_preset_storageSmallF, 0, 0, 0], _onConfirm] call KPLIB_fnc_build_start_single;

true;
