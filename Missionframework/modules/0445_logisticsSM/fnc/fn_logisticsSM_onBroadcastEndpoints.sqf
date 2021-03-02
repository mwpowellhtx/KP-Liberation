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

// TODO: TBD: will want to monitor for sector and FOB changes and raise the event when necessary
// TODO: TBD: could do so during on of the SM states, entered, etc...
// TODO: TBD: and/or a wholely separate per frame event handler...

params [
    ["_cids", (KPLIB_logisticsSM_namespace getVariable ["KPLIB_logistics_cids", []]), [[]]]
    , ["_endpoints", ([] call KPLIB_fnc_logistics_getEndpoints), [[]]]
];

private _onPublishEndpoints = {
    param [
        ["_cid", -1, [0]]
    ];
    [_cid, _endpoints] call KPLIB_fnc_logisticsSM_onPublishEndpoints;
    true;
};

_cids select _onPublishEndpoints;

true;
