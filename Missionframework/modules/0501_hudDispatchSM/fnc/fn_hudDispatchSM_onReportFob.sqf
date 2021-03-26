#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/nearestObjects

private _debug = [
    [
        {MPARAM(_onReportFob_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob] Entering: [isNull _player]: %1"
        , str [isNull _player]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

if (isNull _player) exitWith { []; };

[
    // When TRUE, report on ALL the FOBS, otherwise report on the nearest one
    _player getVariable [KPLIB_hud_reportAllResources, false]
    , getPos _player
    , KPLIB_param_fobRange
] params [
    Q(_reportAllResources)
    , Q(_playerPos)
    , Q(_range)
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob] Evaluating FOBs: [_reportAllResources, _playerPos, _range]: %1"
        , str [_reportAllResources, _playerPos, _range]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: probably should be a more COMMON API here, perhaps...
private _fobs = [_playerPos, +KPLIB_sectors_fobs, _reportAllResources] call {
    params [
        [Q(_targetPos), +KPLIB_zeroPos, [[]], 3]
        , [Q(_fobs), [], [[]]]
        , [Q(_reportAll), false, [false]]
    ];
    if (_targetPos isEqualTo KPLIB_zeroPos) exitWith { []; };
    _fobs select {
        _x params [
            Q(_0)
            , Q(_1)
            , Q(_2)
            , Q(_3)
            , [Q(_pos), +KPLIB_zeroPos, [[]], 3]
        ];
        _reportAll
            || (_pos distance2D _targetPos) <= _range;
    };
};

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob] Compiling report: [count _fobs]: %1"
        , str [count _fobs]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

// Nothing to report when PLAYER not in range of an FOB
if (_fobs isEqualTo []) exitWith { []; };

// TODO: TBD: relay as string table key, may localize here, or client side
private _markerText = if (count _fobs == 1) then {
    toUpper (_fobs#0#1);
} else {
    toUpper "All FOBs";
};

private _resTotals = _fobs apply {
    _x params [
        [Q(_markerName), "", [""]]
    ];
    // Yes it is the default, but we will be specific
    [_markerName, _range] call KPLIB_fnc_resources_getResTotal;
};

// TODO: TBD: review 'KPLIB_fnc_resources_getResTotal', might make sense to just support 0+ locations...
// Get RESOURCE SLICE views across the range of RESOURCE TOTALS
(KPLIB_resources_indexes apply {
    private _resourceIndex = _x;
    _resTotals apply { _x select _resourceIndex; };
}) params [
    Q(_supplySlice)
    , Q(_ammoSlice)
    , Q(_fuelSlice)
];

[
    _fobs apply { [(_x#4)] call MFUNC(_getUnits); }
    , _fobs apply { [_x] call MFUNC(_getFobAssets); }
    , _fobs apply { [_x, Q(Helicopter)] call MFUNC(_getFobAssets); }
] params [
    Q(_units)
    , Q(_fixedWingAssets)
    , Q(_rotaryAssets)
];

[
    [_supplySlice] call KPLIB_fnc_linq_sum
    , [_ammoSlice] call KPLIB_fnc_linq_sum
    , [_fuelSlice] call KPLIB_fnc_linq_sum
    , KPLIB_resources_intel
    , KPLIB_enemy_awareness
    , KPLIB_enemy_strength
    , [_units apply { count _x; }] call KPLIB_fnc_linq_sum
    , [_rotaryAssets apply { count _x; }] call KPLIB_fnc_linq_sum
    , [_fixedWingAssets apply { count _x; }] call KPLIB_fnc_linq_sum
] params [
    Q(_supply)
    , Q(_ammo)
    , Q(_fuel)
    , Q(_intel)
    , Q(_enemyAwareness)
    , Q(_enemyStrength)
    , Q(_unitCount)
    , Q(_rotaryAssetCount)
    , Q(_fixedWingAssetCount)
];

if (_debug) then {
    [format ["[fn_hudDispatchSM_onReportFob] Fini: [_markerText, _supply, _ammo, _fuel, _intel, _unitCount, _rotaryAssetCount, _fixedWingAssetCount]: %1"
        , str [_markerText, _supply, _ammo, _fuel, _intel, _unitCount, _rotaryAssetCount, _fixedWingAssetCount]], "HUDDISPATCHSM", true] call KPLIB_fnc_common_log;
};

[
    [KPLIB_hud_fob_markerText, _markerText]
    , [KPLIB_hud_fob_supply, _supply]
    , [KPLIB_hud_fob_ammo, _ammo]
    , [KPLIB_hud_fob_fuel, _fuel]
    , [KPLIB_hud_fob_intel, _intel]
    , [KPLIB_hud_fob_enemyAwareness, _enemyAwareness]
    , [KPLIB_hud_fob_enemyStrength, _enemyStrength]
    , [KPLIB_hud_fob_unitCount, _unitCount]
    , [KPLIB_hud_fob_rotaryCount, _rotaryAssetCount]
    , [KPLIB_hud_fob_fixedWingCount, _fixedWingAssetCount]
];
