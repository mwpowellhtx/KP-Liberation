#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getRoadPositions

    File: fn_garrison_getRoadPositions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-04 01:43:59
    Last Update: 2021-06-14 17:13:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the ROAD POSITIONS useful when deciding where to create
        objects, units, etc.

    Parameter(s):
        _roads - zero or more OBJECTS [OBJECT|ARRAY, default: []]
        _shuffle - whether to SHUFFLE the result prior to returning [BOOL, default: true]

    Returns:
        An array of POSITIONS available in all of the BUILDINGS [ARRAY]

    References:
        https://community.bistudio.com/wiki/getRoadInfo
        https://community.bistudio.com/wiki/getPos#Alternative_Syntax_2
        https://community.bistudio.com/wiki/BIS_fnc_arrayShuffle
        https://community.bistudio.com/wiki/Category:Command_Group:_Roads_and_Airports
 */

params [
    [Q(_roads), [], [[]]]
    , [Q(_shuffle), true, [true]]
    , [Q(_options), [], [[]]]
];

private _debug = MPARAM(_getRoadPositions_debug)
    ;

private _optionMap = createHashMapFromArray _options;

private _bridge = _optionMap getOrDefault [Q(_bridge), true];
private _pedestrian = _optionMap getOrDefault [Q(_pedestrian), true];

// Normalizes a SINGLE ROAD OBJECT or an ARRAY of them
_roads = flatten [_roads];

private _allPositions = [];

{
    private _road = _x;

    // We do not care about half of the info but we can use the positions, width, etc
    getRoadInfo _road params [
        Q(_0)
        , Q(_width)
        , Q(_isPedestrian)
        , Q(_3)
        , Q(_4)
        , Q(_5)
        , Q(_beginPos)
        , Q(_endPos)
        , Q(_isBridge)
    ];

    private _radius = _width / 2;

    // TODO: TBD: pretty sure it is ATL, and not ASL, that is useful for us here...
    private _beginPosATL = ASLToATL _beginPos;
    private _endPosATL = ASLToATL _endPos;

    private _dir = _beginPosATL getDir _endPosATL;
    private _dirs = [90, -90] apply { _dir + _x; };

    // TODO: TBD: assuming that this means 'all' positions
    if (
        (_isPedestrian && _isPedestrian == _pedestrian)
        || (_isBridge && _isBridge == _bridge)
        || !(_isPedestrian || _isBridge)
        ) then {

        _allPositions append [_beginPosATL, _endPosATL];

        private _perPos = _dirs apply { _beginPosATL getPos [_radius, _x]; };
        _allPositions append _perPos;
    };
} forEach _roads;

if (!_shuffle) exitWith {
    _allPositions;
};

_allPositions call BIS_fnc_arrayShuffle;
