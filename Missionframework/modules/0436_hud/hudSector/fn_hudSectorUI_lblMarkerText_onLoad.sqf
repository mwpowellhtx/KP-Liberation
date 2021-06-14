#include "script_component.hpp"
/*
    KPLIB_fnc_hudSectorUI_lblMarkerText_onLoad

    File: fn_hudSectorUI_lblMarkerText_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-06 23:44:59
    Last Update: 2021-06-14 17:02:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        SECTOR HUD MARKER TEXT 'onLoad' event handler.

    Parameters:
        _ctrl - the CONTROL being loaded [CONTROL, default: controlNull]
        _config - the corresponding CONFIG being loaded [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
 */

params [
    [Q(_ctrl), controlNull, [controlNull]]
    // TODO: TBD: note, we have to 'help' provide the CONFIG for the DISPLAY because A3 does not do so for this particular event
    , [Q(_config), configNull, [configNull]]
];

private _debug = MPARAMUI(_lblMarkerText_onLoad_debug);

// We do not necessarily need the CONFIG, or BACKGROUND versions of the same
private _ctrlMap = uiNamespace getVariable [QMVAR(_ctrlMap), createHashMap];

_ctrlMap set [Q(lblMarkerText), _ctrl];
_ctrlMap set [Q(lblMarkerTextConfig), _config];

uiNamespace setVariable [QMVAR(_ctrlMap), _ctrlMap];

true;
