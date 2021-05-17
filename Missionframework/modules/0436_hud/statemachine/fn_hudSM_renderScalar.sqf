#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_renderScalar

    File: fn_hudSM_renderScalar.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:11:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Renders a scalar value given nominal parameters.

    Parameters:
        _value - a value being rendered [SCALAR, default: 0]
        _maxValue - a maximum value to use, i.e. as a percentage [SCALAR, default: 1]
        _suffix - optional suffix to use [STRING, default: ""]
        _places - places to use formatting fixed [SCALAR, default: 0]

    Returns:
        The rendered value [STRING]

    References:
        https://community.bistudio.com/wiki/toFixed#Syntax
 */

private _debug = [
    [
        {MPARAM(_renderScalar_debug)}
    ]
] call MFUNC(_debug);

// Allows rendering of use case, i.e. PERCENTAGE, while allowing 'simple' rendering to string
params [
    [Q(_value), 0, [0]]
    , [Q(_maxValue), 1, [0]]
    , [Q(_suffix), "", [""]]
    , [Q(_places), 0, [0]]
];

// Does not require 'signage' after all
private _signage = if (false && _value < 0) then { "-"; } else { ""; };

// TODO: TBD: allows cases like DBZ ...
// When divisor is ONE just use VALUE
private _scaled = if (_maxValue == 1) then {
    _value;
} else {
    // TODO: TBD: may get in either direction and/or depending on suffix
    // TODO: TBD: for now assuming always 'percentage' i.e. '%'
    // Times one hundred to get a 'percentage' view
    (_value / _maxValue) * 100;
};

if (_suffix isEqualTo "") exitWith {
    format ["%1%2", _signage, _scaled];
};

format ["%1%2%3", _signage, (_scaled toFixed _places), _suffix];
