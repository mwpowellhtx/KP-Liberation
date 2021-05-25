#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_getFobUnits

    File: fn_hudSM_getFobUnits.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-20 17:35:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the UNITS aligned with the SIDE within range of the FOB MARKER.

    Parameters:
        _fobMarker [STRING, default: ""]
        _side - the side for which units must align [SIDE, default: KPLIB_preset_sideF]
        _range - the range about which units must be within [SCALAR, default: KPLIB_param_fobs_range]

    Returns:
        The side units within range of the position [ARRAY]
 */

params [
    [Q(_fobMarker), "", [""]]
    , [Q(_side), KPLIB_preset_sideF, [sideEmpty]]
    , [Q(_range), KPLIB_param_fobs_range, [0]]
];

if (_fobMarker isEqualTo "") exitWith { []; };

// TODO: TBD: for now this is the simplest path forward...
// TODO: TBD: eventually I think we just pass the OBJECT itself straight through...
private _units = [markerPos _fobMarker, _side, _range] call MFUNC(_getUnits);

// Selecting around PLAYER in this instance
_units select { !isPlayer _x; };
