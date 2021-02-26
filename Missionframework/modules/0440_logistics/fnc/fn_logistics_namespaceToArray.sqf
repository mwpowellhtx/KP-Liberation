/*
    KPLIB_fnc_logistics_namespaceToArray

    File: fn_logistics_namespaceToArray.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 14:47:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _namespace - A CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        An array corresponding to the namespace [ARRAY]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

// TODO: TBD: considering CBA namespace serialization for purposes of loading/saving mission lifeState
// TODO: TBD: therefore, may be for use with client side only...

[];
