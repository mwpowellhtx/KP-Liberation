#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_lnbBriefing_onRefresh

    File: fn_missionsMgr_lnbBriefing_onRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:33:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the BRIEFING TEXT should refresh.

    Parameter(s):
        _lnbBriefing - the BRIEFING TEXT control refreshed [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/ctrlSetStructuredText
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
 */

params [
    [Q(_lnbBriefing), uiNamespace getVariable [QMVAR(_lnbBriefing), controlNull], [controlNull]]
];

private _viewData = _lnbBriefing getVariable [QMVAR(_viewData), []];

lnbClear _lnbBriefing;

{
    _x params [
        [Q(_rowViewDatum), [], [[]]]
        , [Q(_rowData), "", [""]]
    ];
    private _rowIndex = _lnbBriefing lnbAddRow _rowViewDatum;
    _lnbBriefing lnbSetData [[_rowIndex, 0], _rowData]
} forEach _viewData;

true;
