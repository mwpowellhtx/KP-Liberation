#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getUnitMinRange

    File: fn_sectors_getUnitMinRange.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 09:52:47
    Last Update: 2021-06-14 16:51:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the MINIMUM RANGE to the CBA SECTOR namespace from among the UNITS. Default is
        'KPLIB_preset_sectors_defaultUnitRange' when could not be determined. Depends upon
        'KPLIB_sectors_markerPos' having been set prior to invocation.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _units - the units to count [ARRAY, default: []]
        _side - the SIDE for which to count [SIDE, default: KPLIB_preset_sideF]
        _className - the kind of class name for which to count [STRING, default: _manClassName]

    Returns:
        The minimum range of the units matching the side and class name criteria [SCALAR]

    References:
        https://community.bistudio.com/wiki/isKindOf
 */

private _manClassName = "CAManBase";

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_units), _allUnitsAct, [[]]]
    , [Q(_side), KPLIB_preset_sideF, [sideEmpty]]
    , [Q(_className), _manClassName, [""]]
];

private _default = MPRESET(_defaultUnitRange);

private _markerPos = _sector getVariable [QMVAR(_markerPos), +KPLIB_zeroPos];

if (_markerPos isEqualTo KPLIB_zeroPos) exitWith { _default; };

// Instead of COUNT we use SELECT here
private _selection = _units select { [_x, _side, _className] call MFUNC(_whereUnitMatches); };

private _ranges = _selection apply { _x distance2D _markerPos; };

private _range = switch (count _ranges) do {
    case 0: { _default; };
    case 1: { (_ranges#0); };
    default { selectMin _ranges; };
};

_range;
