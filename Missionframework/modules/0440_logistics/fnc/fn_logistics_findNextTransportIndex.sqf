/*
    KPLIB_fnc_logistics_findNextTransportIndex

    File: fn_logistics_findNextTransportIndex.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 11:58:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Gets the next transport index for purposes of loading, unloading, etc, which
        depends in large part on the logistics '_namespace' 'KPLIB_logistics_status'.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The index of the transport for usage with the next operation, loading, unloading,
        etc. The question depends upon the context, as to which index is preferred, one
        with resources, i.e. unloading, or one without resources, i.e. loading.

    References:
        https://community.bistudio.com/wiki/Category:Function_Group:_Bitwise
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

private _status = _namespace getVariable ["KPLIB_logistics_status", 0];
private _transportValues = _namespace getVariable ["KPLIB_logistics_transportValues", []];

private _default = -1;

if (_transportValues isEqualTo []) exitWith {
    // TODO: TBD: do some logging
    _default;
};

// Load and unload from the front forward...
if ([_status, KPLIB_logistics_status_loading] call BIS_fnc_bitflagsCheck) exitWith {
    _transportValues findIf { (_x isEqualTo KPLIB_resources_storageValueDefault); };
};

if ([_status, KPLIB_logistics_status_unloading] call BIS_fnc_bitflagsCheck) exitWith {
    _transportValues findIf { !(_x isEqualTo KPLIB_resources_storageValueDefault); };
};

_default;

