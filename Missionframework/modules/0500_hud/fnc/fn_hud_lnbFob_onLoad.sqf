#include "..\ui\defines.hpp"
#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_lnbFob_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_lnbFob), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

if (_debug) then {
    [format ["[fn_hud_lnbFob_onLoad] Entering: [isNull _lnbFob, isNull _config, idcLeft, idcRight]: %1"
        , str [isNull _lnbFob, isNull _config
            , getNumber (_config >> 'idcLeft'), getNumber (_config >> 'idcRight')]]
            , "HUD", true] call KPLIB_fnc_common_log;
};

// Configure the namespace bits and prepare to register
private _registerArgs = [getArray (_config >> Q(colorShadow))] call {
    params [
        [Q(_colorShadow), [], [[]]]
    ];

    if (_debug) then {
        [format ["[fn_hud_lnbFob_onLoad] Prepare: [_colorShadow]: %1"
            , str [_colorShadow]], "HUD", true] call KPLIB_fnc_common_log;
    };

    /* Set for purposes of STATUS REPORT later on. If the instance is around when a
     * next REPORT happens, then we attempt to use it. And if not, then we do not. */

    if (count _colorShadow == 4) exitWith {
        _lnbFob setVariable [QMVAR(_colorShadow), _colorShadow];
        [
            [QMVAR(_lnbFobShadow), _lnbFob]
            , [QMVAR(_lnbFobShadowConfig), _config]
        ];
    };

    [
        [QMVAR(_lnbFob), _lnbFob]
        , [QMVAR(_lnbFobConfig), _config]
    ];
};

{ uiNamespace setVariable _x; } forEach _registerArgs;

if (_debug) then {
    [format ["[fn_hud_lnbFob_onLoad] Refreshing: [ctrlIDC _lnbFob]: %1"
        , str [ctrlIDC _lnbFob]], "HUD", true] call KPLIB_fnc_common_log;
};

[_lnbFob, _config] call MFUNC(_lnbFob_onRefresh);

if (_debug) then {
    ["[fn_hud_lnbFob_onLoad] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
