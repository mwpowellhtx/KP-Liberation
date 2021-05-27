#include "script_component.hpp"
/*
    KPLIB_fnc_assets_getStaticAssets

    File: fn_assets_getStaticAssets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-25 23:34:34
    Last Update: 2021-05-25 23:34:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the STATIC ASSETS in proximity to the MARKER NAMES.

    Parameter(s):
        _markerNames - the MARKER NAMES to consider [STRING|ARRAY, default: []]
        _classNames - the CLASS NAMES to consider [STRING|ARRAY, default: []]
        _range - RANGE about which to consider [SCALAR, default: KPLIB_param_fobs_range]

    Returns:
        The callback has finished [BOOL]
 */

params [
    [Q(_markerNames), [], ["", []]]
    , [Q(_classNames), [], ["", []]]
    , [Q(_range), KPLIB_param_fobs_range, [0]]
];

private _assets = [];

if (_markerNames isEqualTo [] || _classNames isEqualTo []) exitWith { _assets; };

// Flattens the MARKER and CLASS NAMES out regardless of the shapes
_markerNames = KPLIB_sectors_fobs arrayIntersect (flatten [_markerNames]);
_classNames = flatten [_classNames];

_assets = _markerNames apply { nearestObjects [markerPos _x, _classNames, _range]; };

// Ditto the results
_assets = flatten _assets;

_assets select { [_x] call MFUNC(_shouldBeCounted); };
