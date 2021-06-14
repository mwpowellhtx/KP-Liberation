/*
    KPLIB_fnc_captive_onSectorCapturedSurrenderUnits

    File: fn_captive_onSectorCapturedSurrenderUnits.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-31 14:48:04
    Last Update: 2021-06-14 17:20:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    ["_sector", locationNull, [locationNull]]
];

private _debug = KPLIB_param_captive_onSectorCapturedSurrenderUnits_debug
    || (_sector getVariable ["KPLIB_captive_onSectorCapturedSurrenderUnits_debug", false])
    ;

[
    _sector getVariable ["KPLIB_sectors_markerName", ""]
    , _sector getVariable ["KPLIB_sectors_blufor", false]
    , _sector getVariable ["KPLIB_sectors_opfor", false]
] params [
    "_markerName"
    , "_blufor"
    , "_opfor"
];

// OPFOR won, then do not bother surrendering BLUFOR AI in this manner
if (_opfor) exitWith {
    private _capUnits = _sector getVariable ["KPLIB_sectors_capUnitsF", []];
    private _unitsToDelete = _capUnits select { !(isPlayer _x || isPlayer leader _x); };

    { deleteVehicle _x; } forEach _unitsToDelete;

    true;
};

// TODO: TBD: could introduce a script_component.hpp to the module... with appropriate PCT define...
private _toPct = { _this / 100; };

// BLUFOR won, then we consider a chance for OPFOR units to surrender
if (_blufor) exitWith {
    [
        _sector getVariable ["KPLIB_sectors_allUnitE", []]
        , (1 - ([] call KPLIB_fnc_enemies_getStrengthRatio))
        , KPLIB_param_captive_opforUnitSurrenderChance call _toPct
        , KPLIB_param_captive_opforUnitSurrenderBias call _toPct
    ] params [
        "_allUnits"
        , "_inverseStrengthRatio"
        , "_opforUnitSurrenderChance"
        , "_opforUnitSurrenderBias"
    ];

    {
        _x param [
            ["_units", [], [[]]]
            , ["_chance", 0, [0]]
            , ["_bias", 0, [0]]
        ];

        private _actualChance = _bias + ((_chance + _inverseStrengthRatio) / 2);
        private _unitsToSurrender = _units select { random 1 < _actualChance; };

        { [_x] call KPLIB_fnc_captive_setSurrender; } forEach _unitsToSurrender;

    } forEach [
        [_allUnits select { alive _x; }, _opforUnitSurrenderChance, _opforUnitSurrenderBias]
    ];

    true;
};

true;
