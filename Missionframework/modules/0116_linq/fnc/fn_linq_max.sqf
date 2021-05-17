/*
    KPLIB_fnc_linq_max

    File: fn_linq_max.sqf
    Author: Michael W. Powell
    Created: 2021-02-23 18:58:55
    Last Update: 2021-02-23 18:58:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the maximum element from the _vector aligned by the _selector.

    Parameters:
        _vector - The array vector of elements
        _selector - The selector function

    Returns:
        Returns the maximum element from the _vector as aligned by the _selector.
        Returns nil when no elements are available to select from.
*/

// Selector defaults to identity, or itself.
private _defaultSelector = {_this};

params [
    ["_vector", [], [[]]]
    , ["_selector", _defaultSelector, [{}]]
];

// Zero element vectors are to return nothing: i.e. nil.
private _count = count _vector;

// Vectors of one element are easy, only one maximum element.
if (_count == 1) exitWith {
    _vector select 0;
};

// Gets a bit more complex when there is more than one element.
if (_count > 0) exitWith {

    private ["_i", "_elem"];

    for [{_i = 0}, {_i < _count}, {_i = _i + 1}] do {

        private _next = _vector select _i;

        if (_i == 0) then {
            _elem = _next;
        } else {
            if (_i > 0 && ([_next, _i] call _selector) > ([_elem, _i] call _selector)) then {
                _elem = _next;
            };
        };
    };

    _elem;
};
