/*
    KPLIB_fnc_core_handleSector

    File: fn_core_handleSector.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-05-06
    Last Update: 2021-04-16 08:35:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles an activated sector concerning which scripts should be started and checks for a later deactivation.

    Parameter(s):
        _markerName - a SECTOR marker name [STRING, defaults: nil]

    Returns:
        The function has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createPerFrameHandlerObject-sqf.html
 */

// TODO: TBD: eventually "handling" sectors refactors to the SECTORS module and into SM support...
params [
    ["_markerName", nil, [""]]
];

// Create sector handler PFH Object
private _handler = [
    // Handler
    {
        // Per Tick
        _this getVariable "params" params ["_sector", "_sectorPos"];

        // TODO: TBD:: optimize

        // If the enemy units within capture range are outnumbered and there are no enemy tanks capture the sector
        if (
            (
                // TODO: TBD: times 1.5? no, there's 'cap' range and there's 'act' range, use the act range...
                ({side _x isEqualTo KPLIB_preset_sideF} count (_sectorPos nearEntities ["AllVehicles", KPLIB_param_sectors_capRange])) >
                ({side _x isEqualTo KPLIB_preset_sideE} count (_sectorPos nearEntities ["AllVehicles", KPLIB_param_sectors_capRange * 1.5]))
                    * KPLIB_param_sectors_capRatio
            ) && {
                ({side _x isEqualTo KPLIB_preset_sideE} count (_sectorPos nearEntities ["Tank", KPLIB_param_sectors_capRange * 1.5]))
                isEqualTo 0
            }
        ) then {
            // TODO: TBD: which, being if this is a condition, then it should probably also inform the SECTOR OVERLAY conditions...
            [format ["Sector %1 (%2) captured", markerText _sector, _sector], "CORE", true] call KPLIB_fnc_common_log;
            _this setVariable ["KPLIB_sectorActive", false];
            // TODO: TBD: so... the sector only ever changes to "player" control?
            // TODO: TBD: this is probably either an oversight ...
            [_sector] call KPLIB_fnc_sectorsSM_onChangeAlignment;
        }
        else {
            // If there are no friendly units in activation range, deactivate the sector
            if !([_sectorPos, KPLIB_param_sectors_actRange] call KPLIB_fnc_units_checkNear) then {
                _this setVariable ["KPLIB_sectorActive", false];
            }
        }
    }
    // Delay
    , (15 + random 5)
    // Args
    , [_markerName, markerPos _markerName]
    , {
        // Start func
        _this getVariable "params" params ["_sector"];

        [format ["----- Sector %1 (%2) activated -----", markerText _sector, _sector], "CORE", true] call KPLIB_fnc_common_log;

        _this setVariable ["KPLIB_sectorActive", true];

        // TODO: TBD: ditto here as for the end func...
        // TODO: TBD: actually "handle sector" is this more of a state machine?
        // TODO: TBD: with the actual states, set of sectors, etc, falling in and out of the SM accordingly...
        // TODO: TBD: and with sector "wrapper" name spaces for purposes of keeping tabs on their activities...
        // TODO: TBD: which might also be useful when tapping in during HUD overlay activities
        // TODO: TBD: and so forth...
        KPLIB_sectors_active pushBack _sector;
        // TODO: TBD: we really need to make the var public?
        publicVariable "KPLIB_sectors_active";
        [KPLIB_sector_activated, [_sector]] call CBA_fnc_globalEvent;
    }
    , {
        // End func
        _this getVariable "params" params ["_sector"];

        // TODO: TBD: which should probably be refactored to the trigger function to begin with...
        // TODO: TBD: which may fire off global events from there as needed...
        KPLIB_sectors_active = KPLIB_sectors_active - [_sector];
        publicVariable "KPLIB_sectors_active";
        [KPLIB_sector_deactivated, [_sector]] call CBA_fnc_globalEvent;

        [format ["----- Sector %1 (%2) deactivated -----", markerText _sector, _sector], "CORE", true] call KPLIB_fnc_common_log;
    }
    , {
        // Run condition
        true
    }
    , {
        // End condition
        !(_this getVariable ["KPLIB_sectorActive", true])
    } 
] call CBA_fnc_createPerFrameHandlerObject;

true
