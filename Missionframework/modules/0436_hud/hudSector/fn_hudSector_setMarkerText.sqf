#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_setMarkerText

    File: fn_hudSector_setMarkerText.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-06 23:26:02
    Last Update: 2021-06-14 17:02:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets the SECTOR HUD MARKER TEXT.

    Parameters:
        NONE

    Returns:
        The callback has finished [BOOL]
 */

params [
    [Q(_markerText), "", [""]]
    , [Q(_blufor), false, [false]]
];

private _ctrlMap = uiNamespace getVariable [QMVAR(_ctrlMap), createHashMap];

// We do not necessarly need the CONFIG as long as we can relay the COLOR
private _ctrl = _ctrlMap getOrDefault ["lblMarkerText", controlNull];

private _meter = MPRESETUI(_meters) select 0;
private _meterCtrl = _ctrlMap getOrDefault [_meter, controlNull];
private _meterCtrlBg = _ctrlMap getOrDefault [format ["%1_bg", _meter], controlNull];

if (!isNull _ctrl) then {

    private _color = if (isNull _meterCtrl || isNull _meterCtrlBg) then {
        [1, 1, 1, 1];
    } else {
        private _colorCtrl = [_meterCtrlBg, _meterCtrl] select _blufor;
        _colorCtrl getVariable [QMVAR(_color), [1, 1, 1, 1]];
    };

    _ctrl ctrlSetTextColor _color;
    _ctrl ctrlSetText _markerText;
    _ctrl ctrlCommit 0;
};

true;
