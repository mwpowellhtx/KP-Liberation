#include "script_component.hpp"
/*
    KPLIB_fnc_eden_settings

    File: fn_eden_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-15 10:45:23
    Last Update: 2021-04-15 10:45:26
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
    MPARAM(_getSectorIcon_debug)            = true;

    // Define the SECTOR prefixes, we use this for easy identification and classification
    MPREFIX(_tower)                         = QMVAR(_t);
    MPREFIX(_factory)                       = QMVAR(_f);
    MPREFIX(_base)                          = QMVAR(_b);
    MPREFIX(_city)                          = QMVAR(_c);
    MPREFIX(_metropolis)                    = QMVAR(_m);

    MPRESET(_towerIcon)                     = "\a3\ui_f\data\map\mapcontrol\transmitter_ca.paa";
    MPRESET(_factoryIcon)                   = "\a3\ui_f\data\map\mapcontrol\fuelstation_ca.paa";
    MPRESET(_baseIcon)                      = "\a3\ui_f\data\map\markers\nato\o_support.paa";
    MPRESET(_cityIcon)                      = "\a3\ui_f\data\map\markers\nato\n_art.paa";
    MPRESET(_metropolisIcon)                = "\a3\ui_f\data\map\markers\nato\n_service.paa";
};

true;
