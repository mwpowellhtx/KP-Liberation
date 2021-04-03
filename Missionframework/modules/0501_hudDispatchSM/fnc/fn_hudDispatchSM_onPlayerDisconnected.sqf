#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_onPlayerDisconnected

    File: fn_hudDispatchSM_onPlayerDisconnected.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Player disconnected event handler.

    Parameters:
        _id
        _uid
        _name
        _jip
        _owner
        _idstr

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/Arma_3:_Mission_Event_Handlers#PlayerDisconnected
 */

private _objSM = MVAR(_objSM);

params [
    Q(_id)
    , Q(_uid)
    , Q(_name)
    , Q(_jip)
    , Q(_owner)
    , Q(_idstr)
];

if (isNull _objSM) exitWith {
    false;
};

// TODO: TBD: ditto connected notes re: allPlayers

true;
