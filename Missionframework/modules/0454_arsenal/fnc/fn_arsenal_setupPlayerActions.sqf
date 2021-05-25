#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_arsenal_setupPlayerActions

    File: fn_arsenal_setupPlayerActions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-14
    Last Update: 2021-05-24 10:08:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Setup player actions available to client side PLAYER.

    Parameters:
        NONE

    Returns:
        The callback has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_addPlayerAction-sqf.html
 */

// TODO: TBD: may reconsider FOB arsenal actions rather in terms of the FOB building itself
// TODO: TBD: i.e. not dissimilar to the mobile respawn...

/* Here we simply allow the marker names to reveal themselves as self-evident. Which
 * we allow SECTOR  proximity algos to resolve in and of themselves, i.e. re: ranges.
 */
[
    [
        "STR_KPLIB_ACTION_ARSENAL"
        , { [] call KPLIB_fnc_arsenal_openDialog; }
        , []
        , KPLIB_ACTION_PRIORITY_ARSENAL
        , false
        , true
        , ""
        , "
            _target isEqualTo vehicle _target
                && _target isEqualTo _originalTarget
                && (_target getVariable ['KPLIB_sectors_markerName', '']) in (KPLIB_sectors_fobs + KPLIB_sectors_startbases)
        "
        , -1
    ]
    , [["_varName", "KPLIB_arsenal_arsenalID"]]
] call KPLIB_fnc_common_addPlayerAction;

true;
