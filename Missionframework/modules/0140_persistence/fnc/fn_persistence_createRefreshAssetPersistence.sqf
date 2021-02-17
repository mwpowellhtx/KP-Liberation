/*
    KPLIB_fnc_persistence_createRefreshAssetPersistence

    File: fn_persistence_createRefreshAssetPersistence.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-16 17:01:02
    Last Update: 2021-02-16 17:01:04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        CBA per frame refresh for assets aligible in proximity of FOB zones.

    Parameter(s):
        NONE

    Returns:
        NONE

    References:
        https://github.com/mwpowellhtx/KP-Liberation/issues/39
        https://courses.lumenlearning.com/physics/chapter/16-2-period-and-frequency-in-oscillations
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createPerFrameHandlerObject-sqf.html#CBA_fnc_createPerFrameHandlerObject
 */
 
 [
    {
        private _fobs = KPLIB_sectors_fobs;
        private _range = KPLIB_param_fobRange;

        /* Reconcile 'KPLIB_persistence_objects' in three overall steps:
         *  - acquire the factory storage containers
         *  - identify the objects that should be excluded, apart from FOB and not already in storage containers
         *  - roll up objects in proximity of FOB and other criteria
         *
         * Following that, push back the objects to include, and exclude the objects to exclude.
         */

        private _storageContainersToInclude = [];

        // Start by obtaining the factory sector storage objects...
        (KPLIB_sectors_factory select { _x in KPLIB_sectors_blufor }) select {
            private _factoryMarker = _x;
            private _storageContainers = [_factoryMarker] call KPLIB_fnc_resources_getFactoryStorages;
            _storageContainersToInclude append _storageContainers;
        };

        // Identify the objects to exclude...
        private _objectsToExclude = KPLIB_persistence_objects select {
            private _object = _x;
            [
                (_object in _storageContainersToInclude)
                , ([_object, _range, _fobs] call KPLIB_fnc_persistence_whereAssetShouldBeFobPersistent)
            ] params [
                "_objectIsStorageContainer"
                , "_shouldBeFobPersistent"
            ];
            !(
                _objectIsStorageContainer
                || _shouldBeFobPersistent
            );
        };

        // Roll up the FOB objects to include...
        private _fobObjectsToInclude = [];

        _fobs select {
            private _fob = _x;
            // If performance is going to suffer, this is why... So we dial back the frequency...
            private _objects = nearestObjects [(_fob#4), [], _range];
            _objects = _objects select {
                [_x] call KPLIB_fnc_persistence_whereAssetMayBeFobPersistent;
            };
            _objects = _objects select {
                [_x, _range, [_fob]] call KPLIB_fnc_persistence_whereAssetShouldBeFobPersistent;
            };
            _fobObjectsToInclude append _objects;
            true;
        };

        // Prepare the replacement array of objects...
        private _persistenceObjects = (_fobObjectsToInclude + _storageContainersToInclude) - _objectsToExclude;

        private _netIds = [_persistenceObjects apply {netId _x}, []] call BIS_fns_sortBy;
        private _previousNetIds = [KPLIB_persistence_objects apply {netId _x}, []] call BIS_fnc_sortBy;

        // Only replace it when the ordered identifiers are different...
        if (!(_netIds isEqualTo _previousNetIds)) then {
            KPLIB_persistence_objects = _persistenceObjects;
        };
    }
    , KPLIB_param_persistence_refreshFobAssetPersistencePeriodSeconds
    , []
    , {
        // No-op, there are no variables worth resetting in this handler worth
    }
    , nil
    , {
        // Wait for the campaign, yes, but also critical, do not start rolling up until loaded
        KPLIB_campaignRunning
            && KPLIB_save_loaded;
    }
    , nil
    , [
        // Ditto above, there are no variables to consider between iterations
    ]
] call CBA_fnc_createPerFrameHandlerObject;
