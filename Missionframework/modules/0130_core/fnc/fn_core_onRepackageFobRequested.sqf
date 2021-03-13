/*
    KPLIB_fnc_core_onRepackageFobRequested

    File: fn_core_onRepackageFobRequested.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-14 22:09:01
    Last Update: 2021-02-15 11:06:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Factory sector storage container build requested local CBA event handler.

    Parameter(s):
        ...

    Returns:
        The CBA event handler has finished [BOOL]
 */

private _debug = [] call KPLIB_fnc_build_debug;

// TODO: TBD: instead of "fob box" we need "pos" ...
// TODO: TBD: to make this more general, might consider passing in that on onconfirm callback...
params [
    ["_pos", KPLIB_zeroPos, [[]], 3]
    , ["_range", 0, [0]]
    , ["_className", "", [""]]
    , ["_onConfirm", {}, [{}]]
];

if (_debug) then {
    [format ["[fn_core_onRepackageFobRequested] [_pos]: %1"
        , str [_pos]], "BUILD", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: report message, unable to perform build...
if (_pos isEqualTo KPLIB_zeroPos) exitWith {
    false;
};

// TODO: TBD: this is a better factoring for the FOB build request radius, etc...
// TODO: TBD: as a function of fob range? should be additional settings here...

// Start single item build for fob repackaging
[_pos, _range, [_className, 0, 0, 0], _onConfirm] call KPLIB_fnc_build_start_single;

true;
