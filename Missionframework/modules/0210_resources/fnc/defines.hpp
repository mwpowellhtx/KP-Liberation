/*
    File: defines.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-05 12:37:04
    Last Update: 2021-05-05 12:37:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Shorthand preprocessor definitions.
 */


#define KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_BIAS "KPLIB_param_resources_%1ResourceDieBias"
#define KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_SIDES "KPLIB_param_resources_%1ResourceDieSides"
#define KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_TIMES "KPLIB_param_resources_%1ResourceDieTimes"
#define KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_OFFSETS "KPLIB_param_resources_%1ResourceDieOffsets"

#ifndef QSECTORTYPE_PARAM
#define QSECTORTYPE_PARAM(f,x) format [f, toLower x]
#endif // QSECTORTYPE_PARAM

#ifndef SECTORTYPE_PARAM_DEF
#define SECTORTYPE_PARAM_DEF(f,x,y) missionNamespace getVariable [QSECTORTYPE_PARAM(f,x), y]
#endif // SECTORTYPE_PARAM_DEF

#ifndef SECTORTYPE_PARAM
#define SECTORTYPE_PARAM(f,x) SECTORTYPE_PARAM_DEF(f,x,"")
#endif // SECTORTYPE_PARAM
