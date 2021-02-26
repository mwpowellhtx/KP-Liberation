/*
    KPLIB_fnc_uom_onPreInit

    File: fn_uom_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 08:18:23
    Last Update: 2021-02-25 08:18:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:

    Parameter(s):

    Returns:

    References:
        https://en.wikipedia.org/wiki/Unit_of_time
        https://en.wikipedia.org/wiki/Metric_prefix
        https://community.bistudio.com/wiki/a_%5E_b (a raised to the power of b)
        https://community.bistudio.com/wiki/PreProcessor_Commands
        https://community.bistudio.com/wiki/PreProcessor_Commands#.23.23 (literally, '##', double hash, PP concatenation)
        https://community.bistudio.com/wiki/Category:Command_Group:_Math
 */

if (isServer) then {
    ["[fn_uom_onPreInit] Initializing...", "PRE] [UNITSOFMEASURE", true] call KPLIB_fnc_common_log;
};

/*
    ===== Module Globals =====
 */

/*
    ----- SI PREFIX DEFINITIONS -----
 */

/* The BIPM specifies twenty prefixes for the International System of Units (SI).
 * However, we really only maybe use a few of those throughout the code base. */

#define KPLIB_UOM_SI_PREFIX(PREFIX,X) KPLIB_uom_siPrefix_##PREFIX = (10 ^ X)

KPLIB_UOM_SI_PREFIX(deca,1);
KPLIB_UOM_SI_PREFIX(hecto,2);
KPLIB_UOM_SI_PREFIX(kilo,3);

KPLIB_UOM_SI_PREFIX(mega,6);
KPLIB_UOM_SI_PREFIX(giga,9);
KPLIB_UOM_SI_PREFIX(tera,12);

KPLIB_UOM_SI_PREFIX(deci,-1);
KPLIB_UOM_SI_PREFIX(centi,-2);
KPLIB_UOM_SI_PREFIX(milli,-3);

KPLIB_UOM_SI_PREFIX(micro,-6);
KPLIB_UOM_SI_PREFIX(nano,-9);
KPLIB_UOM_SI_PREFIX(pico,-12);

//private _onRaiseTen = { (10 ^ _x); };

//KPLIB_uom_siPrefix_deca     = [1] call _onRaiseTen;
//KPLIB_uom_siPrefix_hecto    = [2] call _onRaiseTen;
//KPLIB_uom_siPrefix_kilo     = [3] call _onRaiseTen;

//KPLIB_uom_siPrefix_mega     = [6] call _onRaiseTen;
//KPLIB_uom_siPrefix_giga     = [9] call _onRaiseTen;
//KPLIB_uom_siPrefix_tera     = [12] call _onRaiseTen;

//KPLIB_uom_siPrefix_deci     = [-1] call _onRaiseTen;
//KPLIB_uom_siPrefix_centi    = [-2] call _onRaiseTen;
//KPLIB_uom_siPrefix_milli    = [-3] call _onRaiseTen;

//KPLIB_uom_siPrefix_micro    = [-6] call _onRaiseTen;
//KPLIB_uom_siPrefix_nano     = [-9] call _onRaiseTen;
//KPLIB_uom_siPrefix_pico     = [-12] call _onRaiseTen;


/*
    ----- TIME DEFINITIONS -----
 */

KPLIB_uom_time_seconds          =  1;
KPLIB_uom_time_secondsPerMinute = 60;
KPLIB_uom_time_minutesPerHour   = 60;
KPLIB_uom_time_hoursPerDay      = 24;

/* Multiply to convert 'kilometers per hour' to 'meters per second'.
 * Divide to convert in the other direction. */

KPLIB_uom_kph_to_mps            = KPLIB_uom_siPrefix_kilo / (KPLIB_uom_time_secondsPerMinute * KPLIB_uom_time_minutesPerHour);


/*
    ===== Module Initialization =====
 */

if (isServer) then {
    // Server section (dedicated and player hosted)
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_uom_onPreInit] Initialized", "PRE] [UNITSOFMEASURE", true] call KPLIB_fnc_common_log;
};

true;
