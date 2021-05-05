/*
    File: defines.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-29 11:10:38
    Last Update: 2021-05-04 17:14:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Shorthand preprocessor definitions.
 */

#define KPLIB_GARRISON_SETTINGS_GARRISON_ENEMY_FORMAT "STR_KPLIB_SETTINGS_GARRISON_ENEMY_%1"

#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_UNIT_DIE_SIDES "KPLIB_param_garrison_%1UnitDieSides"
#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_UNIT_DIE_TIMES "KPLIB_param_garrison_%1UnitDieTimes"
#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_UNIT_DIE_OFFSETS "KPLIB_param_garrison_%1UnitDieOffsets"

#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_GRP_DIE_SIDES "KPLIB_param_garrison_%1GrpDieSides"
#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_GRP_DIE_TIMES "KPLIB_param_garrison_%1GrpDieTimes"
#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_GRP_DIE_OFFSETS "KPLIB_param_garrison_%1GrpDieOffsets"

#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_LIGHT_VEHICLE_DIE_SIDES "KPLIB_param_garrison_%1LightVehicleDieSides"
#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_LIGHT_VEHICLE_DIE_TIMES "KPLIB_param_garrison_%1LightVehicleDieTimes"
#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_LIGHT_VEHICLE_DIE_OFFSETS "KPLIB_param_garrison_%1LightVehicleDieOffsets"

#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_HEAVY_VEHICLE_DIE_SIDES "KPLIB_param_garrison_%1HeavyVehicleDieSides"
#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_HEAVY_VEHICLE_DIE_TIMES "KPLIB_param_garrison_%1HeavyVehicleDieTimes"
#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_HEAVY_VEHICLE_DIE_OFFSETS "KPLIB_param_garrison_%1HeavyVehicleDieOffsets"

#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_INTEL_DIE_SIDES "KPLIB_param_garrison_%1IntelDieSides"
#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_INTEL_DIE_TIMES "KPLIB_param_garrison_%1IntelDieTimes"
#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_INTEL_DIE_OFFSETS "KPLIB_param_garrison_%1IntelDieOffsets"

#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_IED_DIE_SIDES "KPLIB_param_garrison_%1IedDieSides"
#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_IED_DIE_TIMES "KPLIB_param_garrison_%1IedDieTimes"
#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_IED_DIE_OFFSETS "KPLIB_param_garrison_%1IedDieOffsets"

#define KPLIB_GARRISON_SECTORTYPE_PARAM_FORMAT_GARRISON_APCS "KPLIB_param_garrison_%1GarrisonApcs"

#define QSECTORTYPE_PARAM(f,x) format [f, toLower x]
#define SECTORTYPE_PARAM(f,x) missionNamespace getVariable [QSECTORTYPE_PARAM(f,x), ""]
