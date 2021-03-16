/*
    KPLIB_fnc_logistics_getNamespaceByUuid

    File: fn_logistics_getNamespaceByUuid.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 22:00:22
    Last Update: 2021-02-25 22:00:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns the CBA logistics namespace matching the '_targetUuid', or 'locationNull' when one could not be found.

    Parameters:
        _targetUuid - find the CBA logistics namespace matching the UUID [STRING, default: ""]

    Returns:
        The namespace matching the '_targetUuid' or 'locationNull' if a match could not be found [LOCATION]

    References:
        https://community.bistudio.com/wiki/locationNull
 */

params [
    ["_targetUuid", "", [""]]
];

// TODO: TBD: we can do it this way, but we think it would be compelling to manage these things in a hash map...
// TODO: TBD: hashmap should have a "_list" member for ordering purposes
// TODO: TBD: beside that, should also be able to identify namespaces BY UUID hashmap key
// TODO: TBD: so, managing the _list would be expensive, but for everything else, would be VERY FAST indeed
[{ (_x getVariable ["KPLIB_logistics_uuid", ""]) isEqualTo _targetUuid; }] call KPLIB_fnc_logistics_getNamespaceBy;
