#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/toFixed#Syntax

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

// TODO: TBD: allows cases like DBZ ...
// When divisor is ONE just use VALUE
private _scaled = if (_maxValue == 1) then {
    _value;
} else {
    (_value / _maxValue);
};

if (_suffix isEqualTo "") exitWith {
    format ["%1", _scaled];
};

format ["%1%2", (_scaled toFixed _places), _suffix];
