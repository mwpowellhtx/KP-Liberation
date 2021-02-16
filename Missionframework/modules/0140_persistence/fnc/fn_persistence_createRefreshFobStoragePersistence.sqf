/*
    KPLIB_fnc_persistence_createRefreshFobStoragePersistence

    File: fn_persistence_createRefreshFobStoragePersistence.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-15 12:25:57
    Last Update: 2021-02-15 12:26:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        CBA per frame refresh FOB zone storage container persistence.

    Parameter(s):
        NONE

    Returns:
        NONE

    References:
        https://courses.lumenlearning.com/physics/chapter/16-2-period-and-frequency-in-oscillations
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createPerFrameHandlerObject-sqf.html#CBA_fnc_createPerFrameHandlerObject
 */

[
    {
        private _fobs = KPLIB_sectors_fobs;

        private _fob = _fobs select (_tick mod (count _fobs));

        private _storageContainers = [_fob] call KPLIB_fnc_resources_getFobStorages;

        ["_fobStorage", _storageContainers] call KPLIB_fnc_persistence_onReconcilePersistenceObjects;

        _tick = _tick + 1;

        // Rolls over when tick exceeds the count
        if (_tick >= count _fobs) then {
            [] call (_this getVariable "start");
        };
    }
    , KPLIB_param_persistence_refreshStoragePeriodSeconds
    , []
    , {
        _tick = 0;
    }
    , nil
    , {
        // Wait for the campaign, yes, but also critical, do not start rolling up until loaded
        KPLIB_campaignRunning
            && KPLIB_save_loaded;
    }
    , nil
    , [
        "_tick"
    ]
] call CBA_fnc_createPerFrameHandlerObject;
