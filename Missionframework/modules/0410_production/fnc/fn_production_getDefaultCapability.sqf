/*
    KPLIB_fnc_production_getDefaultCapability

    File: fn_production_getDefaultCapability.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 15:57:07
    Last Update: 2021-02-04 15:57:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a default, random, 'capability' for a given production site.

    Parameter(s):
        _cap - default 'capability'
        _min - minimum value used for random 'capability'
        _max - maximum value used for random 'capability'
        _mid - mid point value used for random 'capability'

    Returns:
        A default, random, 'capability'.
*/

params [
    ["_cap", nil]
    , ["_min", nil]
    , ["_max", nil]
    , ["_mid", nil]
];

if (isNil "_cap") then {

    private _count = count KPLIB_production_res_indexes;

    if (isNil "_min") then {_min = 0;};
    if (isNil "_max") then {_max = 1000000;};

    private _calculateMid = {
        (_min + _max) / 2;
    };

    if (isNil "_mid") then {
        _mid = [] call _calculateMid;
    } else {
        if (_mid < _min || _mid > _max) then {
            _mid = [] call _calculateMid;
        };
    };

    // https://community.bistudio.com/wiki/random#Alternative_Syntax
    private _r = random [_min, _mid, _max];

    private _f = floor _r;

    _cap = _f mod _count;
};

// Returns with the capability aligning to the expected default capability.
private _retval = KPLIB_production_res_indexes apply {_x isEqualTo _cap};

_retval;
