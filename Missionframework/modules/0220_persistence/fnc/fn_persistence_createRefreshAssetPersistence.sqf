/*
    KPLIB_fnc_persistence_createRefreshAssetPersistence

    File: fn_persistence_createRefreshAssetPersistence.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-16 17:01:02
    Last Update: 2021-05-23 14:41:23
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

// TODO: TBD: will come back to this one...
[
    {
        private _fobObjects = [] call KPLIB_fnc_persistence_getObjects;

        private _factoryStorageContainers = [
            [] call KPLIB_fnc_sectors_getBluforFactorySectors
            , KPLIB_param_sectors_capRange
            , KPLIB_resources_factoryStorageClasses
        ] call KPLIB_fnc_persistence_getObjects;

        KPLIB_persistence_objects = flatten [_fobObjects, _factoryStorageContainers];

        // TODO: TBD: rinse and repeat for 'units' to save...
    }
    , KPLIB_param_persistence_refreshObjectsPeriodSeconds
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
