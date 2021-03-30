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

private _colorShadow = getArray (_config >> Q(colorShadow));
if (count _colorShadow == 4) then { _lnbFob setVariable [QMVAR(_colorShadow), _colorShadow]; };
// _lnbFob setVariable [QMVAR(_colorShadow), ]

if (_debug) then {
    [format ["[fn_hud_lnbFob_onLoad] Entering: [ctrlIDC _lnbFob, _colorShadow, idcLeft, idcRight, isNull _lnbFob, isNull _config]: %1"
        , str [ctrlIDC _lnbFob, _colorShadow, getNumber (_config >> 'idcLeft'), getNumber (_config >> 'idcRight')
            , isNull _lnbFob, isNull _config]], "HUD", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: with bits sketched in...
{
    _x params [
        [Q(_report), "", [""]]
        , [Q(_imagePath), "", [""]]
        , [Q(_color), [], [[]]]
    ];

    private _rowIndex = _lnbFob lnbAddRow [_report, ""];
    _lnbFob lnbSetTextRight [[_rowIndex, 0], _report];
    _lnbFob lnbSetPicture [[_rowIndex, 1], _imagePath];

    // Color with either the SHADOW attribute or with the given COLOR
    _color = _lnbFob getVariable [QMVAR(_colorShadow), _color];

    if (count _color == 4) then {
        _lnbFob lnbSetColor [[_rowIndex, 0], _color];
        _lnbFob lnbSetColorRight [[_rowIndex, 0], _color];
        _lnbFob lnbSetPictureColor [[_rowIndex, 1], _color];
    };

} forEach MVAR(_fobReport_sampleViewData);

if (_debug) then {
    ["[fn_hud_lnbFob_onLoad] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
