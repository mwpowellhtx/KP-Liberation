#include "..\ui\defines.hpp"
#include "script_component.hpp"

// // TODO: TBD: do not need or want all of these references here...
// // TODO: TBD: in fact distribute them among the appropriate new files...
// // TODO: TBD: just putting this here or now as a catch all scratch pad
// https://community.bistudio.com/wiki/BIS_fnc_sortBy
// https://community.bistudio.com/wiki/CT_CONTROLS_GROUP
// https://community.bistudio.com/wiki/CT_STATIC
// https://community.bistudio.com/wiki/Arma:_GUI_Configuration
// https://community.bistudio.com/wiki/User_Interface_Event_Handlers
// https://community.bistudio.com/wiki/FXY_File_Format#Available_Fonts
// https://forums.bohemia.net/forums/topic/184295-list-of-all-fonts-supported-in-dialogs
// https://forums.bohemia.net/forums/topic/197928-displaying-rsctitles-from-descriptionext
// https://community.bistudio.com/wiki/cutFadeOut
// https://community.bistudio.com/wiki/configHierarchy
// https://community.bistudio.com/wiki/config_/_name
// https://community.bistudio.com/wiki/configName
// https://community.bistudio.com/wiki/getText
// https://community.bistudio.com/wiki/ctrlShow
// https://community.bistudio.com/wiki/createHashMap
// https://community.bistudio.com/wiki/config_greater_greater_name
// https://community.bistudio.com/wiki/Category:Arma_3:_Scripting_Commands

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

_action = toLower _action;

private _getOverlayHashMap = {
    params [
        [Q(_player), objNull, [objNull]]
        , [Q(_overlayReport), [], [[]]]
    ];

    // TODO: TBD: we might be able to createHashMapFromArray, but do not trust it not to be a memory leak
    // TODO: TBD: plus for the primary reasons that we want to (re-)populate the hash map with new report
    private _overlayHashMap = _player getVariable [QMVAR(_overlayHashMap), createHashMap];

    {
        // Value is usually STRING, but it may be anything, i.e. ARRAY for COLOR, etc, as appropriate
        _x params [
            [Q(_variableName), "", [""]]
            , Q(_value)
        ];
        if (_debug) then {
            [format ["[fn_hud_onStatusReport::_getOverlayHashMap] [_variableName, _value]: %1"
                , str [_variableName, _value]], "HUD", true] call KPLIB_fnc_common_log;
        };
        _overlayHashMap set [_variableName, _value];
    } forEach _overlayReport;

    // Set the variable and return with it
    _player setVariable [QMVAR(_overlayHashMap), _overlayHashMap];
    _overlayHashMap;
};

private _onCutRsc = {
    params [
        [Q(_className), "", [""]]
    ];

    private _effect = Q(PLAIN);
    private _speed = -1;
    private _showInMap = false;

    if (_className isEqualTo "") exitWith { false; };

    if (_debug) then {
        [format ["[fn_hud_onStatusReport::_onCutRsc] [_className, _effect, _speed, _showInMap]: %1"
            , str [_className, _effect, _speed, _showInMap]], "HUD", true] call KPLIB_fnc_common_log;
    };

    // Just cut the resource in, we will also respond to the respective 'onLoad' event
    cutRsc [_className, _effect, _speed, _showInMap];
    true;
};

// TODO: TBD: do we need to signal one way or the other?
private _lastStatusReportAction = _player getVariable [QMVAR(_lastStatusReportAction), ""];

// Cut resource in when appropriate, then leave it alone unless otherwise required
if (!(_action isEqualTo _lastStatusReportAction)) then {

    // And close the loop on said action in front of the next passthrough
    _player setVariable [QMVAR(_lastStatusReportAction), _action];

    switch (_action) do {
        // Cut in the BLANK one and that is all
        case (MVAR(_action_overlayBlank)): {
            // // (Re-)set the state for the next iterations
            //_player setVariable [QMVAR(_lastStatusReportAction), nil];
            [MOVERLAY(_blank)] call _onCutRsc;
        };

        // Cut in the OVERLAY and then we get to work...
        case (MVAR(_action_overlayReport)): {
            [MOVERLAY(_overlay)] call _onCutRsc;
        };
    };
};

if (_action isEqualTo MVAR(_action_overlayReport)) then {

    [_player, _overlayReport] call _getOverlayHashMap;

    [
        [_player, MSTATUS(_sector)] call MFUNC(_checkPlayerStatus)
        , [_player, MSTATUS(_fob)] call MFUNC(_checkPlayerStatus)
    ] params [
        Q(_sector)
        , Q(_fob)
    ];

    if (_debug) then {
        [format ["[fn_hud_onStatusReport] Status report: [_sector, _fob]: %1"
            , str [_sector, _fob]], "HUD", true] call KPLIB_fnc_common_log;
    };

    // // TODO: TBD: see if this would work, or do we need to touch ALL of the controls individually?
    // // Show (or hide) the groups as a group
    // [_player, KPLIB_IDD_HUD_OVERLAY, KPLIB_IDC_HUD_GRPSECTOR, { (_this#2) ctrlShow _sector; }] call MFUNC(_ctrlChangeWhen);
    // [_player, KPLIB_IDD_HUD_OVERLAY, KPLIB_IDC_HUD_GRPFOB, { (_this#2) ctrlShow _fob; }] call MFUNC(_ctrlChangeWhen);

    // // TODO: TBD: rinse and repeat to consider: strings, scalar, etc...
    // // TODO: TBD: that or we consider rendering at a different moment...
    // // TODO: TBD: perhaps landing in the HASH MAP ...
    // if (_sector) then {
    //     {
    //         [_player, KPLIB_IDD_HUD_OVERLAY, _x] call MFUNC(_ctrlSetText);
    //     } forEach MVAR(_sectorOverlayIdcsToSet);
    // };

    if (_fob) then {
        {
            [_player, KPLIB_IDD_HUD_OVERLAY, _x] call MFUNC(_ctrlSetText);
        } forEach MVAR(_fobOverlayIdcsToSet);
    };
};

if (_debug) then {
    ["[fn_hud_onStatusReport] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
