// TODO: TBD: this is perhaps more of a common function...
#include "script_component.hpp"

// ...
// 'update' for lack of a better name... rename if we can think of a better one...
// _idd - a dialog identifier [SCALAR, default: 0]
// _idc - a control identifier, child of the same dialog [SCALAR, default: 0]
// _onChange - a callback applying either to the DISPLAY or CONTROL or both [CODE, default: {}]
// _when - a callback indicating WHEN the CHANGE may occur [CODE, default: {true}]

private _debug = [
    [
        {MPARAM(_ctrlChangeWhen_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_idd), 0, [0]]
    , [Q(_idc), 0, [0]]
    , [Q(_onChange), {}, [{}]]
    , [Q(_when), { true; }, [{}]]
];

private _display = findDisplay _idd;
if (isNull _display) exitWith { false; };

private _ctrl = _display displayCtrl _idc;
if (isNull _ctrl) exitWith { false; };

// Effect the CTRL CHANGE WHEN the condition is met
if ([_player, _display, _ctrl] call _when) then {
    [_player, _display, _ctrl] call _onChange;
};

true;
