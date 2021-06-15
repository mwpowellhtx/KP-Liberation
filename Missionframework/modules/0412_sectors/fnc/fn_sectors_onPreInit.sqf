#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onPreInit

    File: fn_sectors_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 13:33:30
    Last Update: 2021-06-14 16:51:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/createHashMapFromArray
        https://community.bistudio.com/wiki/Category:Function_Group:_Bitwise
        https://community.bistudio.com/wiki/a_%5E_b (a ^ b)
 */

if (isServer) then {
    ["[fn_sectors_onPreInit] Initializing...", "PRE] [SECTORS", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */


/*
    ----- Module Initialization -----
 */

// Process CBA settings, must be processed first, etc
[] call MFUNC(_presets);
[] call MFUNC(_settings);
// [] call MFUNC(_status);

// Server section (dedicated and player hosted)
if (isServer) then {

    MVAR(_namespaces)                                               = [];

    // For use informing the state machine
    MVAR(_allActive)                                                = [];

    MVAR(_serializationRegistry) = [QMVAR(_markerName)] call KPLIB_fnc_namespace_createSerializationRegistry;

    // TODO: TBD: may register other variable names...
    [MVAR(_serializationRegistry), [
            QMVAR(_markerPos)
        ]] call KPLIB_fnc_namespace_registerSerializationVars;

    MVAR(_refresh)                                                  = QMVAR(_refresh);
    // MVAR(_activating)                                               = QMVAR(_activating);
    // MVAR(_activated)                                                = QMVAR(_activated);
    // MVAR(_deactivating)                                             = QMVAR(_deactivating);
    // MVAR(_deactivated)                                              = QMVAR(_deactivated);

    // // TODO: TBD: for follow up later: https://github.com/mwpowellhtx/KP-Liberation/issues/78
    // // TODO: TBD: for now, making a best possible effort to minimize the shake up in order to accomplish HUD overlays
    // // TODO: TBD: we think these only ever need to be defined server side...

    // Add event handlers
    [Q(KPLIB_doLoad), { [] call MFUNC(_onLoadData); }] call CBA_fnc_addEventHandler;
    [Q(KPLIB_doSave), { [] call MFUNC(_onSaveData); }] call CBA_fnc_addEventHandler;

    { [QMVAR(_refresh), _x] call CBA_fnc_addEventHandler; } forEach [
        { _this call MFUNC(_onRefreshSide); }
        , { _this call MFUNC(_onRefreshSectors); }
        , { _this call MFUNC(_onRefreshBuckets); }
        , { _this call MFUNC(_onRefreshProximities); }
    ];

    // The question may only be asked in a PLAYER centric manner especially in cases where there is zero proximity
    [QMVAR(_notifySitRep), { _this call MFUNC(_onNotifySitRep); }] call CBA_fnc_addEventHandler;

    { [QMVAR(_activating), _x] call CBA_fnc_addEventHandler; } forEach [
        { _this call MFUNC(_onActivating); }
    ];

    { [QMVAR(_captured), _x] call CBA_fnc_addEventHandler; } forEach [
        { _this call MFUNC(_onCapturedSetCaptured); }
        , { _this call MFUNC(_onCapturedUpdateArrays); }
        , { _this call MFUNC(_onCapturedShowNotification); }
        , { [Q(KPLIB_updateMarkers)] call CBA_fnc_serverEvent; }
        , { [[QMVAR(_captured), Q(callback)] joinString "::"] spawn KPLIB_fnc_init_save; }
    ];

    { [QMVAR(_tearDown), _x] call CBA_fnc_addEventHandler; } forEach [
        { _this call MFUNC(_onTearDownVars); }
    ];

    [Q(KPLIB_updateMarkers), { [] call MFUNC(_onUpdateMarkers); }] call CBA_fnc_addEventHandler;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_sectors_onPreInit] Initialized", "PRE] [SECTORS", true] call KPLIB_fnc_common_log;
};

true;
