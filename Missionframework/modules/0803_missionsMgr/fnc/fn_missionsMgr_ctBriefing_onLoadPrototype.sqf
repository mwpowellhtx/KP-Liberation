#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_ctBriefing_onLoadPrototype

    File: fn_missionsMgr_ctBriefing_onLoadPrototype.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-21 16:35:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the BRIEFING CT_CONTROLS_TABLE opens, 'onLoad'.

    Parameter(s):
        _ctBriefing - the BRIEFING CT_CONTROLS_TABLE control opened [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/createDialog
        https://community.bistudio.com/wiki/CT_CONTROLS_TABLE
 */

params [
    [Q(_ctBriefing), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

[] call {
    private _onLoadReport = format ["[fn_missionsMgr_ctBriefing_onLoadDummy]: [idc, x, y, w, h]: %1"
        , str ([Q(idc), Q(x), Q(y), Q(w), Q(h)] apply { getNumber (_config >> _x); })];
    //copyToClipboard _onLoadReport;
    systemChat _onLoadReport;
};

ctClear _ctBriefing;

// systemChat "adding header";
// ctAddHeader _ctBriefing params [Q(_headerIndex), Q(_header)];
// systemChat format ["adding header: [_headerIndex]: %1", str [_headerIndex]];
// _header params [Q(_ctrlHeaderBackground), Q(_ctrlHeaderColumn1), Q(_ctrlHeaderColumn2)];
// _ctrlHeaderBackground ctrlSetBackgroundColor [0, 0.3, 0.6, 1];
// _ctrlHeaderColumn1 ctrlSetText "Briefing";
// _ctrlHeaderColumn2 ctrlSetText "Description";

// TODO: TBD: interesting, with background, could do like a greenbar approach...
for "_i" from 0 to 2 do {
    systemChat format ["adding row: [_i]: %1", str [_i]];
    ctAddRow _ctBriefing params [Q(_rowIndex), Q(_row)];
    _row params [Q(_ctrlRowBackground), Q(_lblTitle), Q(_lblDescription)];
    //_ctrlRowBackground ctrlSetBackgroundColor [0.5, 0.5, 0.5, 1];
    _lblTitle ctrlSetText format ["_briefing: [_rowIndex, _i]: %1", str [_rowIndex, _i]];
    // _lblTitle ctrlSetTextColor [1, 1, 1, 1];
    _lblDescription ctrlSetText format ["_description: [_rowIndex, _i]: %1", str [_rowIndex, _i]];
    // _lblDescription ctrlSetTextColor [1, 1, 1, 1];
    systemChat format ["row added: [_rowIndex, _i, ctrlText _lblTitle, ctrlText _lblDescription, _row]: %1"
        , str [_rowIndex, _i, ctrlText _lblTitle, ctrlText _lblDescription, _row apply { ctrlIDC _x; }]];
};

true;
