/*
    File: script_component.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 15:43:27
    Last Update: 2021-04-13 22:39:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Shorthand preprocessor definitions.
 */

#define MODULE sectors
#define MODULESM sectorsSM

#define Q(x) #x

#define MPRESET(x) KPLIB_preset##MODULE##x
#define QMPRESET(x) Q(MPRESET(x))

#define MPARAM(x) KPLIB_preset##MODULE##x
#define QMPARAM(x) Q(MPARAM(x))

#define MSTATUS(x) KPLIB_##MODULE##_status##x
#define QMSTATUS(x) Q(MSTATUS(x))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(func) KPLIB_fnc_##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))

// Rinse and repeat for the SM variants
#define MPRESETSM(var) KPLIB_preset_##MODULESM##var
#define QMPRESETSM(var) Q(MPRESETSM(var))

#define MPARAMSM(var) KPLIB_param_##MODULESM##var
#define QMPARAMSM(var) Q(MPARAMSM(var))

#define MVARSM(var) KPLIB_##MODULESM##var
#define QMVARSM(var) Q(MVARSM(var))

#define MFUNCSM(func) KPLIB_fnc_##MODULESM##func
#define QMFUNCSM(func) Q(MFUNCSM(func))
