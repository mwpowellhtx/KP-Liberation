#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_lnbMissions_onLoad

    File: fn_missionsMgr_lnbMissions_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the MISSIONS LISTNBOX opens, 'onLoad'.

    Parameter(s):
        _lnbMissions - the MISSIONS LISTNBOX control opened [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/createDialog
 */

params [
    [Q(_lnbMissions), uiNamespace getVariable [QMVAR(_lnbMissions), controlNull], [controlNull]]
];

private _viewData = _lnbMissions getVariable [QMVAR(_viewData), []];

private _previousIndex = lnbCurSelRow _lnbMissions;

lnbClear _lnbMissions;

{
    // Do a bit of verification of the data we expect in the view
    _x params [
        [Q(_rowViewData), [], [[]]]
        , [Q(_rowData), [], [[]], 2]
    ];

    _rowViewData params [
        [Q(_icon), "", [""]]
        , [Q(_name), "", [""]]
        , [Q(_isTemplateText), "", [""]]
        , [Q(_isRunningText), "", [""]]
    ];

    _rowData params [
        [Q(_uuid), "", [""]]
        , [Q(_templateUuid), "", [""]]
    ];

    private _rowIndex = _lnbMissions lnbAddRow ["", _name, _isTemplateText, _isRunningText];
    if (!(_icon isEqualTo "")) then {
        _lnbMissions lnbSetPicture [[_rowIndex, 0], _icon];
    };
    _lnbMissions lnbSetData (str _rowData);

} forEach _viewData;

private _size = (lnbSize _lnbMissions)#0;

// Re-set the selection or truncate as needs be
_lnbMissions lnbSetCurSelRow (_previousIndex min (_size - 1));

true;
