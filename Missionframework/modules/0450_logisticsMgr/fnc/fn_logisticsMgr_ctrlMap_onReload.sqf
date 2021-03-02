/*
    KPLIB_fnc_logisticsMgr_ctrlMap_onReload

    File: fn_logisticsMgr_ctrlMap_onReload.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 22:02:06
    Last Update: 2021-03-01 22:02:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _pos - a 3D position at which to center the map [POSITION]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/ctrlMapAnimAdd
 */

params [
    ["_pos", +KPLIB_zeroPos, [[]], 3]
    , ["_target", objNull, [objNull]]
];

if (!isNull _target) then {
    _pos = getPos _target;
};

private _ctrlMap = uiNamespace getVariable ["KPLIB_logisticsMgr_ctrlMap", controlNull];

_ctrlMap ctrlMapAnimAdd [0, 0.1, _pos];

// TODO: TBD: when we "reload" the map in this manner, we will also want to consider factory storage markers as well...
// TODO: TBD: probably think of a common production/logistics refactoring...
_ctrlMap setVariable ["KPLIB_logisticsMgr_pos", _pos];

ctrlMapAnimCommit _ctrlMap;

true;
