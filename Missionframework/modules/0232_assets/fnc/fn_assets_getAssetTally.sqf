#include "script_component.hpp"
/*
    KPLIB_fnc_assets_getAssetTally

    File: fn_assets_getAssetTally.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-25 23:47:34
    Last Update: 2021-05-25 23:47:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Tallies the ASSETS matching the FILTER. Assumes that the ASSETS have
        already passed through the initial SHOULDBECOUNTED phase.

    Parameter(s):
        _assets - an ARRAY of ASSETS to consider [ARRAY, default: []]
        _filter - a FILTER with which to consider [CODE, default: _defaultFilter]

    Returns:
        The TALLY of ASSETS aligning to the FILTER [SCALAR]
 */

private _defaultFilter = { true; };

params [
    [Q(_assets), [], [[]]]
    , [Q(_filter), _defaultFilter, [{}]]
];

{ _x call _filter; } count _assets;
