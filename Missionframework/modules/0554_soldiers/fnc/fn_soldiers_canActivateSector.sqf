#include "script_component.hpp"
/*
    KPLIB_fnc_soldiers_canActivateSector

    File: fn_soldiers_canActivateSector.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-30 10:46:33
    Last Update: 2021-06-14 17:16:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether the UNIT may ACTIVATE a SECTOR. Not including PROXIMITY bits,
        only whether the UNIT himself may be included in the activation decision. This
        is a key heuristic which helps us preclude scenarios in which sectors continually
        change sides during prolonged engagements.

    Parameter(s):
        _unit - a UNIT object [OBJECT, default: objNull]

    Returns:
        Whether the UNIT may ACTIVATE a SECTOR [BOOL]
 */

params [
    [Q(_unit), objNull, [objNull]]
];

[
    isNull _unit
    , alive _unit
    , side _unit isEqualTo KPLIB_preset_sideF
    , side _unit isEqualTo KPLIB_preset_sideE
    , _unit getVariable [Q(KPLIB_reinforceMarker), ""]
] params [
    Q(_null)
    , Q(_alive)
    , Q(_blufor)
    , Q(_opfor)
    , Q(_reinforceMarker)
];

!_null
    && _alive
    && (
        _blufor
        || (_opfor && _reinforceMarker in KPLIB_sectors_all)
    )
;
