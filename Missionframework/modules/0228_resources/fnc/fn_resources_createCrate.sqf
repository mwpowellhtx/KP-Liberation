#include "script_component.hpp"
/*
    KPLIB_fnc_resources_createCrate

    File: fn_resources_createCrate.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-12-15
    Last Update: 2021-05-05 21:20:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Spawns a resource crate of given type and side at given position.

    Parameter(s):
        _resourceName - a CLASS NAME, or a RESOURCE KIND [STRING, default: MPRESET(_resourceKind_sup)]
        _posATL - position at which to spawn the crate [POSITION ATL, default: KPLIB_zeroPos]
        _value - the value of resources inside the crate, limited by crateVolume param [SCALAR, default: KPLIB_param_crateVolume]
        _side - the side of the preset from where to take the class name from [SIDE, default: KPLIB_preset_sideF]

    Returns:
        The created crate object [OBJECT]

    Remarks:
        RESOURCE KIND are one of:
            [
                "Supply"
                , "Ammo"
                , "Fuel"
            ]
 */

params [
    [Q(_resourceName), MPRESET(_resourceKind_sup), [""]]
    , [Q(_posATL), KPLIB_zeroPos, [[]], [3]]
    , [Q(_value), KPLIB_param_crateVolume, [0]]
    , [Q(_side), KPLIB_preset_sideF, [sideEmpty]]
];

private _crate = objNull;

// Only the server should spawn crates
if (!isServer) exitWith {
    _crate;
};

// Obtain the PRESET CLASS NAME only when the RESOURCE NAME was not already a CLASS NAME
private _className = if ([_resourceName] call KPLIB_fnc_common_isClass) then { _resourceName; } else {
    // Allowing for RESOURCE NAME to be a RESOURCE KIND
    ["crate" + _resourceName, _side] call KPLIB_fnc_common_getPresetClass;
};

// Exit when there is still no CLASS NAME, PRESET or otherwise
if (_className isEqualTo "") exitWith {
    _crate;
};

// Spawn the object
_crate = [_className, _posATL, nil, nil, nil, _side] call KPLIB_fnc_common_createVehicle;

// Set the CRATE VALUE
_crate setVariable [QMVAR(_crateValue), _value min KPLIB_param_crateVolume, true];

_crate;
