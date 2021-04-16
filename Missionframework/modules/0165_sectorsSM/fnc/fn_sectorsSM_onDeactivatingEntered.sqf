#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onDeactivatingEntered

    File: fn_sectorsSM_onDeactivatingEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 21:09:35
    Last Update: 2021-04-08 23:19:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Only ever appends potentially ACTIVATING SECTORS to the existing set of ACTIVE SECTORS.
        At most 'KPLIB_param_sectors_maxAct' sectors may be active at any one time.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAMSM(_onDeactivatingEntered_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

// Probably also need some comprehension whether the sector is captured, i.e. as to whether other bits may occur
private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectorsSM_onDeactivating] Entering: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// Remember we got 'here' BECAUSE timer elapsed and other conditions were met
[_namespace, MSTATUS(_deactivated), { true; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;

if (_debug) then {
    ["[fn_sectorsSM_onDeactivating] Fini", "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
