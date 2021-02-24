/*
    KPLIB_fnc_resources_getAttachedCrates

    File: fn_resources_getAttachedCrates.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-23 09:34:29
    Last Update: 2021-02-23 09:34:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the 'attachedObjects' attached to all of the indicated '_storages' objects.

    Parameter(s):
        _storages - a single host OBJECT or an ARRAY of OBJECT instances [OBJECT or ARRAY, default: []]
        _classNames - the class names to include among the resulting attached crates [ARRAY, default: KPLIB_resources_crateClasses]

    Returns:
        The crates attached to all of the '_storages' [ARRAY]
 */

params [
    ["_storages", []]
    , ["_classNames", KPLIB_resources_crateClasses, [[]]]
];

// Normalize storages as an ARRAY, ignore any invalid input
_storages = switch (typeName _storages) do {
    case "ARRAY": {_storages;};
    case "OBJECT": {[_storages];};
    default {[];};
};

private _crates = [];

_storages apply {
    (attachedObjects _x) select { typeOf _x in _classNames; };
} select {
    _crates append _x;
    true;
};

_crates;
