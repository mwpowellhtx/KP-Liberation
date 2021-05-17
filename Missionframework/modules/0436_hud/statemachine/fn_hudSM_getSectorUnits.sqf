#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_getSectorUnits

    File: fn_hudSM_getSectorUnits.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:06:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns with the side units within range of the sector.

    Parameters:
        _pos - the position about which to check [ARRAY, default: KPLIB_zeroPos]
        _side - the side for which units must align [SIDE, default: KPLIB_preset_sideF]
        _range - the range about which units must be within [SCALAR, default: KPLIB_param_sectors_capRange]

    Returns:
        The side units within range of the position [ARRAY]
 */

params [
    [Q(_pos), +KPLIB_zeroPos, [[]], 3]
    , [Q(_side), KPLIB_preset_sideF, [sideEmpty]]
    , [Q(_range), KPLIB_param_sectors_capRange, [0]]
    // Key:       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
];

private _units = [_pos, _side, _range] call MFUNC(_getUnits);

_units;
