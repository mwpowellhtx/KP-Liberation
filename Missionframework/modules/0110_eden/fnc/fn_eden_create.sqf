/*
    KPLIB_fnc_eden_create

    File: fn_eden_create.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-27 11:44:00
    Last Update: 2021-01-27 11:44:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns one element in the 'KPLIB_sectors_edens' array.

    Parameter(s):
        _varName - the 'missionNamespace' variable name [STRING, default: ""]
        _proxy - the 'missionNamespace' object corresponding _varName [OBJECT, default: ""]

    Returns:
        [] - when _proxy was objNull

        When _proxy is valid the return tuple is complete:
        [
            _varName
            , [_uuid, systemTime]
            , [_sectorType = KPLIB_sectorType_eden, _pos = getPosATL _proxy, _side]
            , [_markerName, _markerText]
        ]
*/

params [
    ["_varName", "", [""]]
    , ["_proxy", objNull, [objNull]]
];

if (isNull _proxy) then {
    _proxy = missionNamespace getVariable [_varName, objNull];
};

// Return only when we have a non-null proxy in hand
if (!isNull _proxy) exitWith {

    /* The goal here is to not only keep the intermediate variables during tuple
    * deconstruction to a minimum, but also to tighten up the point of interest
    * construct altogether. Especially as we approach downstream bits such as
    * production, logistics, etc. We want to keep the tuple breadth to a minimum
    * and tight. */

    private _retval = +[
        [_varName, "_marker"] joinString ""
        , _proxy getVariable ["KPLIB_eden_markerText", localize "STR_KPLIB_MAINBASE"]
        , _varName
        , [] call KPLIB_fnc_uuid_create_string
        , getPosATL _proxy
        , systemTime
    ];

    _retval;
};
