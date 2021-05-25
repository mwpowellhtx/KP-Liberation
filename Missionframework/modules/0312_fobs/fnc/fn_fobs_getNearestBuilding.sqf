#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_getNearestBuilding

    File: fn_fobs_getNearestBuilding.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-19 11:31:11
    Last Update: 2021-05-19 11:31:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the NEAREST FOB BUILDING in range of the request. This one has
        a heck of a lot of applications, we think, just in terms of determining
        proximity to the TARGET object.

    Parameter(s):
        _target - a reference OBJECT about which to identify a FOB BUILDING [OBJECT, default: objNull]
        _range - optional RANGE about which to scan [SCALAR|NIL, default: nil]

    Returns:
        The CBA event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
 */

params [
    [Q(_target), objNull, [objNull]]
    , Q(_range)
];

if (isNull _target || _range < 0) exitWith { objNull; };

private _isQualified = {
    private _uuid = _this getVariable [Q(KPLIB_fobs_fobUuid), ""];
    private _markerName = _this getVariable [Q(KPLIB_fobs_markerName), ""];
    !(_uuid isEqualTo "" || _markerName isEqualTo "");
};

private _getTargetDistance = { _this distance _target; };

private _onFilter = if (isNil { _range; }) then {
    {
        _x call _isQualified;
    };
} else {
    {
        (_x call _isQualified)
            && (_x call _getTargetDistance) <= _range;
    };
};

private _filtered = [MVAR(_allBuildings), [], { _this call _getTargetDistance; }, Q(ascend), _onFilter] call BIS_fnc_sortBy;

_filtered params [
    [Q(_fobBuilding), objNull, [objNull]]
];

_fobBuilding;
