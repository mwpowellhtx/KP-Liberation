#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_garrisonUI_openDialog

    File: fn_garrisonUI_openDialog.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 14:36:21
    Last Update: 2021-04-16 14:36:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Opens the garrison dialog.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

// TODO: TBD: not sure what the whole "garrison" menu is all about...
// TODO: TBD: I wonder too could this be a specialized case of another build menu?
// TODO: TBD: not worried about this aspect just yet, but perhaps eventually
// TODO: TBD: for now focused on simply, 'what is garrison' overall
// TODO: TBD: and/or adapting it to better suite a sector activation approach...
// TODO: TBD: not least of which obviously some 'placeholder' decisions were made, so we have gobs of room to make decisions here

// Create dialog
createDialog Q(KPLIB_garrisonUI);
disableSerialization;

// Dialog controls
private _dialog = findDisplay KPLIB_IDD_GARRISON_DIALOG;

private _ctrlLbSectors = _dialog displayCtrl KPLIB_IDC_GARRISON_GARRISONLIST;

private _ctrlNameTitle = _dialog displayCtrl KPLIB_IDC_GARRISON_SECTORNAME;
private _ctrlAlertNote = _dialog displayCtrl KPLIB_IDC_GARRISON_ALERTNOTE;

private _ctrlInfLabel = _dialog displayCtrl KPLIB_IDC_GARRISON_INFANTRYLABEL;
private _ctrlInfAmount = _dialog displayCtrl KPLIB_IDC_GARRISON_INFANTRYAMOUNT;
private _ctrlInfBox = _dialog displayCtrl KPLIB_IDC_GARRISON_INFANTRYBOX;
private _ctrlInfButton = _dialog displayCtrl KPLIB_IDC_GARRISON_INFANTRYBUTTON;

private _ctrlLightLabel = _dialog displayCtrl KPLIB_IDC_GARRISON_LIGHTLABEL;
private _ctrlLightAmount = _dialog displayCtrl KPLIB_IDC_GARRISON_LIGHTAMOUNT;
private _ctrlLightList = _dialog displayCtrl KPLIB_IDC_GARRISON_LIGHTLIST;
private _ctrlLightButton = _dialog displayCtrl KPLIB_IDC_GARRISON_LIGHTBUTTON;

private _ctrlHeavyLabel = _dialog displayCtrl KPLIB_IDC_GARRISON_HEAVYLABEL;
private _ctrlHeavyAmount = _dialog displayCtrl KPLIB_IDC_GARRISON_HEAVYAMOUNT;
private _ctrlHeavyList = _dialog displayCtrl KPLIB_IDC_GARRISON_HEAVYLIST;
private _ctrlHeavyButton = _dialog displayCtrl KPLIB_IDC_GARRISON_HEAVYBUTTON;

private _ctrlMap = _dialog displayCtrl KPLIB_IDC_GARRISON_MAP;

private _ctrlReinforceTitle = _dialog displayCtrl KPLIB_IDC_GARRISON_REINFORCETITLE;
private _ctrlGroupsLabel = _dialog displayCtrl KPLIB_IDC_GARRISON_GROUPSLABEL;
private _ctrlLbGroups = _dialog displayCtrl KPLIB_IDC_GARRISON_GROUPLIST;
private _ctrlGroupButton = _dialog displayCtrl KPLIB_IDC_GARRISON_GROUPBUTTON;
private _ctrlUnitsLabel = _dialog displayCtrl KPLIB_IDC_GARRISON_UNITSLABEL;
private _ctrlLbUnits = _dialog displayCtrl KPLIB_IDC_GARRISON_UNITLIST;
private _ctrlUnitButton = _dialog displayCtrl KPLIB_IDC_GARRISON_UNITBUTTON;

private _ctrlsToHide = [
    _ctrlAlertNote,
    _ctrlInfLabel,
    _ctrlInfAmount,
    _ctrlInfBox,
    _ctrlInfButton,
    _ctrlLightLabel,
    _ctrlLightAmount,
    _ctrlLightList,
    _ctrlLightButton,
    _ctrlHeavyLabel,
    _ctrlHeavyAmount,
    _ctrlHeavyList,
    _ctrlHeavyButton,
    _ctrlMap,
    _ctrlReinforceTitle,
    _ctrlGroupsLabel,
    _ctrlLbGroups,
    _ctrlGroupButton,
    _ctrlUnitsLabel,
    _ctrlLbUnits,
    _ctrlUnitButton
];

// Hide some dialog elements, as no sector is selected at this point
{ _x ctrlShow false; } forEach _ctrlsToHide;

// Generate local sector list
private _sectors = KPLIB_sectors_blufor apply {[markerText _x, _x]};
_sectors sort true;

// Add sectors to listbox
lbClear _ctrlLbSectors;
{
    _ctrlLbSectors lbSetData [_ctrlLbSectors lbAdd (_x select 0), _x select 1];
    // TODO: TBD: this whole thing is going to change in the direction of client/server
    if !(([_x select 1, true] call MFUNC(_getGarrison)) isEqualTo []) then {
        _ctrlLbSectors lbSetColor [_forEachIndex, [0.8, 0, 0, 1]];
    };
} forEach _sectors;
_ctrlLbSectors lbSetCurSel -1;

true;
