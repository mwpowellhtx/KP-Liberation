/*
    KPLIB_fnc_resources_createRefreshFactoryStorageValues

    File: fn_resources_createRefreshFactoryStorageValues.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-15 20:04:49
    Last Update: 2021-02-15 20:04:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Adds a CBA frame event loop callback that refreshes 'KPLIB_resources_storageValue'.

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
        // Allowing for moments when the snapshot itself may fall out of sync for whatever reason
        private _markerName = _factorySectors select (_tick mod (count _factorySectors));
        //                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

        private _storageContainers = [_markerName] call KPLIB_fnc_resources_getFactoryStorages;

        ["_factoryStorages", _storageContainers] call KPLIB_fnc_resources_onRefreshStorageValues;

        _tick = _tick + 1;

        // Allowing per frame to cycle through the factory sectors...
        if (_tick >= count _factorySectors) then {
            [] call (_this getVariable "start");
        };
    }
    , KPLIB_param_resources_refreshStorageValuePeriodSeconds
    , []
    , {
        _tick = 0;
        // TODO: TBD: refactor this pattern, it is popping up in many places...
        _factorySectors = KPLIB_sectors_factory select { (_x in KPLIB_sectors_blufor); };
        //                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
        , "_factorySectors"
    ]
] call CBA_fnc_createPerFrameHandlerObject;
