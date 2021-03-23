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
        _targetTemplateUuid - a TEMPLATE MISSION target UUID [STRING, default: ""]

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

private _candidates = [_targetUuid, _targetTemplateUuid] apply {
    if (_x isEqualTo "") then { locationNull; } else {
        MSVAR(_registry) getOrDefault [_x, locationNull];
    };
};

_candidates = _candidates select { !isNull _x; };

private _mission = if (_candidates isEqualTo []) then { locationNull; } else { (_candidates#0); };

_mission;
