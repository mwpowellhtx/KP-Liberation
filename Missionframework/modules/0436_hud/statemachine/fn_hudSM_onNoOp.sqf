#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_onNoOp

    File: fn_hudSM_onNoOp.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:08:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        A no-operation placeholder state machine callback.

    Parameters:
        _player - player for whom callback has occurred [OBJECT, default: objNull]
        _stateOrTransition - the name of the state or transition [STRING, default: ""]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_stateOrTransition), "", [""]]
];

// TODO: TBD: do some logging...

true;
