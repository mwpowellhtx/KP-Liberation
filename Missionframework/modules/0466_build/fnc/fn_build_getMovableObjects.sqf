/*
    KPLIB_fnc_build_getMovableObjects

    File: fn_build_getMovableObjects.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-14 10:29:59
    Last Update: 2021-05-21 01:29:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the OBJECTS which should be PERSISTENT, plus are either MOVABLE
        or have been CAPTURED.

    Parameter(s):
        _markerName - the FOB zone marker name [STRING, default: ""]

    Returns:
        The OBJECTS meeting the BUILD MOVABLE criteria [ARRAY]
 */

// TODO: TBD: marker names probably makes the most sense here...
// TODO: TBD: which would allow us not only to manage FOB zones...
// TODO: TBD: but also potentially FACTORY sectors...
// TODO: TBD: i.e. if we decided to support managing the FACTORY storage containers...
params [
    ["_markerName", "", [""]]
    , ["_range", KPLIB_param_fobs_range, [0]]
];

// Which by definition should also include FOB zones providing we connected those dots already
if (!(_markerName in allMapMarkers)) exitWith {
    [];
};

// TODO: TBD: may refactor in terms of CBA setting... i.e. 'KPLIB_param_build_moveMaxMomentum'
// TODO: TBD: should refactor to the PERSISTENCE module if anywhere
// TODO: TBD: since "moveable" objects are also by definition PERSISTENT objects...
private _maxMom = 1;

private _nearestObjects = nearestObjects [markerPos _markerName, [], KPLIB_param_fobs_range];

private _objectsToMove = _nearestObjects select {
    [_x, _range, [_markerName]] call KPLIB_fnc_persistence_shouldBePersistent
    && (
        _x getVariable ["KPLIB_asset_isMovable", false]
        || _x getVariable ["KPLIB_captured", false]
    )
};

_objectsToMove;
