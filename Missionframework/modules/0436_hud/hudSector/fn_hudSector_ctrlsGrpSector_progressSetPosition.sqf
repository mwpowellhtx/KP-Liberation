#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_ctrlsGrpSector_progressSetPosition

    File: fn_hudSector_ctrlsGrpSector_progressSetPosition.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-06-14 17:03:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Aligns the OPFOR front facing progress meter either LEFT or RIGHT depending
        on the server driven sector alignment.

    Parameters:
        _widthCoefficient - a width coefficient to use during alignment; positive aligns LEFT
            and reflects OPFOR control of a sector, whereas negative aligns RIGHT and reflects
            BLUFOR control of the sector [SCALAR, default: nil]
        _commitPeriod - a commit period [SCALAR, default: 0]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
        https://community.bistudio.com/wiki/progressSetPosition
        https://community.bistudio.com/wiki/ctrlPosition
        https://community.bistudio.com/wiki/ctrlSetPosition
        https://community.bistudio.com/wiki/ctrlSetPositionW
        https://community.bistudio.com/wiki/ctrlSetPositionX
        https://community.bistudio.com/wiki/random
        https://community.bistudio.com/wiki/ctrlCommit
 */

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
