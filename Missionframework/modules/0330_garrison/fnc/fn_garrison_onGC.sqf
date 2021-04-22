#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onGC

    File: fn_garrison_onGC.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-17 11:59:55
    Last Update: 2021-04-17 11:59:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Performs GARRISON specific GC on the CBA GARRISON namespace itself, or in
        relation to its MARKER NAME.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        GC was performed successfully [BOOL]
 */

params [
    [Q(_namespace), locationNull, ["", locationNull]]
];

// TODO: TBD: scope needs to be determined...
// TODO: TBD: i.e. we GC the currently spawned units? assets?
// TODO: TBD: i.e. clear out known GARRISON variables...
// TODO: TBD: i.e. etc...

true;
