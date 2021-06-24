#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_core_getVehiclePositions

    File: fn_core_getVehiclePositions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-31 10:12:12
    Last Update: 2021-06-23 13:16:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the POSITIONS that the VEHICLE supports. This can be an indication
        whether the vehicle supports actual crew. Not to be confused with the engine
        'crew' command, which can lead to false positives when applied to MAN objects.

    Parameter(s):
        _vehicle - a VEHICLE which positions to consider [OBJECT, default: objNull]
        _type - the TYPE of position being considered [STRING, default: 'cargo']
        _includeEmpty - whether to include EMPTY positions [BOOL, default: false]
        _predicate - an optional FILTER to predicate the result [CODE, default: {true}]

    Returns:
        Function reached the end [BOOL]

    References:
        https://community.bistudio.com/wiki/crew
        https://community.bistudio.com/wiki/fullCrew
 */

params [
    ["_vehicle", objNull, [objNull]]
    , ["_type", "cargo", [""]]
    , ["_includeEmpty", false, [false]]
    , ["_predicate", {true}, [{}]]
];

if (isNull _vehicle) exitWith { []; };

private _positions = fullCrew [_vehicle, _type, _includeEmpty];

_positions select { _x call _predicate; };
