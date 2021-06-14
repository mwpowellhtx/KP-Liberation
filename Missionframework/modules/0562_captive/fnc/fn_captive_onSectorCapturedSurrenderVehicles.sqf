/*
    KPLIB_fnc_captive_onSectorCapturedSurrenderVehicles

    File: fn_captive_onSectorCapturedSurrenderVehicles.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-31 13:40:05
    Last Update: 2021-06-14 17:20:04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/crew
        https://community.bistudio.com/wiki/deleteVehicle
        https://community.bistudio.com/wiki/deleteVehicleCrew
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
 */

params [
    ["_sector", locationNull, [locationNull]]
];

private _debug = KPLIB_param_captive_onSectorCapturedSurrenderVehicles_debug
    || (_sector getVariable ["KPLIB_captive_onSectorCapturedSurrenderVehicles_debug", false])
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

// When OPFOR captured the sector, then do not bother surrendering BLUFOR AI in this manner
if (_opfor) exitWith {

    [
        _sector getVariable ["KPLIB_sectors_capVehiclesF", []]
        , KPLIB_preset_captive_minScuttleTimeout
        , KPLIB_param_captive_bluforScuttleTimeout
    ] params [
        "_capVehicles"
        , "_minScuttleTimeout"
        , "_scuttleTimeout"
    ];

    // Leave any VEHICLES with at least one PLAYER alone
    private _vehiclesToKill = _capVehicles select { !isPlayer _x; };

    {
        private _scuttleDelay = random _scuttleTimeout max _minScuttleTimeout;

        _x setVariable ["KPLIB_captive_scuttleDelay", _scuttleDelay, true];

        private _onScuttleVehicle = {
            { _x setDamage 1; } forEach crew _this;
            _this setDamage 1;
        };

        [_onScuttleVehicle, _x, _scuttleDelay] call CBA_fnc_waitAndExecute;

    } forEach _vehiclesToKill;

    true;
};

// TODO: TBD: could introduce a script_component.hpp to the module... with appropriate PCT define...
private _toPct = { _this / 100; };

// When BLUFOR won the sector then we consider a chance for OPFOR vehicles to surrender
if (_blufor) exitWith {

    [
        _sector getVariable ["KPLIB_sectors_allVehiclesE", []]
        , (1 - ([] call KPLIB_fnc_enemies_getStrengthRatio))
        , KPLIB_param_captive_opforLightVehicleSurrenderChance call _toPct
        , KPLIB_param_captive_opforLightVehicleSurrenderBias call _toPct
        , KPLIB_param_captive_opforHeavyVehicleSurrenderChance call _toPct
        , KPLIB_param_captive_opforHeavyVehicleSurrenderBias call _toPct
        , KPLIB_param_captive_opforApcVehicleSurrenderChance call _toPct
        , KPLIB_param_captive_opforApcVehicleSurrenderBias call _toPct
    ] params [
        "_allVehicles"
        , "_inverseStrengthRatio"
        , "_opforLightVehicleSurrenderChance"
        , "_opforLightVehicleSurrenderBias"
        , "_opforHeavyVehicleSurrenderChance"
        , "_opforHeavyVehicleSurrenderBias"
        , "_opforApcVehicleSurrenderChance"
        , "_opforApcVehicleSurrenderBias"
    ];

    [
        _allVehicles select { typeOf _x in KPLIB_preset_vehLightArmedPlE; }
        , _allVehicles select { typeOf _x in KPLIB_preset_vehHeavyPlE; }
        , _allVehicles select { typeOf _x in KPLIB_preset_vehHeavyApcPlE; }
    ] params [
        "_lightArmedVehicles"
        , "_heavyVehicles"
        , "_heavyApcVehicles"
    ];

    {
        _x param [
            ["_vehicles", [], [[]]]
            , ["_chance", 0, [0]]
            , ["_bias", 0, [0]]
        ];

        private _actualChance = _bias + ((_chance + _inverseStrengthRatio) / 2);
        private _vehiclesToSurrender = _vehicles select { random 1 <= _actualChance; };

        { [_x] call KPLIB_fnc_captive_setVehicleSurrender; } forEach _vehiclesToSurrender;

    } forEach [
        [_lightArmedVehicles, _opforLightVehicleSurrenderChance, _opforLightVehicleSurrenderBias]
        , [_heavyVehicles, _opforHeavyVehicleSurrenderChance, _opforHeavyVehicleSurrenderBias]
        , [_heavyApcVehicles, _opforApcVehicleSurrenderChance, _opforApcVehicleSurrenderBias]
    ];

    true;
};

true;
