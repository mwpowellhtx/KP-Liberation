#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_missionsMgr_lnbMissions_onRefresh

    File: fn_missionsMgr_lnbMissions_onRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the MISSIONS LISTNBOX refreshes, 'onRefresh'.

    Parameter(s):
        _lnbMissions - the MISSIONS LISTNBOX control being refreshed [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/createDialog
 */

private _debug = [
    [
        {MPARAM(_lnbMissions_onRefresh_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_lnbMissions), uiNamespace getVariable [QMVAR(_lnbMissions), controlNull], [controlNull]]
];

// TODO: TBD: assembly a default grid ref for purposes of zeroing
[
    _lnbMissions getVariable [QMVAR(_viewData), []]
    , KPLIB_zeroPosGridrefDash
    , KPLIB_timers_defaultComponentString
    , [KPLIB_mission_status_standby] call KPLIB_fnc_mission_getStatusReport
] params [
    Q(_viewData)
    , Q(_defaultGridref)
    , Q(_defaultTimerString)
    , Q(_defaultStatusReport)
];

if (_debug) then {
    [format ["[fn_missionsMgr_lnbMissions_onRefresh] Entering: [count _viewData, _viewData]: %1"
        , str [count _viewData, _viewData]], "MISSIONSMGR", true] call KPLIB_fnc_common_log;
};

private _previousIndex = lnbCurSelRow _lnbMissions;

lnbClear _lnbMissions;

{
    // Do a bit of verification of the data we expect in the view
    _x params [
        [Q(_rowViewData), [], [[]]]
        , [Q(_rowData), "", [""]]
    ];

    if (_debug) then {
        [format ["[fn_missionsMgr_lnbMissions_onRefresh] Adding mission: [_forEachIndex, _rowViewData, _rowData]: %1"
            , str [_forEachIndex, _rowViewData, _rowData]], "MISSIONSMGR", true] call KPLIB_fnc_common_log;
    };

    // TODO: TBD: may include a default icon+image...
    _rowViewData params [
        [Q(_icon), "", [""]]
        , [Q(_title), "", [""]]
        , [Q(_gridref), _defaultGridref, [""]]
        , [Q(_timerString), _defaultTimerString, [""]]
        , [Q(_statusReport), _defaultStatusReport, [""]]
    ];

    private _rowIndex = _lnbMissions lnbAddRow ["", _title, _gridref, _timerString, _statusReport];

    if (!(_icon isEqualTo "")) then {
        _lnbMissions lnbSetPicture [[_rowIndex, 0], _icon];
    };

    _lnbMissions lnbSetData [[_rowIndex, 0], _rowData];

} forEach _viewData;

private _size = (lnbSize _lnbMissions)#0;

// Re-set the selection or truncate as needs be
_lnbMissions lnbSetCurSelRow (_previousIndex min (_size - 1));

if (_debug) then {
    [format ["[fn_missionsMgr_lnbMissions_onRefresh] Fini: [_previousIndex, _size]: %1"
        , str [_previousIndex, _size]], "MISSIONSMGR", true] call KPLIB_fnc_common_log;
};

true;
