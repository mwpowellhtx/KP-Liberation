#include "script_component.hpp"
/*
    KPLIB_fnc_resources_createIntel

    File: fn_resources_createIntel.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-04 00:14:59
    Last Update: 2021-06-14 16:45:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Creates one INTEL OBJECT given the CLASS NAME and TARGET POS. We should
        have CBA class events watching for the INTEL CLASS NAMES, so that we can
        wire up events and such following their creation. Additionally, since we
        route the request through the 'KPLIB_fnc_common_createVehicle' function,
        then we are afforded additional opportunities to respond with framework
        level event handling, 'KPLIB_vehicle_created'.

    Parameter(s):
        _className - a CLASS NAME for which INTEL is being created [STRING, default: _defaultClassName]
        _targetPos - a TARGET POSITION at which to create the INTEL [ARRAY, default: KPLIB_zeroPos]

    Returns:
        The created INTEL object [OBJECT]
 */

private _defaultClassName = selectRandom MPRESET(_intelClassNames);

params [
    [Q(_className), _defaultClassName, [""]]
    , [Q(_targetPos), +KPLIB_zeroPos, [[]]]
];

private _debug = MPARAM(_createIntel_debug);

if (_debug) then {
    // TODO: TBD: logging...
};

private _obj = objNull;

if (_targetPos isEqualTo KPLIB_zeroPos || _buildings isEqualTo []) exitWith {
    if (_debug) then {
        // TODO: TBD: logging...
    };
    _obj;
};

_obj = [
    _className
    , _targetPos vectorAdd [0, 0, 0.75]
    , nil // random 360
    , true
    , nil // false
    , nil // KPLIB_preset_sideE
    , Q(can_collide)
] call KPLIB_fnc_common_createVehicle;

if (_debug) then {
    // TODO: TBD: logging...
};

_obj;
