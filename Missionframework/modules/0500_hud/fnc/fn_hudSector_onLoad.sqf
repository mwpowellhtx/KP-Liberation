#include "script_component.hpp"

// ...
// TODO: TBD: using cutRsc, no opportunity for onUnload...
// https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
// https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload

private _debug = [
    [
        {MPARAM2(Sector,_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_display), displayNull, [displayNull]]
    // TODO: TBD: note, we have to 'help' provide the CONFIG for the DISPLAY because A3 does not do so for this particular event
    , [Q(_config), configNull, [configNull]]
];

// Lift the CLASS NAME back from the DISPLAY instance itself
_display setVariable [QMVAR(_className), (configName _config)];
private _className = _display getVariable [QMVAR(_className), ""];

if (_debug) then {
    [format ["[fn_hudSector_onLoad] Entering: [isNull _display, isNull _config, _className]: %1"
        , str [isNull _display, isNull _config, _className]], "HUD", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: may need to separate SECTOR from FOB overlays...
// Clear off FOB, SECTOR and SHADOW elements when BLANK
if (toLower _className find MVAR2(Sector,_action_blank) > 0) then {
    { uiNamespace setVariable [_x, nil]; } forEach [
        QMVAR2(Sector,_ctrlsGrpSector)
        , QMVAR2(Sector,_ctrlsGrpSectorConfig)
        , QMVAR2(Sector,_ctrlsGrpSector_lblTimer)
        , QMVAR2(Sector,_ctrlsGrpSector_lblTimerConfig)
        , QMVAR2(Sector,_ctrlsGrpSector_lblSectorText)
        , QMVAR2(Sector,_ctrlsGrpSector_lblSectorTextConfig)
        , QMVAR2(Sector,_ctrlsGrpSector_lblPbOpfor)
        , QMVAR2(Sector,_ctrlsGrpSector_lblPbOpforConfig)
        , QMVAR2(Sector,_ctrlsGrpSectorBackground)
        , QMVAR2(Sector,_ctrlsGrpSectorBackgroundConfig)
        , QMVAR2(Sector,_ctrlsGrpSectorBackground_lblPbBlufor)
        , QMVAR2(Sector,_ctrlsGrpSectorBackground_lblPbBluforConfig)
    ];
    true;
};

if (_debug) then {

    systemChat format ["[fn_hudSector_onLoad] [ctrlIDD _display, _className]: %1"
        , str [ctrlIDD _display, _className]];

    [format ["[fn_hudSector_onLoad] Fini: [ctrlIDD _display, _className]: %1"
        , str [ctrlIDD _display, _className]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
