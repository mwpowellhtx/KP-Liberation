/*
    KPLIB_fnc_logistics_onPostInit

    File: fn_logistics_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 14:47:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        NONE

    Returns:
        NONE
 */

if (isServer) then {
    ["[fn_logistics_onPostInit] Initializing...", "POST] [LOGISTICS", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section (dedicated and player hosted)

    // Arranges for a tuple template example...
    KPLIB_logistics_tupleTemplate = [] call KPLIB_fnc_logistics_createArray;

    // Setup a couple of endpoint tuple templates...
    private _pos = +KPLIB_zeroPos;
    private _markerName = "";
    private _baseMarkerText = "";
    private _billValue = +KPLIB_resources_storageValueDefault;

    KPLIB_logistics_endpointTemplate_unassigned = +[
        _pos
        , _markerName
        , _baseMarkerText
    ];

    KPLIB_logistics_endpointTemplate_assigned = +[
        _pos
        , _markerName
        , _baseMarkerText
        , _billValue
    ];
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_logistics_onPostInit] Initialized", "POST] [LOGISTICS", true] call KPLIB_fnc_common_log;
};

true;
