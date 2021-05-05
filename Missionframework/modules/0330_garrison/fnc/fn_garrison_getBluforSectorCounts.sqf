#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getBluforSectorCounts

    File: fn_garrison_getBluforSectorCounts.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-29 11:37:57
    Last Update: 2021-05-03 19:52:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the BLUFOR SECTOR counts. If the approach here looks a bit backwards
        or upside down from the OPFOR GARRISON versus COUNTS, that is because it is.
        We maintain GARRISON for BLUFOR as player specified specifications, from which
        we derive secondary counts. By definition, BLUFOR sectors never include RESOURCE
        spawns.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The BLUFOR SECTOR counts [ARRAY]

    References:
        https://community.bistudio.com/wiki/getPos#Alternative_Syntax_2
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

// TODO: TBD: assuming that we support player specified BLUFOR GARRISON
// TODO: TBD: yes, at this point, I think we 'will' support it...
// TODO: TBD: ...but is a second priority behind revising the OPFOR GARRISON approach
// TODO: TBD: will leave room for consistency regardless whether OPFOR+BLUFOR...
// TODO: TBD: ...and simply treat 'garrison' in general
private _garrison = [
    [QMVAR(_bluforUnits), []]
    , [QMVAR(_bluforGrps), []]
    , [QMVAR(_bluforLightVehicles), []]
    , [QMVAR(_bluforHeavyVehicles), []]
    , [QMVAR(_bluforIeds), []]
] apply { _namespace getVariable _x; };

/* ^^ We should never see IEDs coming from BLUFOR GARRISON... ^^
 * But rather is 'included' for sake of completeness rounding out the SECTOR COUNTS */
_garrison apply { count _x; };
