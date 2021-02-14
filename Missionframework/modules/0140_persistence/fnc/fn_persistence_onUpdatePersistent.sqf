/*
    KPLIB_fnc_persistence_onUpdatePersistent

    File: fn_persistence_onUpdatePersistent.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-13 17:53:54
    Last Update: 2021-02-13 17:53:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Updates the set of objects tallied by the 'KPLIB_persistence_objects' array. Eligible objects:
            - are considered 'within' an FOB zone
            - isKindOf 'Ground', 'Air', 'Boat', and, with rare exceptions, also 'UAV' or 'UGV'
            - is considered 'idle' or 'at rest' i.e. with no, or minimal, momentum in ANY direction, positive or negative
            - which crew has entirely disembarked, again with rare exception, i.e. 'UAV' or 'UGV'
            - is considered 'built' or 'seized', i.e. civilian or enemy assets
        Ineligible assets, of course, violate any of the above criteria, and are therefore purged from
        the queue. Of course, obvious disqualifications include whether the vehicle is 'alive'.

    Parameter(s):
        NONE

    Returns:
        The 'KPLIB_updatePersistence' event handler has completed [BOOL]
 */

// using:
// KPLIB_sectors_fobs
// KPLIB_persistence_objects

private _shouldBePersisted = {
    params [
        ["_asset", objNull, [objNull]]
    ];
    // TODO: TBD: note that we may adopt an exception to the crew issue, i.e. for unmanned assets
    // TODO: TBD: perhaps a parameter driven option therein as well...
    /* Criteria, _asset is:
     *  - not null
     *  - alive
     *  - mostly idle, at rest, without momentum
     *  - completely disembarked, no crew, excluding itself
     *  - a kind of one of the module variable listed kinds, i.e. "Ground", "Air", etc
     *  - within range of any of the known FOB zones
     */
    !isNull _asset
        && alive _asset
        && abs (speed _asset) < 1
        && (crew _asset - [_asset]) isEqualTo []
        // TODO: TBD: are kinds of objects? or that they originated at a FOB? vis-a-vis its UUID ...
        && !((KPLIB_persistence_kindsOf select { _asset isKindOf _x; }) isEqualTo [])
        && [_asset, KPLIB_preset_fobRange, KPLIB_sectors_fobs] call KPLIB_fnc_common_getTargetMarkerInRange
        ;
};

// General sweep of potential candidates before the final sweep which ones should be
private _candidates = vehicles select {
    private _asset = _x;
    /* Criteria, _candidate that is:
     *  - not already included among the objects
     *  - within range of any of the known FOB zones
     */
    (0 > (KPLIB_persistence_objects findIf { _asset isEqualTo _x; }))
        && [_asset, KPLIB_preset_fobRange, KPLIB_sectors_fobs] call KPLIB_fnc_common_getTargetMarkerInRange
    ;
};

//forEach _candidates;
//KPLIB_persistence_objects  _candidates;

// This aspect of the algorithm allows only vehicles which meet the criteria
KPLIB_persistence_objects = KPLIB_persistence_objects select {
    [_x] call _shouldBePersisted;
};
