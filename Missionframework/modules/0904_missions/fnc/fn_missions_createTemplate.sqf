// Ditto shorthand...
#include "script_component.hpp"
/*
    KPLIB_fnc_missions_createTemplate

    File: fn_missions_createTemplate.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 18:53:28
    Last Update: 2021-03-22 11:34:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates a CBA MISSION TEMPLATE namespace with nominal settings. These are what we say
        they are, a TEMPLATE, from which we may clone one or several such missions as appropriate.

    Parameter(s):
        _onInit - [CODE, default: _defaultOnInit]
        _nameValuePairs - caller may specify any number of [_variableName, _value] pairs
            related to its purposes [ARRAY, default: []]
        _uuid - a default UUID to use during creation [STRING, default: _defaultUuid]

    Returns:
        A created CBA MISSION TEMPLATE namespace [LOCATION]

    References:
        https://community.bistudio.com/wiki/serverTime
 */

private _defaultOnInit = { (_this#0); };
private _defaultUuid = [] call KPLIB_fnc_uuid_create_string;

params [
    [Q(_onInit), _defaultOnInit, [{}]]
    , [Q(_nameValuePairs), [], [[]]]
    , [Q(_uuid), _defaultUuid, [""]]
];

private _onInitNominal = {
    params [
        [Q(_mission), locationNull, [locationNull]]
        , [Q(_nameValuePairs), [], [[]]]
        , [Q(_uuid), "", [""]]
    ];

    // Set the default defaults, then any user specified NVPs, finally the TEMPLATE UUID default
    [_mission, MVAR1(_nameValuePairDefaults)] call KPLIB_fnc_namespace_setVars;

    if (count _nameValuePairs > 0) then {
        [_mission, _nameValuePairs] call KPLIB_fnc_namespace_setVars;
    };

    // TODO: TBD: if we ever wanted to serialize templates, or their saved missions, then would need to statically identify UUID...
    [_mission, [
        [QMVAR1(_uuid), _uuid]
        , [QMVAR1(_serverTime), serverTime]
    ]] call KPLIB_fnc_namespace_setVars;

    _mission;
};

private _template = [] call KPLIB_fnc_namespace_create;

[
    [_template, _nameValuePairs, _uuid] call _onInitNominal
] call _onInit;

_template;
