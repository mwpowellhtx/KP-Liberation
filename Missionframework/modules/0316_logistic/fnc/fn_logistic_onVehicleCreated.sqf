/*
    KPLIB_fnc_logistic_onVehicleCreated

    File: fn_logistic_onVehicleCreated.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-27 18:35:46
    Last Update: 2021-05-27 18:35:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        VEHICLE CREATED event handler.

    Parameter(s):
        _object - the OBJECT being created [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    ["_object", objNull, [objNull]]
];

switch (typeOf _object) do {
    case KPLIB_logistic_building: {
        [_object] remoteExecCall ["KPLIB_fnc_logistic_setupBuildingActions", 0, _object];
    };
};

true;
