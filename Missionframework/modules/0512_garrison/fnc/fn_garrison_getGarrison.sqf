#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getGarrison

    File: fn_garrison_getGarrison.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-02 09:24:15
    Last Update: 2021-05-04 12:46:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the GARRISON array for the CBA SECTOR namespace. In prior versions this
        would inform the UI dialog, but we will be following a different approach with
        a firm boundary dispatching messages between client and server.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        GARRISON ARRAY corresponding to the SECTOR MARKER NAME [ARRAY]
 */

// TODO: TBD: is this one even invoked now?
// TODO: TBD: as far as the 'dialog' it would be...
// TODO: TBD: however that will be changing, so we can probably eventually set this one aside...
private _debug = MPARAM(_getGarrison_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

[
    _namespace getVariable [Q(KPLIB_sectors_markerName), ""]
    , [_namespace, KPLIB_sectors_status_opfor, Q(KPLIB_sectors_status)] call KPLIB_fnc_namespace_checkStatus
    , [_namespace, KPLIB_sectors_status_blufor, Q(KPLIB_sectors_status)] call KPLIB_fnc_namespace_checkStatus
] params [
    Q(_markerName)
    , Q(_opfor)
    , Q(_blufor)
];

if (_debug) then {
    [format ["[fn_garrison_getGarrison] Entering: [_markerName, markerText _markerName, _opfor, _blufor]: %1"
        , str [_markerName, markerText _markerName, _opfor, _blufor]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _garrison = switch (true) do {
    case (_opfor):  { [_namespace] call MFUNC(_getOpforGarrison);  };
    case (_blufor): { [_namespace] call MFUNC(_getBluforGarrison); };
    default         { [];                                   };
};

_garrison params [
    [Q(_groupedUnitClassNames), [], [[]]]
    , [Q(_lightVehicleClassNames), [], [[]]]
    , [Q(_heavyVehicleClassNames), [], [[]]]
    , [Q(_intelClassNames), [], [[]]]
    , [Q(_iedClassNames), [], [[]]]
    , [Q(_resourceClassNames), [], [[]]]
];

// TODO: TBD: may further log bits here...
// TODO: TBD: now we actually spawn the bits in...

if (_debug) then {
    ["[fn_garrison_getGarrison] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

_garrison;
