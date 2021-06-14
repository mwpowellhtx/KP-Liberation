#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_setMeterPosition

    File: fn_hudSector_setMeterPosition.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-28 10:55:46
    Last Update: 2021-06-14 17:02:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets the FOREGROUND METER element position according to the ALPHACOUNT to BRAVOCOUNT
        RATIO. DIVISOR is the SUM of the ABS ALPHACOUNT plus the ABS BRAVOCOUNT, whereas DIVIDEND
        is the ALPHACOUNT, as-is. The METER element position is calculated as LEFT ALIGNED when
        ALPHACOUNT, or its RATIO, is POSITIVE; conversely, RIGHT ALIGNED when NEGATIVE, respectively.
        The BACKGROUND METER element is never adjusted, and is there simply to inform the meter XYHW
        DIMENSIONS, position, XY coordinates, [H]eight, and [W]idth, respectively. The METER argument
        selects which set of METERS is in view: 'units', 'tanks', 'civres', with background controls
        named, 'units_bg', 'tanks_bg', 'civres_bg', respectively.

        Mathematically, whatever the counts are, respectively, inform the relative positions of the
        foreground element with respect to the background element. Technically, either ALPHA or BRAVO
        COUNTS may be positive or negative, but typically we prefer that the ALPHACOUNT is conveyed
        as such. It just keeps the math simple, as well as that of the UI integration.

        Another major assumption is that we expect the UI components themselves to have been presented
        using the usual layered CUTRSC approaches. When the UI components are not present, then there is
        nothing further to display.

    Parameters:
        _meter - the METER selector [STRING, KPLIB_hudSectorUI_meters select 0]
        _alphaCount - the ALPHA foreground METER COUNT [SCALAR, default: 0]
        _bravoCount - the BRAVO opposition METER COUNT [SCALAR, default: 0]
        _alphaColor - an ALPHA foreground METER COLOR [RGBA, default: _defaultAlphaColor]
        _bravoColor - an BRAVO opposition METER COLOR [RGBA, default: _defaultBravoColor]

    Returns:
        The callback has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/ctrlEnable
 */

// private _defaultAlphaColor = [0, 0.3, 0.6, 1];
// private _defaultBravoColor = [0.5, 0, 0, 1];

private _defaultAlphaColor = [0, 0, 0.9, 1];
private _defaultBravoColor = [0.9, 0, 0, 1];

// TODO: TBD: formalize this in a preset...
private _defaultDisableColor = [0.65, 0.65, 0.65, 1];

params [
    [Q(_meter), MPRESETUI(_meters) select 0, [""]]
    , [Q(_alphaCount), [0], [0]]
    , [Q(_bravoCount), [0], [0]]
    , [Q(_alphaColor), _defaultAlphaColor, [[]], 4]
    , [Q(_bravoColor), _defaultBravoColor, [[]], 4]
    , [Q(_disabledColor), _defaultDisableColor, [[]], 4]
];

private _debug = MPARAM(_setMeterPosition_debug);

if (_debug) then {
    [format ["[fn_hudSector_setMeterPosition] Entering: [_meter, _alphaCount, _bravoCount]: %1"
        , str [_meter, _alphaCount, _bravoCount]], "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

private _ctrlMap = uiNamespace getVariable [QMVAR(_ctrlMap), createHashMap];

private _ctrl = _ctrlMap getOrDefault [toLower _meter, controlNull];
private _ctrlBg = _ctrlMap getOrDefault [format ["%1_bg", toLower _meter], controlNull];

if (_debug) then {
    [format ["[fn_hudSector_setMeterPosition] Controls: [isNull _ctrl, isNull _ctrlBg]: %1"
        , str [isNull _ctrl, isNull _ctrlBg]], "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

// Requires that BOTH foreground and background controls have been presented
if (isNull _ctrl || isNull _ctrlBg) exitWith { false; };

private _bgPos = ctrlPosition _ctrlBg;
private _maxWidth = _ctrl getVariable [QMVAR(_maxWidth), 0];

// Zero in either top or bottom can mean non sequitur, i.e. should not be seeing this case
private _ratio = if (_bravoCount == 0) then {
    _ctrl ctrlSetBackgroundColor _disabledColor;
    _ctrlBg ctrlSetBackgroundColor _disabledColor;
    _ctrlBg ctrlEnable false;
    0;
} else {
    _ctrl ctrlSetBackgroundColor _alphaColor;
    _ctrlBg ctrlSetBackgroundColor _bravoColor;
    _ctrlBg ctrlEnable true;
    _alphaCount / _bravoCount;
};

private _pos = +_bgPos;

_pos set [2, _maxWidth * (abs _ratio)];

if (_ratio < 0) then {
    _pos set [0, (_bgPos#0) + (_maxWidth * (1 + _ratio))]
};

if (_debug) then {
    [format ["[fn_hudSector_setMeterPosition] Commit: [_bgPos, _pos, _maxWidth, _ratio]: %1"
        , str [_bgPos, _pos, _maxWidth, _ratio]], "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

_ctrl ctrlSetPosition _pos;

_ctrl ctrlCommit 0;
_ctrlBg ctrlCommit 0;

true;
