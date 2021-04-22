#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_addInfantry

    File: fn_garrison_addInfantry.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-21
    Last Update: 2021-04-16 15:00:50
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Adds given amount of infantry units to the garrison of given sector.

    Parameter(s):
        _sector - a SECTOR marker name [STRING, default: ""]
        _amount - the number of infantry to add or subtract when positive or negative, respectively
            [NUMBER, default: 0]

    Returns:
        The callback has finished [BOOL]
 */

params [
    [Q(_sector), "", [""]]
    , [Q(_amount), 0, [0]]
];

[
    _sector in KPLIB_sectors_all
    , _sector in MVAR(_active)
] params [
    Q(_all)
    , Q(_active)
];

// Exit, if no valid or an active sector is given
if (!_all || _active) exitWith {
    false;
};

private _garrisonRef = [_sector] call MFUNC(_getGarrison);

// Prevent values below 0
private _curAmount = _garrisonRef select 2;
_amount = (_curAmount + _amount) max 0;

// Add new value to garrison
_garrisonRef set [2, _amount];

// Publish changes to other machines
publicVariable QMVAR(_array);

true;
