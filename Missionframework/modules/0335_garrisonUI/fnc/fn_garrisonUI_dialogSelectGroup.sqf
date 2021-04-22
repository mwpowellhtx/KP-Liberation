#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_garrisonUI_dialogSelectGroup

    File: fn_garrisonUI_dialogSelectGroup.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 14:23:49
    Last Update: 2021-04-16 14:23:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Fetches and displays information of a group selected in the garrison group list.

    Parameter(s):
        _ctrl - the LISTNBOX control [CONTROL, default: controlNull]
        _selectedIndex - a selected index [NUMBER, default: -1]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_ctrl), controlNull, [controlNull]]
    , [Q(_selectedIndex), -1, [0]]
];

// Exit if no parameters passed
if (_selectedIndex isEqualTo -1) exitWith {
    false;
};

// Dialog controls
private _dialog = findDisplay KPLIB_IDD_GARRISON_DIALOG;
private _ctrlMap = _dialog displayCtrl KPLIB_IDC_GARRISON_MAP;
private _ctrlGroupButton = _dialog displayCtrl KPLIB_IDC_GARRISON_GROUPBUTTON;
private _ctrlLbUnits = _dialog displayCtrl KPLIB_IDC_GARRISON_UNITLIST;
private _ctrlUnitButton = _dialog displayCtrl KPLIB_IDC_GARRISON_UNITBUTTON;

// Get selected group details
MVAR(_dialogSelGroup) = [(MVAR(_dialogGroups) select _selectedIndex) select 1, []];
{
    (MVAR(_dialogSelGroup) select 1) pushBackUnique ([objectParent _x, _x] select (isNull objectParent _x));
} forEach (units (MVAR(_dialogSelGroup) select 0));

// Create a marker for the selected group
deleteMarkerLocal "grpMarker";
private _grpMarker = createMarkerLocal ["grpMarker", getPos (leader (MVAR(_dialogSelGroup) select 0))];
_grpMarker setMarkerTextLocal (groupId (MVAR(_dialogSelGroup) select 0));
_grpMarker setMarkerShapeLocal "ICON";
_grpMarker setMarkerTypeLocal "mil_dot";
_grpMarker setMarkerColorLocal KPLIB_preset_colorF;

// Center map on selected group
_ctrlMap ctrlMapAnimAdd [0, 0.025, getMarkerPos "grpMarker"];
ctrlMapAnimCommit _ctrlMap;

// Enable group button and fill group units list
_ctrlGroupButton ctrlEnable true;
lbClear _ctrlLbUnits;
{
    _ctrlLbUnits lbAdd (getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName"));
} forEach (MVAR(_dialogSelGroup) select 1);
_ctrlLbUnits lbSetCurSel -1;

true;
