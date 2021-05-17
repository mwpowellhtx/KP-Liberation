#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onPlayerConnected

    File: fn_hudSM_onPlayerConnected.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:02021-05-17 14:08:095
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Player connected event handler.

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
        https://community.bistudio.com/wiki/Arma_3:_Mission_Event_Handlers#PlayerConnected
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

// // TODO: TBD: for that matter, do we even need to respond with this...
// // TODO: TBD: or just lean into 'allPlayers' itself
// private _players = allPlayers select { (owner _x) isEqualTo _owner; };
// if (_players isEqualTo []) then {
//     // TODO: TBD: no players matched OWNER    
// };

true;
