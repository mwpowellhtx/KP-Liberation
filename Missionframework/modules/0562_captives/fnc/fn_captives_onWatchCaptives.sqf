#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onWatchCaptives

    File: fn_captives_onWatchCaptives.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 09:39:45
    Last Update: 2021-06-24 12:00:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Watches for UNITS that have 'KPLIB_surrender' and whether their associated
        'KPLIB_captives_timer' did expire. When the timers elapse, then we GC each
        unit accordingly, regardless of the CAPTIVES phase their are currently in.
        Such phases are, SURRENDERED, CAPTURED, INTERROGATED.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
 */

private _debug = MPARAM(_onWatchCaptives_debug);

if (_debug) then {
    ["[fn_captives_onWatchCaptives] Entering...", "CAPTIVES", true] call KPLIB_fnc_common_log;
};

/* Resolve to do housekeeping on former ESCORTS with now ghosted UNITS,
 * i.e. was ESCORTING, then got LOADED, etc.
 */
{
    private _player = _x;
    [_player] remoteExec [QMFUNC(_onWatchStopEscortingOne), _player];
} forEach (allPlayers select { _x getVariable [QMVAR(_isEscorting), false]; });

/* Watching all UNITS that which:
 *      - are SURRENDERED (critical)
 *      - have an elapsed CAPTIVES timer
 *
 * Then may be garbage collected (GC).
 */
private _unitsToWatch = allUnits select { [_x] call MFUNC(_isUnitSurrendering); };

/* UNITS to INTERROGATE are:
 *      - alive
 *      - no longer 'escorted'
 *      - unloaded from a transport
 *      - CAPTURED (this is critical)
 *      - NOT INTERROGATED (also critical)
 *      - within range of an FOB building
 */
private _allUnitsToInterrogate = KPLIB_fobs_allBuildings apply {
    private _fobBuilding = _x;
    _unitsToWatch select {
        alive _x
            // && (isNull attachedTo _x)
            && (isNull objectParent _x)
            && ([_x] call MFUNC(_isUnitCaptured))
            && !([_x] call MFUNC(_isUnitInterrogated))
            && (_x distance _fobBuilding <= MPARAM(_interrogationRadius))
            ;
    };
};

private _unitsToGC = _unitsToWatch select { isNull objectParent _x; };

{ [_x] call MFUNC(_onWatchInterrogateOne); } forEach (flatten _allUnitsToInterrogate);

{ [_x] call MFUNC(_onWatchTimerElapsedOneGC); } forEach _unitsToGC;

// Finally relay to the next iteration
[{ _this call MFUNC(_onWatchCaptives); }, [], MPARAM(_watchCaptivesPeriod)] call CBA_fnc_waitAndExecute;

if (_debug) then {
    ["[fn_captives_onWatchCaptives] Fini", "CAPTIVES", true] call KPLIB_fnc_common_log;
};

true;
