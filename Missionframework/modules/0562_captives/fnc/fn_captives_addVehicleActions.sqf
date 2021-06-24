#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_captives_addVehicleActions

    File: fn_captives_addVehicleActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 12:18:24
    Last Update: 2021-06-17 12:18:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Wires up the module event handlers on the VEHICLE. We will go ahead and simply add
        the bits on the VEHICLE now so we do not need to worry about it a second time.

        On the client side, we install an UNLOAD CAPTIVES action, which is a top level
        view which opens an UNLOAD CAPTIVES COMMANDING MENU, which itself shall enumerate
        the CAPTIVES that may be unloaded.

        On the server side, responds to UNIT GETOUT events. In which case we may handle
        UNIT bookkeeping, as well as VEHICLE bits.

    Parameter(s):
        _vehicle - a VEHICLE to consider [OBJECT, default: objNull]

    Returns:
        The callback has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#GetIn
 */

params [
    [Q(_vehicle), objNull, [objNull]]
];

private _debug = MPARAM(_addVehicleActions_debug)
    || (_unit getVariable [QMVAR(_addVehicleActions_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

if (isServer) then {
    // Server section

    if ((_vehicle getVariable [QMVAR(_playerGetInManID), -1]) < 0) then {
        private _playerGetInManID = _vehicle addEventHandler [Q(GetInMan), { _this call MFUNC(_onPlayerGetInVehicle); }];
        _vehicle setVariable [QMVAR(_playerGetInManID), _playerGetInManID];
    };

    if ((_vehicle getVariable [QMVAR(_unitGetInManID), -1]) < 0) then {
        private _unitGetInManID = _vehicle addEventHandler [Q(GetInMan), { _this call MFUNC(_onUnitGetInVehicle); }];
        _vehicle setVariable [QMVAR(_unitGetInManID), _unitGetInManID];
    };

    if ((_vehicle getVariable [QMVAR(_getOutManID), -1]) < 0) then {
        private _getOutManID = _vehicle addEventHandler [Q(GetOutMan), { _this call MFUNC(_onUnitGetOutVehicle); }];
        _vehicle setVariable [QMVAR(_getOutManID), _getOutManID];
    };
};

// We will 'allow' this menu, it is just htat useful
if (hasInterface) then {
    // Client section

    // Add module actions to the VEHICLE itself as an alternative
    [
        _vehicle
        , [
            "STR_KPLIB_ACTION_CAPTIVES_UNLOAD_CAPTIVES"
            , {
                params [
                    [Q(_vehicle), objNull, [objNull]]
                    , [Q(_escort), objNull, [objNull]]
                ];
                _escort setVariable [QMVAR(_transport), _vehicle, true];
                [_escort] call MFUNC(_showUnloadTransportMenu);
            }
            , _unit
            , KPLIB_ACTION_PRIORITY_CAPTIVE_ACTIONS
            , false
            , true
            , ""
            , '
                alive _target
                    && alive _this
                    && (([_target] call KPLIB_fnc_captives_getLoadedCaptives) isNotEqualTo [])
            '
            , MPARAM(_loadRange)
        ]
        , [
            [Q(_varName), QMVAR(_unloadCaptivesID)]
        ]
    ] call KPLIB_fnc_common_addAction;
};

if (hasInterface && !KPLIB_ace_enabled) then {
    // Client section

    // [
    //     _vehicle
    //     , [
    //         "STR_KPLIB_ACTIONS_CAPTIVES_LOAD_CAPTIVE"
    //         , {
    //             params [Q(_vehicle), Q(_escort)];
    //             private _unit = [_escort] call MFUNC(_getEscortedUnit);
    //             _unit setVariable [QMVAR(_transport), _vehicle];
    //             [_unit, _escort] call MFUNC(_onUnitLoad);
    //         }
    //         , _unit
    //         , KPLIB_ACTION_PRIORITY_CAPTIVE_ACTIONS
    //         , false
    //         , true
    //         , ""
    //         , '
    //             (alive _target)
    //                 && ([_this] call KPLIB_fnc_captives_isEscorting)
    //                 && (alive ([_this] call KPLIB_fnc_captives_getEscortedUnit))
    //                 && ([_target, [_this] call KPLIB_fnc_captives_getEscortedUnit] call KPLIB_fnc_captives_canLoadTransport)
    //         '
    //         , MPARAM(_loadRange)
    //     ]
    //     , [
    //         [Q(_varName), QMVAR(_loadUnitID)]
    //     ]
    // ] call KPLIB_fnc_common_addAction;
};

if (_debug) then {
    // TODO: TBD: logging...
};

true;
