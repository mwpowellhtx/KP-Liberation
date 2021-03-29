
// ...
// https://community.bistudio.com/wiki/getOrDefault

private _debug = KPLIB_param_enemyDebug;

params [
    ["_attribute", "", [""]]
    , ["_fromState", "", [""]]
    , ["_toState", "", [""]]
    , ["_comparison", KPLIB_preset_enemy_greaterOrEqual, [true]]
];

// TODO: TBD: could do some serious refactoring in the ENEMY module, but for now this will suffice...

// Establish a default threshold should FROM or TO states be out of alignment
[
    [_attribute, _comparison] apply { toLower _x }
    , [KPLIB_preset_enemy_awareness, KPLIB_preset_enemy_lessOrEqual] apply { toLower _x }
    , [KPLIB_preset_enemy_strength, KPLIB_preset_enemy_lessOrEqual] apply { toLower _x }
    , KPLIB_param_enemy_maxAwareness
    , KPLIB_param_enemy_maxStrength
] params [
    "_attributeComparison"
    , "_awarenessLessOrEqual"
    , "_strengthLessOrEqual"
    , "_maxAwareness"
    , "_maxStrength"
];

// Depending on the direction of the request, i.e. '>=' or '<='
private _default = switch (true) do {
    case (_attributeComparison isEqualTo _awarenessLessOrEqual): { _maxAwareness; };
    case (_attributeComparison isEqualTo _strengthLessOrEqual): { _maxStrength; };
    default {
        0;
    };
};

private _delim = KPLIB_preset_enemy_thresholdDelim;

KPLIB_preset_enemy_thresholdMap getOrDefault [
    [toLower _attribute, toLower _fromState, toLower _toState] joinString _delim
    , _default
];
