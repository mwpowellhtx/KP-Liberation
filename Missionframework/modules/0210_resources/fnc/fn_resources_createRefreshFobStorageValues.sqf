/*
    KPLIB_fnc_resources_createRefreshFobStorageValues

    File: fn_resources_createRefreshFobStorageValues.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-15 20:04:43
    Last Update: 2021-02-15 20:04:45
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
        /* We require a bit more fluid comprehension of FOBs, since
         * they can change composition at a moment's notice. */

        private _fobs = KPLIB_sectors_fobs;

        // Mod, in the event FOB is lost, repackaged, etc, in the meanwhile...
        private _fob = _fobs select (_tick mod (count _fobs));
        //                           ^^^^^^^^^^^^^^^^^^^^^^^

        private _storageContainers = [_fob] call KPLIB_fnc_resources_getFobStorages;

        ["_fobStorages", _storageContainers] call KPLIB_fnc_resources_onRefreshStorageValues;

        _tick = _tick + 1;

        // Allowing per frame to cycle through the FOBs...
        if (_tick >= count _fobs) then {
            [] call (_this getVariable "start");
        };
    }
    , KPLIB_param_resources_refreshStorageValuePeriodSeconds
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
