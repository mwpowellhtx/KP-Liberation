/*
    KPLIB_fnc_persistence_enumerateFactoryStorages

    File: fn_persistence_enumerateFactoryStorages.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-23 19:32:15
    Last Update: 2021-02-23 19:32:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the set of factory storages to include in the next per frame persistence cycle.

    Parameter(s):
        NONE

    Returns:
        The factory storages to include during the next per frame persistence cycle.
 */

private _sectors = KPLIB_sectors_factory select { _x in KPLIB_sectors_blufor };

private _retval = [];

_sectors select {
    private _factoryMarker = _x;
    private _factoryStorages = [_factoryMarker] call KPLIB_fnc_resources_getFactoryStorages;
    _retval append _factoryStorages;
    true;
};

_retval;
