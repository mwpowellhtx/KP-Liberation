#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onGarrison

    File: fn_sectorsSM_onGarrison.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-22 15:03:32
    Last Update: 2021-04-22 15:03:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        GARRISON 'onState' event handler.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAMSM(_onGarrison_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectorsSM_onGarrison] Entering: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: check the SECTOR garrison specs and meet the billet, depending on awareness, strength, civrep...
// TODO: TBD:   - infantry, levels
// TODO: TBD:   - light armor
// TODO: TBD:   - heavy(ier) armor
// TODO: TBD:   - IEDs

// TODO: TBD: eventually conditioned on "fully garrisoned" ...
if (true) then {
    // TODO: TBD: always set it for now... will obviously need to fill in this gap later...
    [_namespace, MSTATUS(_garrisoned), { true; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;
};

private _statusReport = [_namespace] call MFUNC(_getStatusReport);

if (_debug) then {
    [format ["[fn_sectorsSM_onGarrison] Fini: [_markerName, _statusReport]: %1"
        , str [_markerName, _statusReport]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
