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

// Including some signage
private _signage = if (_value < 0) then { "-"; } else { ""; };

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
