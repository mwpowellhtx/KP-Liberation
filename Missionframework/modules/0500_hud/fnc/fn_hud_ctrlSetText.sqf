#include "..\ui\defines.hpp"
#include "script_component.hpp"

// ...
// _player - the player object for which OVERLAY STATUS REPORT is rooted [OBJECT, default: objNull]
// _idc - a control identifier, child of the same dialog [SCALAR, default: KPLIB_IDD_HUD_OVERLAY]
// _idd - a dialog identifier [SCALAR, default: 0]
// _render - render callback function, by default renders itself, i.e. STRING [CODE, default: { _this; }]
// _defaultValue - default value, prefers STRING, but may be anything [ANY, default: ""]

private _debug = [
    [
        {MPARAM(_ctrlSetText_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_idd), 0, [0]]
    , [Q(_idc), 0, [0]]
    , [Q(_defaultValue), ""]
];

// TODO: TBD: careful with this one, in context, we're talking about the same IDD whether BLANK or OVERLAY
private _display = findDisplay _idd;
// TODO: TBD: wiring through the namespace instead...
_display = uiNamespace getVariable [QMVAR(_display), displayNull];
private _ctrl = _display displayCtrl _idc;

if (_debug) then {
    [format ["[fn_hud_ctrlSetText] Entering: [_idd, _idc, isNull _display, isNull _ctrl]: %1"
        , str [_idd, _idc, isNull _display, isNull _ctrl]], "HUD", true] call KPLIB_fnc_common_log;
};

if (isNull _display || isNull _ctrl) exitWith {
    false;
};

[
    _player getVariable [QMVAR(_overlayHashMap), emptyHashMap]
    , _ctrl getVariable [QMVAR(_hashMapKey), ""]
    , _ctrl getVariable [QMVAR(_hashMapColorKey), ""]
] params [
    Q(_overlayHashMap)
    , Q(_hashMapKey)
    , Q(_hashMapColorKey)
];

[
    _defaultValue
    , [0, 0, 0, 0]
] params [
    Q(_text)
    , Q(_color)
];

// TODO: TBD: there may possibly be more meta here, but focus on the actual effort first
if (!(_hashMapKey isEqualTo "")) then {
    _text = _overlayHashMap getOrDefault [_hashMapKey, _defaultValue];
    _ctrl ctrlSetText toUpper _text;
};

if (!(_hashMapColorKey isEqualTo "")) then {
    _color = _overlayHashMap getOrDefault [_hashMapColorKey, [1, 1, 1, 1]];
    _ctrl ctrlSetTextColor _color;
};

// // TODO: TBD: probably do not need to commit the ctrl...
// _ctrl ctrlCommit 0;

if (_debug) then {
    [format ["[fn_hud_ctrlSetText] Fini: [_hashMapKey, _hashMapColorKey, _defaultValue, _text, _color]: %1"
        , str [_hashMapKey, _hashMapColorKey, _defaultValue, _text, _color]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
