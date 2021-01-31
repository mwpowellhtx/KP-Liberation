#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_respawn_displayFocusMap

    File: fn_respawn_displayUpdateMap.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-09-12
    Last Update: 2019-04-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        - DESCRIPTION MISSING @veteran29

    Parameter(s):
        _display - Respawn display [DISPLAY, defaults to nil]

    Returns:
        Function reached the end [BOOL]
*/

//private _dep = [
//    "KPLIB_sectors_edens"
//];

////// TODO: TBD: so... we kinda do need to wait for the variable to show up...
////// TODO: TBD: and we cannot waitUntil in the context...
////// TODO: TBD: but forever sleeping is ALSO the wrong thing to do...
////// TODO: TBD: maybe a wait timeout? or does a CBA wait actually work?
////// TODO: TBD: but it really beggars the question why is it not loading properly...
////// TODO: TBD: is it something that depends on proper "init" having taken place prior to "eden" concerns having been initialized
//// When suspension is not allowed in a given context.
//for [{}, {!(_dep isEqualTo [])}, {_dep = _dep select {isNil _x}}] do {
//    sleep 0.1; // Allowing for completion of the dependencies
//}

params [
    ["_display", nil, [displayNull]]
];

private _respawnItem = (_display getVariable "KPLIB_selRespawn");
private _spawnPos = [(_respawnItem select 1)] call KPLIB_fnc_common_getPos;

private _mapCtrl = _display displayCtrl KPLIB_IDC_RESPAWN_MAP;
_mapCtrl ctrlMapAnimAdd [0, 0.3, _spawnPos];
ctrlMapAnimCommit _mapCtrl;

true
