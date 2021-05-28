/*
    KPLIB_fnc_resources_getAttachedCrates

    File: fn_resources_getAttachedCrates.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-23 09:34:29
    Last Update: 2021-05-27 19:13:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the CRATE objects attached to all of the STORAGE CONTAINER objects.

    Parameter(s):
        _storages - zero or more STORAGE CONTAINER objects [OBJECT|ARRAY, default: []]
        _classNames - the CLASS NAMES to consider [ARRAY, default: KPLIB_resources_crateClasses]

    Returns:
        The CRATE objects attached to the STORAGE CONTAINERS [ARRAY]
 */

params [
    ["_storages", [], [objNull, []]]
    , ["_classNames", KPLIB_resources_crateClasses, [[]]]
];

_storages = flatten [_storages];

private _crates = _storages apply {
    private _attached = attachedObjects _x;
    _attached select { typeOf _x in _classNames; };
};

flatten _crates;
