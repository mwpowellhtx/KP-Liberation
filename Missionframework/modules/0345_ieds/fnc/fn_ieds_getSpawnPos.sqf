#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_getRoads

    File: fn_ieds_getRoads.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-06 15:42:24
    Last Update: 2021-05-08 17:51:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the calculated SPAWN POSITION for the IED CLASS NAME under consideration.

    Parameter(s):
        _roads - an array of ROAD objects under consideration [ARRAY, default: []]
        _className - the IED CLASS NAME under consideration [STRING, default: ""]

    Returns:
        The calculated SPAWN POSITION for the IED CLASS NAME under consideration [POSITION]    

    References:
        https://community.bistudio.com/wiki/getRoadInfo
 */

private _debug = MPARAM(_getSpawnPos_debug);

params [
    [Q(_roads), [], [[]]]
    , [Q(_className), "", [""]]
];

private _spawnPos = +KPLIB_zeroPos;

if (_roads isEqualTo []) exitWith {
    _spawnPos;
};

while { _spawnPos isEqualTo KPLIB_zeroPos; } do {
    private _road = if (count _roads == 1) then { (_roads#0); } else { selectRandom _roads; };
    getRoadInfo _road params [
        Q(_0)
        , Q(_width)
        , Q(_2), Q(_3), Q(_4), Q(_5)
        , Q(_beginPos)
        , Q(_endPos)
    ];
    // // TODO: TBD: this approach "will not" work, because the road may be longer and have end points that are not necessarily straight line
    // private _centerPos = _beginPos getPos [_beginPos distance2D _endPos, _beginPos getDir _endPos];
    private _centerPos = selectRandom [_beginPos, _endPos];
    // TODO: TBD: Is 'width' really what we think it is?
    _spawnPos = [_centerPos, _className, 0.25 * _width] call KPLIB_fnc_garrison_getVehSpawnPos;
    // TODO: TBD: Which should mask them slightly by the terrain
    _spawnPos = [_spawnPos#0, _spawnPos#1, 0] vectorAdd [0, 0, -0.0125];
};

_spawnPos;
