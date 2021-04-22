#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onSectorDeactivating

    File: fn_sectors_onSectorDeactivating.sqf
    Author: Michael W. Powell [22nd MSU SOC]
    Created: 2021-04-21 17:05:08
    Last Update: 2021-04-21 17:05:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether SECTOR may begin DEACTIVATING process. Should support DEACTIVATING
        when SECTOR was OPFOR, as well as when SECTOR was BLUFOR. We allow both BLUFOR and
        OPFOR units to potentially ACTIVATE, or DEACTIVATE, as the case may be, SECTOR
        life cycles. The player centric BLUFOR use case speaks for itself. The OPFOR use
        case needs to be reconsidered a bit deeper. For instance, COUNTERATTACK or similar
        scenarios in which OPFOR units may slide past eligible sectors, all need to be
        considered. We may reconsider how we count OPFOR units, but that is not within
        the immediate purview of this function in particular. That is left for the moment
        when SECTOR SITREP is recalculated for consideration.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        Whether SECTOR may begin DEACTIVATING process [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

[
    _namespace getVariable [QMVAR(_blufor), false]
    , _namespace getVariable [QMVAR(_opfor), false]
    , _namespace getVariable [QMVAR(_bluforUnitCountAct), 0]
    , _namespace getVariable [QMVAR(_opforUnitCountAct), 0]
] params [
    Q(_blufor)
    , Q(_opfor)
    , Q(_bluforUnitCountAct)
    , Q(_opforUnitCountAct)
];

// Does not matter which "side" with which the SECTOR is aligned
(_bluforUnitCountAct + _opforUnitCountAct) == 0;
