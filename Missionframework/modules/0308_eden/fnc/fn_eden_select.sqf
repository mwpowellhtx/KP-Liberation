#include "script_component.hpp"
/*
    KPLIB_fnc_eden_select

    File: fn_eden_select.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 11:49:52
    Last Update: 2021-05-20 20:31:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Responds with an array of the Eden tuples meeting the predicated conditions.

    Parameters:
        _target - a target object given to compare against the Eden bits [OBJECT, default: objNull]
        _predicate - a callback used to evaluate _target distance from each Eden tuple [CODE, default: _defaultPredicate]
            - Given arguments: [
                ["_target", objNull, [objNull]]
                , ["_dist2d", 0, [0]]
                , ["_x", [], [[]]]
            ]

    Returns:
        The START BASE plus distance tuples matching the predicate [ARRAY]
 */

// TODO: TBD: could go either way, this is core? could be "common" as well...
// TODO: TBD: we'll start here for the time being...
// TODO: TBD: should be a common/core/markers select predicated markers...

// TODO: TBD: what are we selecting here exactly?
// TODO: TBD: for what 'targets'?
// TODO: TBD: would sector marker name be more appropriate?

private _defaultPredicate = { false; };

params [
    [Q(_target), objNull, [objNull]]
    , [Q(_predicate), _defaultPredicate, [{}]]
];

private _applied = KPLIB_sectors_startbases apply {
    [
        _target
        , if (isNull _target) then {
            markerPos _x distance _target;
        }
        , _x
    ];
};

_applied select { _x call _predicate; };
