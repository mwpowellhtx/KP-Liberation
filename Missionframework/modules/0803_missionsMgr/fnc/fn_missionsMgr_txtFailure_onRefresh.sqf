#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_txtFailure_onRefresh

    File: fn_missionsMgr_txtFailure_onRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:33:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the FAILURE TEXT should refresh.

    Parameter(s):
        _txtFailure - the FAILURE TEXT control refreshed [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/ctrlSetStructuredText
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
 */

params [
    [Q(_txtFailure), uiNamespace getVariable [QMVAR(_txtFailure), controlNull], [controlNull]]
];

// TODO: TBD: may separate out a 'default text' value...
private _text = _txtFailure getVariable [QMVAR(_viewData), ""];

_txtFailure ctrlSetStructuredText (parseText _text);

true;
