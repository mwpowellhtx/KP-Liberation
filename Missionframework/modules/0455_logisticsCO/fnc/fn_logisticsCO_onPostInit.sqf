/*
    KPLIB_fnc_logisticsCO_onPostInit

    File: fn_logisticsCO_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 10:22:42
    Last Update: 2021-03-06 10:22:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        NONE

    Returns:
        NONE

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html
 */

if (isServer) then {
    ["[fn_logisticsCO_onPostInit] Initializing...", "POST] [LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section (dedicated and player hosted)

    // TODO: TBD: refactor as proper function...
    KPLIB_fnc_logisticsCO_getTransportDebit = {
        params [
            ["_transportBaseCost", KPLIB_param_logistics_transportBaseCost, [0]]
        ];
        // ["_supply", "_ammo", "_fuel"]
        [_transportBaseCost, 0, _transportBaseCost];
    };

    // TODO: TBD: for now, doing it this way...
    // TODO: TBD: but it opens the mission up for gaming the system...
    // TODO: TBD: reconsider how we do this, i.e. factoring in TRANSPORT ECONOMICS, cost/value at the time of purchase...
    KPLIB_fnc_logisticsCO_getTransportCredit = {
        params [
            ["_transportBaseCost", KPLIB_param_logistics_transportBaseCost, [0]]
        ];
        private _factor = KPLIB_param_logistics_transportRecycleValue / 100;
        private _debit = [_transportBaseCost] call KPLIB_fnc_logisticsCO_getTransportDebit;
        _debit apply { (_x * _factor); };
    };

    // Sets up to listen for add/remove line requests
    //[] call KPLIB_fnc_logisticsCO_onAddOrRemoveLines;

    // Allow for line change requests via client server event handling
    [KPLIB_logisticsCO_requestAddOrRemoveLines, KPLIB_fnc_logisticsCO_onRequestAddOrRemoveLines] call CBA_fnc_addEventHandler;

    // Allow for building and recycling convoy transports
    [KPLIB_logisticsCO_requestTransportBuild, KPLIB_fnc_logisticsCO_onRequestTransportBuild] call CBA_fnc_addEventHandler;
    [KPLIB_logisticsCO_requestTransportRecycle, KPLIB_fnc_logisticsCO_onRequestTransportRecycle] call CBA_fnc_addEventHandler;

    [KPLIB_logisticsCO_requestMissionConfirm, KPLIB_fnc_logisticsCO_onRequestMissionConfirm] call CBA_fnc_addEventHandler;
    [KPLIB_logisticsCO_requestMissionReroute, KPLIB_fnc_logisticsCO_onRequestMissionReroute] call CBA_fnc_addEventHandler;
    [KPLIB_logisticsCO_requestMissionAbort, KPLIB_fnc_logisticsCO_onRequestMissionAbort] call CBA_fnc_addEventHandler;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_logisticsCO_onPostInit] Initialized", "POST] [LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

true;
