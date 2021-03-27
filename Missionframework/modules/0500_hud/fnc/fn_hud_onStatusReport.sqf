#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/createHashMapFromArray
// https://community.bistudio.com/wiki/Category:Command_Group:_HashMap
// https://community.bistudio.com/wiki/cutRsc
// https://community.bistudio.com/wiki/Title_Effect_Type

private _debug = [
    [
        {MPARAM(_onStatusReport_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_action), MVAR(_overlayBlank), [""]]
    , [Q(_overlayReport), [], [[]]]
];

if (_debug) then {
    [format ["[fn_hud_onStatusReport] Entering: [_action, count _overlayReport]: %1"
        , str [_action, count _overlayReport]], "HUD", true] call KPLIB_fnc_common_log;
};

private _className = switch (toLower _action) do {
    case (MVAR(_overlayBlank)): { MOVERLAY(_blank); };
    case (MVAR(_overlayReport)): { MOVERLAY(_overlay); };
    default { ""; };
};

private _effect = Q(PLAIN);
private _speed = -1;
private _showInMap = false;

if (_debug) then {
    [format ["[fn_hud_onStatusReport] On cutRsc: [_className, _effect, _speed, _showInMap]: %1"
        , str [_className, _effect, _speed, _showInMap]], "HUD", true] call KPLIB_fnc_common_log;
};

if (!(_className isEqualTo "")) then {
    // Just cut the resource in, we will also respond to the respective 'onLoad' event
    cutRsc [_className, _effect, _speed, _showInMap];
};

// // Use the hash map to better comprehend what is going on
// private _overlayHashMap = createHashMapFromArray _overlayReport;

if (_debug) then {
    ["[fn_hud_onStatusReport] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
