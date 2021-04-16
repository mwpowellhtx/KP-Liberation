#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onChangeAlignment

    File: fn_sectors_onChangeAlignment.sqf
    Author: Michael W. Powell [22nd MSU SOC]
    Created: 2021-04-06 14:22:50
    Last Update: 2021-04-06 14:22:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Changes the alignment of a given sector by updating the BLUFOR sectors array.

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
    // TODO: TBD: and then, could this not be done in response, i.e. during server side event handling?
    [] call KPLIB_fnc_core_checkWinCond;
} else {
    KPLIB_sectors_blufor deleteAt (KPLIB_sectors_blufor find _sectorToChange);
};

// TODO: TBD: is this a one-way trip? what happens when counter attacks, offensives, etc, happen?
// TODO: TBD: and then, does it really need to be global?
// TODO: TBD: at worst, I think we could simply issue remote notification...
// TODO: TBD: then keep any event handling 'local' or at least server side
[KPLIB_sector_captured, [_sectorToChange, _toPlayerSide]] call CBA_fnc_globalEvent;

// TODO: TBD: if we can successfully post events to CID subs, etc, in general
// TODO: TBD: then it is doubtful we need to make this public...
publicVariable "KPLIB_sectors_blufor";

true;
