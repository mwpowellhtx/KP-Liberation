/*
    KPLIB_fnc_core_findStartbases

    File: fn_core_findStartbases.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-25 01:00:13
    Last Update: 2021-01-25 01:00:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
    Given _target and _predicate
        Checks if there are units from given side(s) inside a given radius around a given position.

    Parameters:
        _target         - a target object given to compare against the startbases [OBJECT, default: objNull]
        _predicate      - callback accepting the target and one of the startbase tuples.
                          Used to evaluate each startbase plus distance tuple [CODE, default: {false}]

    Returns:
        The startbase plus distance tuples matching the predicate [ARRAY]
*/

// TODO: TBD: could go either way, this is core? could be "common" as well...
// TODO: TBD: we'll start here for the time being...

private _defaultPredicate = {false};

params [
    ["_target", objNull]
    , ["_predicate", [_defaultPredicate]]
];

private _plusDistances = KPLIB_init_startbases apply {
    private _retval = +_x;
    private _val = if (isNull _target) then {-1} else {
        _target distance2D (_x select 1);
    };
    _retval pushBack _val;
    _retval;
};

private _selection = _plusDistances select {[_target, _x] call _predicate};

_selection
