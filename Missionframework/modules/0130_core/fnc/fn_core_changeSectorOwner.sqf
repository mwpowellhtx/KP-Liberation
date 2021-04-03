/*
    KPLIB_fnc_core_changeSectorOwner

    File: fn_core_changeSectorOwner.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MSU SOC]
    Created: 2018-05-07
    Last Update: 2021-04-02 19:50:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Changes the ownership of a given sector by updating the BLUFOR sectors array.

    Parameter(s):
        _sectorToChange - sector marker name [STRING, default: ""]
        _toPlayerSide - True if it should be changed to player side, false if to enemy side [BOOL, default: true]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/remoteExec
*/

params [
    ["_sectorToChange", "", [""]]
    , ["_toPlayerSide", true, [true]]
];

if (_toPlayerSide) then {
    KPLIB_sectors_blufor pushBack _sectorToChange;
    // TODO: TBD: check wind? really? why? or rather "why now/here"?
    [] call KPLIB_fnc_core_checkWinCond;
} else {
    KPLIB_sectors_blufor deleteAt (KPLIB_sectors_blufor find _sectorToChange);
};

["KPLIB_sector_captured", [_sectorToChange, _toPlayerSide]] call CBA_fnc_globalEvent;

// TODO: TBD: if we can successfully post events to CID subs, etc, in general
// TODO: TBD: then it is doubtful we need to make this public...
publicVariable "KPLIB_sectors_blufor";

true;
