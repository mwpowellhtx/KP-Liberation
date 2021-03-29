#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_ctrlBase_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_ctrl), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

if (_debug) then {
    [format ["[fn_hud_ctrlBase_onLoad] Entering: [isNull _ctrl, isNull _config]: %1"
        , str [isNull _ctrl, isNull _config]], "HUD", true] call KPLIB_fnc_common_log;
};

// Relay the HASH MAP KEY to the CTRL for use when coordinating with the OVERLAY HASH MAP
private _registerHashMapMetaKeys = {
    params [
        [Q(_ctrl), controlNull, [controlNull]]
        , [Q(_config), configNull, [configNull]]
        , [Q(_attributeName), "", [""]]
        , [Q(_variableName), "", [""]]
    ];
    private _attributeConfig = (_config >> _attributeName);
    if (!isNull _attributeConfig) then {
        // Remember this is not the report value yet it is JUST the KEY to the report value
        _ctrl setVariable [_variableName, getText _attributeConfig];
    };
};

// Rinse and repeat for as many bits as we have wired up via meta config
[_ctrl, _config, Q(hashMapKey), QMVAR(_hashMapKey)] call _registerHashMapMetaKeys;
[_ctrl, _config, Q(hashMapColorKey), QMVAR(_hashMapColorKey)] call _registerHashMapMetaKeys;

if (_debug) then {

    private _hashMapKey = _ctrl getVariable [QMVAR(_hashMapKey), ""];
    private _hashMapColorKey = _ctrl getVariable [QMVAR(_hashMapColorKey), ""];

    [format ["[fn_hud_ctrlBase_onLoad] Fini: [ctrlIDC _ctrl, _hashMapKey, _hashMapColorKey]: %1"
        , str [ctrlIDC _ctrl, _hashMapKey, _hashMapColorKey]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
