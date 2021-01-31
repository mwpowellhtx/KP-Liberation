/*
    KPLIB_fnc_common_getSectorInfo

    File: fn_common_getSectorInfo.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-24
    Last Update: 2021-01-29 17:25:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the 'KPLIB_sector_info' corresponding to the _target object.

    Parameter(s):
        _target - the _target from which to obtain the 'KPLIB_sector_info' [OBJECT, default: player]
            - tuples in the shape of, ['_markerName', '_uuid', '_sectorType']
        _selector - OPTIONAL, may select bits of the info tuple as needed [CODE, default: {_this}]
        _default - a defaullt return value in the event the variable has not yet been set

    Returns:
        The sector UUID variable attached to the _target object, if possible. Empty string oetherwise.
*/

params [
    ["_target", player, [objNull]]
    , ["_selector", {_this}, [{}]]
    , ["_default", ["", "", KPLIB_sectorType_nil], [[]], 3]
];

if (isNull _target) exitWith {_default};

/* Which are all injected by the "eventLoop" ... Note that here we are looking for that
 * moment when Player is near an FOB, but Player may be accounted for anywhere on the map. */

private _info = _target getVariable ["KPLIB_sector_info", _default];

_info call _selector;
