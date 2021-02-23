/*
    KPLIB_fnc_productionsm_onProducingResourceRaised

    File: fn_productionsm_onProducingResourceRaised.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-22 17:33:37
    Last Update: 2021-02-22 17:33:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Producer change order raised event handler callback. Yes, we treat production
        as a change order of sorts. From a shape perspective it is the same sort of
        entity, even though semantically it is a bit different. In this case, we do
        not care about any client identifiers as this particular change order is strictly
        server bound.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]
        _queueAlpha - the '_queueAlpha' before approaching production activities [ARRAY, default: []]
        _queueBravo - the '_queueBravo' after following production activities [ARRAY, default: []]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_queueAlpha", [], [[]]]
    , ["_queueBravo", [], [[]]]
];

private _debug = [
    [
        "KPLIB_param_productionsm_raise_debug"
        , "KPLIB_param_productionsm_changeOrders_debug"
        , "KPLIB_param_productionsm_raiseProducingResource_debug"
        , { _namespace getVariable ["KPLIB_param_productionsm_raise_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_changeOrders_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_raiseProducingResource_debug", false]; }
    ]
] call KPLIB_fnc_productionsm_debug;

private _baseMarkerText = _namespace getVariable ["_baseMarkerText", ""];
private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

// Zip the reversed alpha and bravo components
private _zipped = [
        [_queueAlpha] call KPLIB_fnc_linq_reverse
        , [_queueBravo] call KPLIB_fnc_linq_reverse
        , { (_this#0) isEqualTo (_this#1); }
        , true
    ] call KPLIB_fnc_linq_zip;

_zipped params [
    ["_equality", [], [[]]]
    , ["_remAlpha", [], [[]]]
    , ["_remBravo", [], [[]]]
];

/* TODO: TBD: we might put some error handling in... for now:
 *  - assuming: (_equality select { !_x; }) isEqualTo []
 *  - assuming: _remBravo isEqualTo []
 *  - assuming: count _remAlpha == 1                       // literally, the thing being produced
 *  - assuming: (_remAlpha#0) in KPLIB_resources_indexes   // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 * Assuming all these preconditions are true, then we settle into the business
 * of identifying storage containers, creating resources, etc.
 */

// Select the most available storage container within the factory sector proximity
private _targetStorage = [_markerName] call {
    params [
        ["_markerName", "", [""]]
    ];
    private _candidateStorages = [_markerName] call KPLIB_fnc_resources_getFactoryStorages;
    private _storagesWithSpace = _candidateStorages apply {
        [_x, [_x] call KPLIB_fnc_resources_getStorageSpace];
    } select {
        // Only identify storages with available space
        (_x#1) > 0;
    };
    if (_storagesWithSpace isEqualTo []) exitWith { objNull; };
    private _sortedStorage = [_storagesWithSpace, [], { (_x#1); }, "DESCEND"] call BIS_fnc_sortBy;
    (_sortedStorage deleteAt 0)#0;
};

if ([_namespace, _targetStorage, (_remAlpha#0)] call KPLIB_fnc_productionsm_tryProducingResource) then {
    _namespace setVariable ["_previousQueue", _queueAlpha];
    _queueBravo;
} else {
    // TODO: TBD: and log that this is the case...
    // TODO: TBD: may also do what with the timers involved, leave them unchanged (?)
    _queueAlpha;
};
