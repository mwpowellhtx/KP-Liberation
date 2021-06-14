#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_onUpdateDisposition

    File: fn_enemies_onUpdateDisposition.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-15 14:17:26
    Last Update: 2021-06-14 17:17:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Periodically updates the DISPOSITION between factions based on key
        AWARENESS, STRENGTH, and CIVILIAN REPUTATION ratios.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/Side_relations
        https://community.bistudio.com/wiki/setFriend
        https://community.bistudio.com/wiki/setCaptive
        https://community.bistudio.com/wiki/addRating
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitUntilAndExecute-sqf.html
        https://en.wikipedia.org/wiki/Analogy#Logic
 */

// SIDES for shorthand use throughout
[
    KPLIB_preset_sideF
    , KPLIB_preset_sideE
    , KPLIB_preset_sideR
    , KPLIB_preset_sideC
] params [
    Q(_f)
    , Q(_e)
    , Q(_r)
    , Q(_c)
];

[
    1
    , 0.6
    , MVAR(_awareness) / MPARAM(_maxAwareness)
    , MVAR(_strength) / MPARAM(_maxStrength)
    , MVAR(_civRep) / KPLIB_param_civilian_maxCivRep
    , MPARAM(_civRepBaseThreshold)
] params [
    Q(_forValue)
    , Q(_neutralDis)
    , Q(_awarenessRatio)
    , Q(_strengthRatio)
    , Q(_civRepRatio)
    , Q(_civRepBaseThreshold)
];

[] params [
    [Q(_friendlyEnemyValue), 0, [0]]
    , [Q(_enemyFriendlyValue), 0, [0]]
];

// // TODO: TBD: need to also consider civilian/resistance relations...
// // TODO: TBD: should either be staunchly 'for' blufor/opfor, or not...
// [
//     _neutralDis + ((1 - _neutralDis) * _awarenessRatio * _strengthRatio)
//     , _neutralDis - (_neutralDis * _awarenessRatio * _strengthRatio)
// ] params [
//     Q(_friendlyEnemyValue)
//     , Q(_enemyFriendlyValue)
// ];

// We bundle this in a CALL because it does not make sense to separate the logic
private _resValues = [_neutralDis, _civRepRatio, PCT(_civRepBaseThreshold)] call {
    params [
        [Q(_neutral), 0, [0]]
        , [Q(_civRep), 0, [0]]
        , [Q(_baseThreshold), 0, [0]]
    ];

    // Here we do want the ABS for DIS[position] calculation purposes
    [
        _neutral + ((1 - _neutral) * (abs _civRep))
        , _neutral - (_neutral * (abs _civRep))
    ] params [
        Q(_forValue)
        , Q(_againstValue)
    ];

    /* In analogous terms, DISP[osition] one way or the other:
     * [BLUFOR:RESISTANCE](disp)::[OPFOR:RESISTANCE](!disp)
     * [RESISTANCE:BLUFOR](disp)::[RESISTANCE:OPFOR](!disp)
     *
     * Response is: [_friendlyResValue, _enemyResValue]
     */
    switch (true) do {
        case (_civRep >= _baseThreshold):   { [_forValue, _againstValue];   };
        case (_civRep <= -_baseThreshold):  { [_againstValue, _forValue];   };
        default                             { [_neutral, _neutral];         };
    };
};

_resValues params [
    Q(_friendlyResValue)
    , Q(_enemyResValue)
];

{
    _x params [
        [Q(_side), _f, [sideEmpty]]
        , [Q(_args), [], [[]]]
    ];

    // Verify the arguments are correct
    _args params [
        [Q(_withSide), _e, [sideEmpty]]
        , [Q(_value), _neutralDis, [0]]
    ];

    _side setFriend [_withSide, _value];

} forEach [
    // FRIENDLY disp, careful of RESISTANCE DISPOSITION
    [_f, [_f, _forValue]]
    , [_f, [_c]]
    , [_f, [_e, _friendlyEnemyValue]]
    , [_f, [_r, _friendlyResValue]]
    // ENEMY disp, careful of RESISTANCE DISPOSITION
    , [_e, [_e, _forValue]]
    , [_e, [_c]]
    , [_e, [_f, _enemyFriendlyValue]]
    , [_e, [_r, _enemyResValue]]
    // CIVILIAN disp, are in theory 'neutral' to everyone
    , [_c, [_c]]
    , [_c, [_r]]
    , [_c, [_f]]
    , [_c, [_e]]
    // RESISTANCE disp, DISPOSITION 'same' toward each FRIENDLY+ENEMY
    , [_r, [_r]]
    , [_r, [_c]]
    , [_r, [_f, _friendlyResValue]]
    , [_r, [_e, _enemyResValue]]
];

// Finally PASS BATON as long as CAMPAIGN RUNNING
if (KPLIB_campaignRunning) then {
    [
        MFUNC(_onUpdateDisposition)
        , []
        , MPARAM(_updateDispositionPeriod)
    ] call CBA_fnc_waitAndExecute;
};

true;
