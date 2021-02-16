/*
    KPLIB_fnc_persistence_serializeVars

    File: fn_persistence_serializeVars.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-03-30
    Last Update: 2021-02-14 12:24:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Get peristable variables from object.

    Parameter(s):
        _object - Description [OBJECT, default: objNull]

    Returns:
        Persistable object variables [ARRAY]
            [
                ['_var', '_val', '_global']
                , ...
            ]

    References:
        https://community.bistudio.com/wiki/allVariables
 */

private _debug = [] call KPLIB_fnc_persistence_debug;

params [
    ["_object", objNull, [objNull]]
];

private _varData = [];

if (isNull _object) exitWith {
    _varData;
};

_varData = KPLIB_persistenceSavedVars select {
    /* Nil is nil, nil variables will not be in there, otherwise will be.
     * Bearing in mind we also need to test in lowercase... */
    toLower (_x#0) in allVariables _object;
} apply {
    private _varSpec = _x;
    _varSpec params [
        ["_var", "", [""]]
        , ["_global", false, [false]]
    ];
    [_var, (_object getVariable _var), _global];
};

if (_debug) then {
    [format ["[fn_persistence_serializeVars] Persistence vars: [count _varData, _varData]: %1"
        , str [count _varData, _varData]], "SAVE"] call KPLIB_fnc_common_log;
};

_varData;
