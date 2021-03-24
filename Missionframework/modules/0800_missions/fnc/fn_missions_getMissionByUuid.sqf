#include "script_component.hpp"
/*
    KPLIB_fnc_missions_getMissionByUuid

    File: fn_missions_getMissionByUuid.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 18:53:28
    Last Update: 2021-03-22 10:25:22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the CBA MISSION namespace corresponding to the targetUUID and targetTemplateUUID.
        Prefers looking up a RUNNING MISSION first, then a MISSION TEMPLATE second. Returns
        locationNull when none could be identified.

    Parameter(s):
        _targetUuid - a RUNNING MISSION target UUID [STRING, default: ""]
        _targetTemplateUuid - a MISSION TEMPLATE target UUID [STRING, default: ""]

    Returns:
        The corresponding CBA MISSION namespace, or locationNull if it cannot be found [LOCATION]

    References:
        https://community.bistudio.com/wiki/createHashMap
        https://community.bistudio.com/wiki/getOrDefault
        https://community.bistudio.com/wiki/Category:Command_Group:_HashMap
        https://community.bistudio.com/wiki/Category:Arma_3:_Scripting_Commands
 */

params [
    [Q(_targetUuid), "", [""]]
    , [Q(_targetTemplateUuid), "", [""]]
];

// This is a bit more involved than we first thought
private _keys = keys MVAR(_registry);

private _keyIndex = _keys findIf {
    private _mission = MVAR(_registry) get _x;
    [
        ["KPLIB_mission_uuid", ""]
        , ["KPLIB_mission_templateUuid", ""]
    ] apply { _mission getVariable _x; } params [
        Q(_uuid)
        , Q(_templateUuid)
    ];
    // But notice what is going on here
    [
        _uuid isEqualTo _targetUuid
        , _templateUuid isEqualTo _targetTemplateUuid
    ] params [
        Q(_running)
        , Q(_template)
    ];
    // One or the other, but definitely not both
    _running || _template;
};

if (_keyIndex < 0) exitWith { locationNull; };

MVAR(_registry) getOrDefault [_keys select _keyIndex, locationNull];
