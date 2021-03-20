// Ditto shorthand...
#include "script_component.hpp"
/*
    KPLIB_fnc_missions_createTemplate

    File: fn_missions_createTemplate.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 18:53:28
    Last Update: 2021-03-19 18:53:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates a CBA MISSION TEMPLATE namespace with nominal settings. These are what we say
        they are, a TEMPLATE, from which we may clone one or several such missions as appropriate.

    Parameter(s):
        _onInit - [CODE, default: _defaultOnInit]
        _nameValuePairs - caller may specify any number of [_variableName, _value] pairs
            related to its purposes [ARRAY, default: []]

    Returns:
        A created CBA MISSION TEMPLATE namespace [LOCATION]
 */

private _defaultOnInit = { (_this#0); };

params [
    ["_onInit", _defaultOnInit, [{}]]
    , ["_nameValuePairs", [], [[]]]
];

private _onInitNominal = {
    params [
        ["_namespace", locationNull, [locationNull]]
        , ["_nameValuePairs", [], [[]]]
    ];

    // Set the default defaults, then any user specified NVPs, finally the TEMPLATE UUID default
    [_namespace, MSVAR(_nameValuePairDefaults)] call KPLIB_fnc_namespace_setVars;

    if (count _nameValuePairs > 0) then {
        [_namespace, _nameValuePairs] call KPLIB_fnc_namespace_setVars;
    };

    // TODO: TBD: if we ever wanted to serialize templates, or their saved missions, then would need to statically identify UUID...
    [_namespace, [
        [QMVAR(_templateUuid), [] call KPLIB_fnc_uuid_create_string]
    ]] call KPLIB_fnc_namespace_setVars;

    _namespace;
};

private _template = [] call KPLIB_fnc_namespace_create;

[
    [_template, _nameValuePairs] call _onInitNominal
] call _onInit;

_template;
