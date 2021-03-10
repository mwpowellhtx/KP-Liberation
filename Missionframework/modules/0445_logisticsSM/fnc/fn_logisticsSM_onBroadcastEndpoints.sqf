/*
    KPLIB_fnc_logisticsSM_onBroadcastEndpoints

    File: fn_logisticsSM_onBroadcastEndpoints.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 18:11:13
    Last Update: 2021-03-01 18:11:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Broadcasts the ENDPOINT array to all listening '_cids' logistics managers.

    Parameters:
        _cids - the client identifiers to address with the ENDPOINT broadcast [ARRAY, default: []]
        _endpoints - the ENDPOINT array being broadcast [ARRAY, default: []]

    Returns:
        The callback finished [BOOL]
 */

private _objSM = missionNamespace getVariable ["KPLIB_logisticsSM_objSM", locationNull];

// TODO: TBD: will want to monitor for sector and FOB changes and raise the event when necessary
// TODO: TBD: could do so during on of the SM states, entered, etc...
// TODO: TBD: and/or a wholely separate per frame event handler...

params [
    ["_cids", (_objSM getVariable ["KPLIB_logistics_cids", []]), [[]]]
    , ["_endpoints", ([] call KPLIB_fnc_logistics_getEndpoints), [[]]]
];

private _onPublishEndpoints = {
    params [
        ["_cid", -1, [0]]
    ];
    private _published = [_cid, _endpoints] call KPLIB_fnc_logisticsSM_onPublishEndpoints;
};

{ [_x] call _onPublishEndpoints; } forEach _cids;

true;
