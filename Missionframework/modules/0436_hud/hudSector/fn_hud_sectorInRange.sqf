#include "script_component.hpp"
/*
    KPLIB_fnc_hud_sectorInRange

    File: fn_hud_sectorInRange.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-06-14 17:03:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the PLAYER is in range of the BRAVO marker. Depends
        upon the 'KPLIB_param_sectors_actRange' setting to determine whether
        there is a match.

    Parameters:
        _player - the player in the range question [OBJECT, default: objNull]
        _bravoMarker - the BRAVO marker in the question [STRING, default: ""]
        _range - the range in the question [SCALAR, default: KPLIB_param_sectors_actRange]

    Returns:
        Whether the BRAVO marker is in range of the PLAYER.

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsSet
 */

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_bravoMarker), "", [""]]
    , [Q(_range), KPLIB_param_sectors_actRange, [0]]
];

if (_bravoMarker isEqualTo "") exitWith {
    false;
};

// Defer to the core calculation
[_player, markerPos _bravoMarker, _range] call MFUNC(_inRange);
