#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_ctrlsGrpSector_lblSectorText_onRefresh

    File: fn_hudSector_ctrlsGrpSector_lblSectorText_onRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes the SECTOR HUD SECTOR TEXT label control.

    Parameters:
        _lblSectorText - a sector label control to refresh [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
 */

private _debug = [
    [
        {MPARAM2(Sector,_ctrlsGrpSector_lblSectorText_onRefresh_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_lblSectorText), controlNull, [controlNull]]
];

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblSectorText_onRefresh] Entering: [isNull _lblSectorText]: %1"
        , str [isNull _lblSectorText]], "HUD", true] call KPLIB_fnc_common_log;
};

// Exit early when SECTOR TEXT is NULL
if (isNull _lblSectorText) exitWith {
    false;
};

([nil, KPLIB_hudDispatchSM_sectorReport_lnbSectorText_viewDataKeys] call MFUNC2(Sector,_getViewData)) params [
    [Q(_markerText), "", [""]]
    , [Q(_gridref), "", [""]]
    , [Q(_defendingColor), [0, 0, 0, 0], [[]]]
];

// Set the SECTOR TEXT attributes, entirely driven by the OVERLAY HASHMAP
_lblSectorText ctrlSetText toUpper (format ["%1 - %2", _gridref, _markerText]);
_lblSectorText ctrlSetTextColor _defendingColor;

_lblSectorText ctrlCommit 0;

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblSectorText_onRefresh] Fini: [ctrlIDC _lblSectorText]: %1"
        , str [ctrlIDC _lblSectorText]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
