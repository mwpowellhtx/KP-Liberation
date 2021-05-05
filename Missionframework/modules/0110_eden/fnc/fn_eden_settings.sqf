#include "script_component.hpp"
/*
    KPLIB_fnc_eden_settings

    File: fn_eden_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-15 10:45:23
    Last Update: 2021-04-30 18:53:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

/*
 The Eden markerType is the mil_start icon.
 23. Start / "mil_start"
 https://community.bistudio.com/wiki/CfgMarkers#Arma_3
*/
MPRESET(_markerType)                        = Q(mil_start);

//// TODO: TBD: assumes only one such marker...
//// TODO: TBD: what happens when there are several mobile respawn assets in play?
//// TODO: TBD: should at least be a function, possibly returning an array (?)
//// TODO: TBD: will have to investigate usage...

// Respawn position shortcut
MVAR(_respawnPos)                           = markerPos Q(respawn);

if (isServer) then {

    MPARAM(_onPreInit_debug)                = true;
    MPARAM(_onPostInit_debug)               = true;
    MPARAM(_getSectorIcon_debug)            = false;
};

true;
