/*
    KPLIB_fnc_common_min

    File: fn_common_min.sqf
    Author: Michael W. Powell
    Created: 2021-01-25 10:46:59
    Last Update: 2021-01-25 10:47:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the minimum element from the _vector aligned by the _selector.

    Parameters:
        _vector - The array vector of elements
        _selector - The selector function

    Returns:
        Returns the minimum element from the _vector as aligned by the _selector.
        Returns nil when no elements are available to select from.
*/

// Selector defaults to identity, or itself.
private _defaultSelector = {_this};

params [
    ["_vector", [], [[]]]
    , ["_selector", _defaultSelector, [{}]]
];

// Zero element vectors are to return nothing: i.e. nil.
private _vectorCount = count _vector;

// Vectors of one element are easy, only one minimum element.
if (_vectorCount == 1) exitWith {
    _vector select 0;
};

// Gets a bit more complex when there is more than one element.
if (_vectorCount > 0) exitWith {

    private ["_i", "_elem"];

    for [{_i = 0}, {_i < _vectorCount}, {_i = _i + 1}] do {

        private _next = _vector select _i;

        if (_i == 0) then {
            _elem = _next;
        } else {
            if (
                _i > 0
                && ([_next] call _selector) < ([_elem] call _selector)
            ) then {
                _elem = _next;
            };
        };
    };

    _elem;
};
