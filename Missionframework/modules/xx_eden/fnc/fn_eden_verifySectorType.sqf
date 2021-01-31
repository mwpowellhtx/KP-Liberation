/*
    KPLIB_fnc_eden_verifySectorType

    File: fn_eden_verifySectorType.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 12:49:54
    Last Update: 2021-01-28 12:49:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Verifies the '_sectorType' of the given _target object.

    Parameter(s):
        _target - The _target object [OBJECT, default: objNull]
        _expected - Used to verify the _target 'KPLIB_sectorType' variable [
            SCALAR - whether value equal to
            ARRAY - whether value is in
            CODE - _this passed to callback for evaluation
        ]
        _varName - The _varName at which to verify [STRING, default: "KPLIB_sectorType"]

    Returns:
        Whether the _target 'KPLIB_sectorType' variable meets the _expected criteria [BOOL]
*/

params [
    ["_target", objNull, [objNull]]
    , ["_expected", KPLIB_sectorType_nil]
    , ["_varName", "KPLIB_sectorType", [""]]
];

if (isNull _target) exitWith {false};

private _actual = _target getVariable [_varName, KPLIB_sectorType_nil];

switch (typeName _expected) do {
    case "SCALAR": {
        _actual == _expected;
    };
    case "ARRAY": {
        !(_expected isEqualTo [])
        && _actual in _expected;
    };
    case "CODE": {
        _actual call _expected;
    };
    default {false}
};
