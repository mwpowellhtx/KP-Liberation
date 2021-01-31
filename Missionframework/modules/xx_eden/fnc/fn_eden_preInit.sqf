/*
    KPLIB_fnc_eden_preInit

    File: fn_eden_preInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 11:20:25
    Last Update: 2021-01-28 11:20:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:

    Parameter(s):

    Returns:

    Reference:
*/

["Module initializing...", "PRE] [EDEN", true] call KPLIB_fnc_common_log;

//// TODO: TBD: assumes only one such marker...
//// TODO: TBD: what happens when there are several mobile respawn assets in play?
//// TODO: TBD: should at least be a function, possibly returning an array (?)
//// TODO: TBD: will have to investigate usage...
// Respawn position shortcut
KPLIB_eden_respawnPos = getMarkerPos "respawn";

/*
 The Eden markerType is the mil_start icon.
 23. Start / "mil_start"
 https://community.bistudio.com/wiki/CfgMarkers#Arma_3
*/
KPLIB_eden_markerType = "mil_start";

/* DeployType enumerated:
 *
 * -1: Deploy type unknown, 'nil'
 * 10: Operations start base
 * 11: Forward operating base
 * 20: Radio tower
 * 30: Township
 * 31: Metropolis
 * 40: Factory
 * 50: Enemy military base
 * 99: Mobile respawn
 *
 * Note, we do not expect that all of the possible sector types will be relayed for
 * player, but that disposition could change depending how requirements mature.
 *
 * Additionally, although we do not expect the set of sector types to grow, we will
 * leave room just the same.
 *
 * Ordinarily bits such as these should go in the 'init' module, but we need them
 * during Eden initialization.
 */
KPLIB_sectorType_nil     = -1;
KPLIB_sectorType_eden    = 10;
KPLIB_sectorType_fob     = 11;
KPLIB_sectorType_tower   = 20;
KPLIB_sectorType_town    = 30;
KPLIB_sectorType_metro   = 31;
KPLIB_sectorType_factory = 40;
KPLIB_sectorType_mil     = 50;
KPLIB_sectorType_mob     = 99;

["Module initialized", "PRE] [EDEN", true] call KPLIB_fnc_common_log;

true
