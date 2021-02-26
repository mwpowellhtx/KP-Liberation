/*
    KPLIB_fnc_logistics_onTransportBuild

    File: fn_logistics_onTransportBuild.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 11:58:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _targetUuid - the target logistic UUID for which to add a transport [STRING, default: ""]

    Returns:
        Whether the operation was successful [BOOL]
 */

params [
    ["_targetUuid", "", [""]]
];

private _namespace = [_targetUuid] call KPLIB_fnc_logistics_getNamespaceByUuid

if (isNull _namespace) exitWith {
    // TODO: TBD: do some logging...
    false;
};

private _transportValues = _namespace getVariable ["KPLIB_logistics_transportValues", []];
//                                                                                    ^^

_transportValues pushBack +KPLIB_resources_storageValueDefault;

// May not need to set it back again, but do so in the event there was a default get (^)
_namespace setVariable ["KPLIB_logistics_transportValues", _transportValues];

/*
    // example: may not need to (^)
    _x = [] call CBA_fnc_createNamespace;
    _x setVariable ["_test", []];
    _test = _x getVariable "_test";
    _test pushBack 0;
    _test pushBack 1;
    _test pushBack 2;
    _retval = _x getVariable "_test";
    _x call CBA_fnc_deleteNamespace;
    _retval // [0, 1, 2]
 */

// TODO: TBD: which should also raise an event to notify managers...

true;
