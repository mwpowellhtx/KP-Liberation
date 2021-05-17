/*
    KPLIB_fnc_namespace_onGC

    File: fn_namespace_onGC.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 08:52:39
    Last Update: 2021-03-05 21:18:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Does routine garbage collection on the CBA namespace.

    Parameter(s):
        _namespace - a CBA namespace being GC'ed [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]

    References:
        http://cbateam.github.io/CBA_A3/docs/files/common/fnc_deleteNamespace-sqf.html
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

if (!isNull _namespace) then {
    _namespace call CBA_fnc_deleteNamespace;
};

true;
