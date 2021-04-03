#include "script_component.hpp"

// ...
// TODO: TBD: using cutRsc, no opportunity for onUnload...
// https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
// https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
// https://community.bistudio.com/wiki/progressSetPosition
// https://community.bistudio.com/wiki/ctrlPosition
// https://community.bistudio.com/wiki/ctrlSetPosition
// https://community.bistudio.com/wiki/ctrlSetPositionW
// https://community.bistudio.com/wiki/ctrlSetPositionX
// https://community.bistudio.com/wiki/random
// https://community.bistudio.com/wiki/ctrlCommit

private _debug = [
    [
        {MPARAM2(Sector,_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    Q(_widthCoefficient) // TODO: TBD: this only sort of works like the primitive...
    , [Q(_commitPeriod), 0, [0]]
];

[
    uiNamespace getVariable [QMVAR2(Sector,_ctrlsGrpSector_lblPbOpfor), controlNull]
    , uiNamespace getVariable [QMVAR2(Sector,_ctrlsGrpSectorBackground_lblPbBlufor), controlNull]
] params [
    Q(_lblPbOpfor)
    , Q(_lblPbBlufor)
];

// Cannot perform the operation when EITHER of the PROGRESS BARS is NULL
if (isNull _lblPbOpfor || isNull _lblPbBlufor) exitWith {
    false
};

[
    ctrlPosition _lblPbBlufor
    , _widthCoefficient < 0
    , 0 max ((abs _widthCoefficient) min 1)
] params [
    Q(_lblPbBluforPos)
    , Q(_blufor)
    , Q(_wCoef)
];

_lblPbBluforPos params [
    Q(_pbX)
    , Q(_pbY)
    , Q(_pbW)
    , Q(_pbH)
];

// Aligning the OPFOR control either LEFT or RIGHT depending on BLUFOR alignment
private _xOffset = if (!_blufor) then { 0; } else { _pbW - (_pbW * _wCoef); };

// The only control we are manipulating is the forward OPFOR control
_lblPbOpfor ctrlSetPosition [_pbX + _xOffset, _pbY, _pbW * _wCoef, _pbH];
_lblPbOpfor ctrlCommit _commitPeriod;

true;
