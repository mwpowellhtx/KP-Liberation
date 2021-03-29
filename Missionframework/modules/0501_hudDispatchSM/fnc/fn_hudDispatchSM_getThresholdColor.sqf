#include "script_component.hpp"

// ...
// By default selects the FIRST available color for GE POSITIVE or GT NEGATIVE threshold

private _defaultComparison = {
    params [
        [Q(_target), 0, [0]]
        , [Q(_threshold), 0, [0]]
    ];
    (_threshold >= 0 && _target >= _threshold)
        || (_threshold < 0 && _target > _threshold);
};

params [
    [Q(_target), 0, [0]]
    , [Q(_thresholds), [], [[]]]
    , [Q(_default), [1, 1, 1, 1], [[]], 4]
    , [Q(_comparison), _defaultComparison, [{}]]
];

// TODO: TBD: hmm, we might even be able to do some math here...
// TODO: TBD: i.e. TARGET-THRESHOLD, and do some math, i.e. which is of least distance...
private _selected = _thresholds select { [_target, (_x#0)] call _comparison; };

if (count _selected > 0) exitWith { +(_selected#0#1); };
//                          _color:   ___________^^

_default;
