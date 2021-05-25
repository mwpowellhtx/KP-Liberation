/*
    KPLIB_fnc_core_getMobSpawns

    File: fn_core_getMobSpawns.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-30
    Last Update: 2021-05-19 13:27:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns an array with all mobile spawn objects.

    Parameters:
        NONE

    Returns:
        Mobile spawn objects [ARRAY]
 */

vehicles select {

    /* Remembering also, "speed" positive is FORWARD momentum, whereas negative is BACKWARD
     * momentum. Botton line here is MOMENTUM momentum; that is, in ANY direction. */
    [
        getPos _x
        , [_x] call KPLIB_fnc_common_getMomentum
        // TODO: TBD: could potentially configure these...
        , 5
        , 5
    ] params [
        "_pos"
        , "_currentMom"
        , "_maxZ"
        , "_maxMom"
    ];

    // TODO: TBD: what is 'KPLIB_sectors_markerName'? should have a specific 'mobile respawn' variable...

    // TODO: TBD: may validate the UUID ...
    // TODO: TBD: we'll likely want another per frame updater... for assets transit in and out of zones, Eden, FOB, etc...

    // Include the MR flag, as well as being "away from" the sector marker name
    alive _x
        && _x getVariable ["KPLIB_asset_isMobileRespawn", false]
        && !((_x getVariable ["KPLIB_sectors_markerName", ""]) isEqualTo "")
        && (
            (surfaceIsWater _pos && _x isKindOf "Ship")
                || !(surfaceIsWater _pos || _x isKindOf "Ship")
        )
        && (_pos#2) < _maxZ
        && _currentMom < _maxMom;
}
