/*
    KPLIB_fnc_changeOrders_create

    File: fn_changeOrders_create.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 09:38:52
    Last Update: 2021-03-06 09:38:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Creates a new CHANGE ORDER along with an opportunity to initialize it. Created
        as a CBA namespace.

    Parameters:
        _onInit - callback used to initialize the CHANGE ORDER [CODE, default: {}]

    Returns:
        A created CHANGE ORDER [LOCATION]
 */

private _debug = [
    [
        {KPLIB_param_changeOrders_create_debug}
    ]
] call KPLIB_fnc_changeOrders_debug;

params [
    ["_onInit", {}, [{}]]
];

if (_debug) then {
    ["[fn_changeOrders_create] Entering", "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

private _changeOrder = [] call KPLIB_fnc_namespace_create;

[_changeOrder] call _onInit;

if (_debug) then {
    [format ["[fn_changeOrders_create] Fini: [isNull _changeOrder]: %1"
        , str [isNull _changeOrder]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

_changeOrder;
