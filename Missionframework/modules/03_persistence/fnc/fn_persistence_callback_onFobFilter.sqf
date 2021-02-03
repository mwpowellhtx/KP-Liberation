/*
    KPLIB_fnc_persistence_callback_onFobFilter

    File: fn_persistence_callback_onFobFilter.sqf
    Author: Michael W. Powell
    Created: 2021-02-02 18:55:22
    Last Update: 2021-02-02 18:55:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Filters the _target object considering proximity to known FOB sites.

    Parameters:
        _target - the _target object being restored under persistent serialization [OBJECT, default: objNull]

    Returns:
        The _target when within range of a known FOB site; otherwise, objNull.
*/

params [
    ["_target", objNull, [objNull]]
];

if (!(([_target, KPLIB_fnc_eden_callback_onWithinRange] call KPLIB_fnc_eden_select) isEqualTo [])) exitWith {
    if (!(_target isKindOf "Man")) then {
        {deleteVehicle _x} forEach ((crew _target) select {!(isNull _x || _x isEqualTo _target)});
    };
    deleteVehicle _target;
    objNull;
};

_target
