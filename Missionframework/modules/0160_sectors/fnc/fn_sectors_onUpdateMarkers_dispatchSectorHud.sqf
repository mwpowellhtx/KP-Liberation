#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onUpdateMarkers_dispatchSectorHud

    File: fn_sectors_onUpdateMarkers_dispatchSectorHud.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 18:38:47
    Last Update: 2021-04-23 18:38:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        This seems like the best possible moment when to dispatch SECTOR REPORT to player HUD.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

private _debug = MPARAM(_onUpdateMarkers_dispatchSectorHud_debug);

// TODO: TBD: refactor key bits in lieu of the HUD DISPATCH SM SECTOR REPORT...
// TODO: TBD: may need to reconsider in terms of a client/server event...
// TODO: TBD: it may not be that terrible since we expect the necessary counts to have already been compiled
// TODO: TBD: what would be missing is to align players with the nearest respective sectors
// TODO: TBD: but this too should be fairly easy to identify

// TODO: TBD: this gets us at least closer to the question at hand...
// TODO: TBD: would need to connect the dots, then relay that to the HUD...
// TODO: TBD: but we will reserve that effort for a later sprint...
private _playerMarkers = allPlayers apply { [_x, [_x] call KPLIB_fnc_core_getNearestMarker] };
private _players = _playerMarkers select { !((_x#1) isEqualTo ""); } apply { (_x#0); };

true;
