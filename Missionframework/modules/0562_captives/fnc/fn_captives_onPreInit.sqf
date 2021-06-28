#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onPreInit

    File: fn_captives_onPreInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-09-10
    Last Update: 2021-06-28 09:00:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/remoteExecCall
        https://community.bistudio.com/wiki/moveInCargo#Alternative_Syntax
        https://community.bistudio.com/wiki/assignAsCargoIndex
        https://community.bistudio.com/wiki/unassignVehicle
        http://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitUntilAndExecute-sqf.html
        https://ace3mod.com/wiki/framework/events-framework.html#25-captives-ace_captives
        https://ace3mod.com/wiki/feature/captives.html
        https://github.com/acemod/ACE3/blob/76676eee462cb0bbe400a482561c148d8652b550/addons/captives/functions/fnc_setSurrendered.sqf
 */

// TODO: TBD: may refactor 'captive' instead to 'units'
// TODO: TBD: also, some of this seems more like a proper 'mission' in the missions framework
if (isServer) then {
    ["[fn_captives_preInit] Initializing...", "PRE] [CAPTIVES", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Initialization -----
 */

[] call MFUNC(_presets);
[] call MFUNC(_settings);

if (isServer) then {
    // Server side section

    // Triggers on vehicle creation server side, with client side JIP invocation
    { [Q(KPLIB_vehicle_created), _x] call CBA_fnc_addEventHandler; } forEach [
        { _this call MFUNC(_onVehicleCreated); }
    ];

    // Surrenders first VEHICLES followed by UNITS, also touches INTEL, TIMERS
    { [Q(KPLIB_sectors_captured), _x] call CBA_fnc_addEventHandler; } forEach [
        { _this call MFUNC(_onSectorCapturedScuttleBluforAssets); }
        , { _this call MFUNC(_onSectorCapturedDeleteBluforUnits); }
        , { _this call MFUNC(_onSectorCapturedSurrenderVehicles); }
        , { _this call MFUNC(_onSectorCapturedSurrenderUnits); }
        , { _this call MFUNC(_onSectorCapturedSetIntel); }
        , { _this call MFUNC(_onSectorCapturedCaptiveTimers); }
    ];

    { [QMVAR(_surrender), _x] call CBA_fnc_addEventHandler; } forEach [
        {
            params [Q(_unit)];
            // Set CAPTIVE if not already done so
            if (!captive _unit) then {
                _unit setCaptive true;
            };
        }
        , {
            params [Q(_unit)];
            { _unit setVariable _x; } forEach [
                [Q(KPLIB_surrender), true, true]
                , [Q(KPLIB_captured), false, true]
                , [QMVAR(_timer), [MPARAM(_captiveTimeout)] call KPLIB_fnc_timers_create]
            ];
        }
        , {
            // Arrange for the CAPTIVE ACTIONS across all machines, SERVER+CLIENTS, JIP
            params [Q(_unit)];
            [_unit] remoteExecCall [QMFUNC(_addCaptiveActions), 0, _unit];
        }
        , {
            // TODO: TBD: will have to see how this works together with ACE...
            _this call MFUNC(_playMove);
        }
    ];

    { [QMVAR(_captured), _x] call CBA_fnc_addEventHandler; } forEach [
        {
            params [Q(_unit)];
            // Careful here, some are GLOBAL, others are NOT, by design
            { _unit setVariable _x; } forEach [
                [QMVAR(_uuid), [] call KPLIB_fnc_uuid_create_string, true]
            ];
        }
        , {
            params [Q(_unit)];
            { _unit setVariable _x; } forEach [
                [Q(KPLIB_surrender), true, true]
                , [Q(KPLIB_captured), true, true]
                , [QMVAR(_timer), [MPARAM(_captiveTimeout)] call KPLIB_fnc_timers_create]
            ];
        }
        , { _this call MFUNC(_playMove); }
    ];

    // Wire up some event handlers just besides
    [
        QMVAR(_load)
        , {
            _this spawn {
                params [
                    [Q(_unit), objNull, [objNull]]
                    , [Q(_vehicle), objNull, [objNull]]
                ];

                // TODO: TBD: units are still getting punted out on a 'first load attempt' it seems...
                private _cargo = [_vehicle, Q(cargo), true] call KPLIB_fnc_core_getVehiclePositions;
                // We expect UNIT to move into a CARGO position
                private _cargoIndex = _cargo findIf { isNull (_x#0); };
                if (_cargoIndex >= 0) then {
                    // It is apparently a confirmed bug
                    _unit assignAsCargoIndex [_vehicle, _cargoIndex];
                    _unit moveInCargo _vehicle;
                    waitUntil { sleep 0.1; !isNull objectParent _unit; };
                    // MO+MI a second time appears to be the resolution to workaround
                    moveOut _unit;
                    waitUntil { sleep 0.1; isNull objectParent _unit; };
                    _unit moveInCargo [_vehicle, _cargoIndex];
                };
            };
        }
    ] call CBA_fnc_addEventHandler;

    { [QMVAR(_unload), _x] call CBA_fnc_addEventHandler; } forEach [
        {
            if (!KPLIB_ace_enabled) exitWith {
            };

            _this spawn {
                params [
                    [Q(_unit), objNull, [objNull]]
                    , [Q(_escort), objNull, [objNull]]
                ];

                private _debug = MPARAM(_onPreInit_onUnload_debug)
                    || (_unit getVariable [QMVAR(_onPreInit_onUnload_debug), false])
                    || (_escort getVariable [QMVAR(_onPreInit_onUnload_debug), false])
                    ;

                if (_debug) then {
                    [format ["[fn_captives_onPreInit::onUnload::ace] Entering: [name _escort, name _unit]: %1"
                        , str [name _escort, name _unit]], "CAPTIVES", true] call KPLIB_fnc_common_log;
                };

                private _vehicle = vehicle _unit;

                // Will (re-)show the menu with updated content, i.e. less one unit
                _escort setVariable [QMVAR(_transport), _vehicle, true];

                [_escort, _unit] call ACE_captives_fnc_doUnloadCaptive;

                if (_debug) then {
                    ["[fn_captives_onPreInit::onUnload:ace] Fini", "CAPTIVES", true] call KPLIB_fnc_common_log;
                };
            };
        }
        , {
            if (KPLIB_ace_enabled) exitWith {
            };

            _this spawn {
                params [
                    [Q(_unit), objNull, [objNull]]
                    , [Q(_escort), objNull, [objNull]]
                ];

                private _debug = MPARAM(_onPreInit_onUnload_debug)
                    || (_unit getVariable [QMVAR(_onPreInit_onUnload_debug), false])
                    || (_escort getVariable [QMVAR(_onPreInit_onUnload_debug), false])
                    ;

                if (_debug) then {
                    [format ["[fn_captives_onPreInit::onUnload] Entering: [name _escort, name _unit]: %1"
                        , str [name _escort, name _unit]], "CAPTIVES", true] call KPLIB_fnc_common_log;
                };

                private _vehicle = vehicle _unit;

                // Will (re-)show the menu with updated content, i.e. less one unit
                _escort setVariable [QMVAR(_transport), _vehicle, true];

                // TODO: TBD: just move out? allow the getout handler to do the rest...
                moveOut _unit;

                if (_debug) then {
                    ["[fn_captives_onPreInit::onUnload] Fini", "CAPTIVES", true] call KPLIB_fnc_common_log;
                };
            };
        }
        , {
            _this spawn {
                params [
                    [Q(_unit), objNull, [objNull]]
                    , [Q(_escort), objNull, [objNull]]
                ];

                private _debug = MPARAM(_onPreInit_onUnload_debug)
                    || (_unit getVariable [QMVAR(_onPreInit_onUnload_debug), false])
                    || (_escort getVariable [QMVAR(_onPreInit_onUnload_debug), false])
                    ;

                if (_debug) then {
                    [format ["[fn_captives_onPreInit::onUnload::waitUntil] Entering: [name _escort, name _unit]: %1"
                        , str [name _escort, name _unit]], "CAPTIVES", true] call KPLIB_fnc_common_log;
                };

                waitUntil { sleep 0.1; isNull objectParent _unit; };

                [QMVAR(_unloaded), [_unit]] call CBA_fnc_globalEvent;

                // Wrap it up here and punt it back to the ESCORT
                [_escort] remoteExec [QMFUNC(_showUnloadTransportMenu), _escort];

                if (_debug) then {
                    ["[fn_captives_onPreInit::onUnload::waitUntil] Fini", "CAPTIVES", true] call KPLIB_fnc_common_log;
                };
            };
        }
    ];

    { [QMVAR(_unloaded), _x] call CBA_fnc_addEventHandler; } forEach [
        {
            params [
                [Q(_unit), objNull, [objNull]]
            ];
            if (!KPLIB_ace_enabled) then {
                unassignVehicle _unit;
            };
        }
        , { _this call MFUNC(_playMove); }
    ];

    { [QMVAR(_interrogated), _x] call CBA_fnc_addEventHandler; } forEach [
        {
            params [Q(_unit), Q(_intel)];
            // TODO: TBD: I kinda like this format, but we need to rethink the perspective of the localization part
            [_intel, format [localize "STR_KPLIB_CAPTIVES_INTERROGATED_FORMAT", name _unit]] call KPLIB_fnc_resources_addIntel;
        }
        , {
            params [Q(_unit)];
            { _unit setVariable _x; } forEach [
                [Q(KPLIB_interrogated), true, true]
                , [QMVAR(_timer), [MPARAM(_captiveTimeout)] call KPLIB_fnc_timers_create]
            ];
        }
        , { _this call MFUNC(_playMove); }
    ];

    // Check for 'SetHandcuffed' enemies
    { [Q(ace_captiveStatusChanged), _x] call CBA_fnc_addEventHandler; } forEach [
        { _this call MFUNC(_onAceCaptiveStatusChanged); }
    ];

    // Emit lib captive event on ace event to ensure compatibilty
    [
        Q(ace_captives_moveInCaptive)
        , {
            params [
                [Q(_unit), objNull, [objNull]]
                , [Q(_vehicle), objNull, [objNull]]
            ];

            // Ditto the ACTION MENU path, UNIT was LOADED via the ACE3 path...
            [QMVAR(_loaded), [_unit, _vehicle]] call CBA_fnc_globalEvent;
        }
    ] call CBA_fnc_addEventHandler;

    // Emit lib captive event on ace event to ensure compatibilty
    [Q(ace_captives_moveOutCaptive), {
        params [
            [Q(_unit), objNull, [objNull]]
        ];
        // Emit global event
        [QMVAR(_unloaded), [_unit]] call CBA_fnc_globalEvent;
    }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_captives_preInit] Initialized", "PRE] [CAPTIVES", true] call KPLIB_fnc_common_log;
};

true;
