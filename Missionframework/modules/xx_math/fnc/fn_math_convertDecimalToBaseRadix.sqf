/*
    KPLIB_fnc_math_convertDecimalToBaseRadix

    File: fn_math_convertDecimalToBaseRadix.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-25 19:56:15
    Last Update: 2021-01-25 19:56:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns an array of the converted digits in the expected _radix.

    Parameter(s):
        _value - A decimal value to convert to the _radix [NUMERIC, default: 0]
        _radix - The base to which to convert [NUMERIC, default: 0, valid: _x > 1]

    Returns:
        An array containing the numeric values of the digits in the _radix converting from _value
            - i.e. converting to hex, 'A' numeric value is 10, therefore 10 base-10 would convert to [10]

    Remarks:
        It is left to the caller to do any further processing of the result in context of the calling algorithm.
        Also, specifically dealing with FOB conversions, while we would never expect the number of FOB sites to
        grow to excessively large numbers, it is entirely plausible, however, for concerns such as Logistics to
        have grown well beyond that. Hence the motivation for a general use rather than fit for purpose algorithm.

    Reference:
        http://codeofthedamned.com/index.php/number-base-conversion
        https://codereview.stackexchange.com/questions/140250/base-10-to-base-n-conversion
        https://stackoverflow.com/questions/12713999/base-10-to-base-n-conversions
        https://www.tutorialspoint.com/program-for-decimal-to-binary-conversion-in-cplusplus
        https://www.dcode.fr/base-n-convert
*/

params [
    ["_value", 0, [0]]
    , ["_radix", 2, [0]]
];

private _retval = [];

//// TODO: TBD: should have some debug flags... settings, etc...
//[format ["[fn_math_convertDecimalToBaseRadix] [value, radix, retval]: %1", str [_value, _radix, _retval]], "MATH", true] call KPLIB_fnc_common_log;

if (_radix <= 1) exitWith {_retval};

private _quotient = _value;

if (_value == 0) then {
    _retval pushBack 0;
} else {
    while {_quotient > 0} do {
        private _remainder = _quotient % _radix;
        _retval pushBack _remainder;

        //[format ["[fn_math_convertDecimalToBaseRadix] [quotient, remainder]: %1", str [_quotient, _remainder]], "MATH", true] call KPLIB_fnc_common_log;

        _quotient = (_quotient - _remainder) / _radix;
    };
};

//[format ["[fn_math_convertDecimalToBaseRadix] [retval]: %1", str [_retval]], "MATH", true] call KPLIB_fnc_common_log;

_retval
