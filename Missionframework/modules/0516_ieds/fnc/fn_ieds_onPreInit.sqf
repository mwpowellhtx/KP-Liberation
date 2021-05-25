#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_onPreInit

    File: fn_ieds_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-22 18:00:56
    Last Update: 2021-05-23 21:53:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/xeh/fnc_addClassEventHandler-sqf.html
        https://community.bistudio.com/wiki/ArmA:_Armed_Assault:_Event_Handlers#Init
        https://community.bistudio.com/wiki/ArmA:_Armed_Assault:_Event_Handlers#Hit
        https://community.bistudio.com/wiki/ArmA:_Armed_Assault:_Event_Handlers#Killed
 */

if (isServer) then {
    ["[fn_ieds_onPreInit] Initializing...", "PRE] [IEDS", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */

// Ordered generally in terms of size and impact from least to greatest
private _smallPrefixes                      = [
    Q(IEDLandSmall)
    , Q(IEDUrbanSmall)
];

private _bigPrefixes                      = [
    Q(IEDLandBig)
    , Q(IEDUrbanBig)
];

// There is also a difference between the starting CLASS NAME and the MINE CLASS NAMES
MPRESET(_classNames)                        = (_smallPrefixes + _bigPrefixes) apply {
    private _prefix = _x;
    format ["%1_F", _prefix];
};

private _onFormatRemoteAmmo = {
    private _prefix = _x;
    format ["%1_Remote_Ammo", _prefix];
};

MPRESET(_smallClassNames)                   = _smallPrefixes apply _onFormatRemoteAmmo;
MPRESET(_bitClassNames)                     = _bigPrefixes apply _onFormatRemoteAmmo;
MPRESET(_mineClassNames)                    = (_smallPrefixes + _bigPrefixes) apply _onFormatRemoteAmmo;


/*
    ----- Module Initialization -----
 */

// Process CBA Settings, must be processed first
[] call MFUNC(_settings);

if (isServer) then {
    // Server section (dedicated and player hosted)

    // // // TODO: TBD: events are not fired from these objects, so we have to take matters into our own hands
    // // RETROACTIVE should not be an issue, but set it anyway
    // {
    //     private _className = _x;
    //     [_className, Q(init), { _this call MFUNC(_onObjectInit); }, true, [], true] call CBA_fnc_addClassEventHandler;
    //     [_className, Q(hit), { _this call MFUNC(_onObjectHitOrKilled); }, true, [], true] call CBA_fnc_addClassEventHandler;
    //     [_className, Q(killed), { _this call MFUNC(_onObjectHitOrKilled); }, true, [], true] call CBA_fnc_addClassEventHandler;
    // } forEach MPRESET(_classNames);

    [Q(KPLIB_vehicle_created), { _this call MFUNC(_onMineSpawned); }] call CBA_fnc_addEventHandler;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section

    [Q(KPLIB_player_redeploy), { _this call MFUNC(_setupPlayerActions); }] call CBA_fnc_addEventHandler;
};

if (isServer) then {
    ["[fn_ieds_onPreInit] Initialized", "PRE] [IEDS", true] call KPLIB_fnc_common_log;
};

true;
