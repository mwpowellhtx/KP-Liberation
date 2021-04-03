/*
    KPLIB_fnc_garrison_changeOwner

    File: fn_garrison_changeOwner.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-23
    Last Update: 2021-04-02 22:16:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Changes the owner of a sector garrison from BLUFOR to OPFOR or vice versa.

    Parameter(s):
        _sector - Markername of the sector [STRING, default: ""]
        _toPlayerSide - [BOOL, default: true]

    Returns:
        The event handler finished [BOOL]
*/

// TODO: TBD: may want to connect this with the actual capturing side...
params [
    ["_sector", "", [""]]
    , ["_toPlayerSide", true, [true]]
];

if (_sector isEqualTo "") exitWith { false; };

// Get the sector reference in the garrison array and initialize new owner variable
private _persistentGarrisonRef = [_sector] call KPLIB_fnc_garrison_getGarrison;

// Switch owner
private _newOwner = [2, 0] select ((_persistentGarrisonRef select 1) isEqualTo 2);

// Update persistent garrison
_persistentGarrisonRef set [1, _newOwner];

true;
