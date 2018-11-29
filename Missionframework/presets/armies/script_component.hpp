/*
    KPLIB Preset Script Component

    File: script_component.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-11-23
    Last Update: 2018-11-25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Contains all preprocessor commands for the preset processing.
*/

// Generates a KPLIB preset variable
#define KPLIB_PRST_VAR(VARIABLE)\
    "KPLIB_preset_" + VARIABLE + (if (_isFriendly) then {"F"} else {"E"})

// Gets the value of a KPLIB preset variable
#define KPLIB_PRST_GETVAR(VARIABLE)\
    missionnamespace getVariable [KPLIB_PRST_VAR(VARIABLE), nil]

// Sets the value of a KPLIB preset variable
#define KPLIB_PRST_SETVAR(VARIABLE,CLASS)\
    missionnamespace setVariable [KPLIB_PRST_VAR(VARIABLE), CLASS]

// Creates a KPLIB preset array
#define KPLIB_PRST_AR_CREATE(ARRAYNAME)\
    missionnamespace setVariable [KPLIB_PRST_VAR(ARRAYNAME), []];

// Adds a classname to a preset array with resource costs
#define KPLIB_PRST_AR_ADD(ARRAYNAME, UNITCLASS, RESSUPPLY, RESAMMO, RESFUEL)\
    (KPLIB_PRST_GETVAR(ARRAYNAME)) pushBack [UNITCLASS, RESSUPPLY, RESAMMO, RESFUEL]

// Creates a plain classname array from a preset array with building costs
#define KPLIB_PRST_AR_PLAIN(ARRAYOLD, ARRAYNEW)\
    KPLIB_PRST_AR_CREATE(ARRAYNEW);\
    {(KPLIB_PRST_GETVAR(ARRAYNEW)) pushBack (_X select 0);} forEach (KPLIB_PRST_GETVAR(ARRAYOLD))