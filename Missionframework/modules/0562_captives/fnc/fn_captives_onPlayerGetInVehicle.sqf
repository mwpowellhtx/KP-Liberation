#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onPlayerGetInVehicle

    File: fn_captives_onPlayerGetInVehicle.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-16 13:08:35
    Last Update: 2021-06-16 13:08:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when PLAYER may have 'GetInMan' to the target VEHICLE 'driver' position.
        We do not need to wait for a VEHICLE asset to be 'KPLIB_surrender' for it to be
        'KPLIB_captured'.

    Parameter(s):
        _vehicle - a VEHICLE object [OBJECT, default: objNull]
        _role - the ROLE in which the UNIT got in [STRING, default: '']
        _unit - any UNIT object [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#GetIn
 */

// We do not care about TURRENT path (ARRAY)
params [
    [Q(_unit), objNull, [objNull]]
    , [Q(_role), "", [""]]
    , [Q(_vehicle), objNull, [objNull]]
];

private _debug = MPARAM(_onPlayerGetInVehicle_debug)
    || (_vehicle getVariable [QMVAR(_onPlayerGetInVehicle_debug), false])
    || (_unit getVariable [QMVAR(_onPlayerGetInVehicle_debug), false])
    ;

private _player = isPlayer _unit;
private _captured = _vehicle setVariable [Q(KPLIB_captured), false];
private _fobUuid = _vehicle getVariable [Q(KPLIB_fobs_fobUuid), ""];

// TODO: TBD: this may be 'the' event handler to consider when gauging whether civ vics are seized...
// TODO: TBD: however the thing to be cautious of here is that the 'side' of the vic is CIVILIAN when there are no occupants
// TODO: TBD: not sure there is an easy way to determine that otherwise, maybe checking the TYPEOF ...
if (_debug) then {
    // TODO: TBD: logging...
};

// No need to CAPTURE vehicles originating at an FOB, or that which was already CAPTURED
if (_player && !_captured && _role == "driver" && _fobUuid == "") then {
    _vehicle setVariable [Q(KPLIB_captured), true, true];

    // Also notify for the player that the asset was indeed captured
    private _displayName = getText (configFile >> Q(CfgVehicles) >> typeOf _vehicle >> Q(displayName));
    [format [localize "%1 captured.", _displayName]] remoteExec [Q(KPLIB_fnc_notification_hint), _unit];
};

if (_debug) then {
    // TODO: TBD: logging...
};

true;
