#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_delVeh

    File: fn_garrison_delVeh.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-21
    Last Update: 2021-04-16 14:51:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Removes one occurance of given vehicle classname from the vehicle garrison of given sector.

    Parameter(s):
        _sector - a SECTOR marker name [STRING, default: ""]
        _className - the vehicle class name to remove [STRING, default: ""]
        _heavy - 'light' (false) or 'heavy' (true) vehicle [BOOL, default: false]

    Returns:
        The callback has finished [BOOL]
 */

// TODO: TBD: instead of BOOL, receive STRING, 'light'|'heavy'
// TODO: TBD: such that API throughout is CONSISTENT...
params [
    [Q(_sector), "", [""]]
    , [Q(_className), "", [""]]
    , [Q(_heavy), false, [false]]
];

[
    _sector in KPLIB_sectors_all
    , _sector in MVAR(_active)
    , _className isEqualTo ""
] params [
    Q(_all)
    , Q(_active)
    , Q(_empty)
];

// Exit, if no valid sector, an active sector or no classname is given
if (!_all || _active || _empty) exitWith {
    false;
};

private _garrisonRef = [_sector] call MFUNC(_getGarrison);

// Remove the first occurance of the classname
(_garrisonRef select ([3, 4] select _heavy)) deleteAt ((_garrisonRef select ([3, 4] select _heavy)) findIf {_x isEqualTo _className});

// Publish changes to other machines
publicVariable QMVAR(_array);

true;
