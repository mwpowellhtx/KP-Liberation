#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_resources_setupTransportActions

    File: fn_resources_setupTransportActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-27 18:05:29
    Last Update: 2021-05-27 18:05:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges actions on the TRANSPORT object.

    Parameter(s):
        _object - a TRANSPORT object for which to arrange actions [OBJECT, default: objNull]

    Returns:
        The callback has finished [BOOL]
 */

params [
    [Q(_object), objNull, [objNull]]
];

// TODO: TBD: should be refactored as a proper preset var...
private _transportColor = "#ffff00";
private _transportRange = 10;

[
    _nearTransport
    , [
        "STR_KPLIB_ACTION_UNLOAD_ALL_RESOURCES"
        , { [(_this#0)] call KPLIB_fnc_resources_unloadCrate; }
        , []
        , -500
        , false
        , true
        , ""
        , "(_target getVariable ['KPLIB_resources_usedSlots', 0]) > 0"
        , _transportRange
    ]
    , [[Q(varName), QMVAR(_unloadAllResourcesID)], [Q(_color), _transportColor]]
] call KPLIB_fnc_common_addAction;

true;
