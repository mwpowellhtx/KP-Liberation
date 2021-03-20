/*

    File: script_component.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 16:39:46
    Last Update: 2021-03-20 16:39:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for mission module scripts
 */

// TODO: TBD: could potentially hike this up the include chain...
#define LIB KPLIB
#define PARENT mission
#define PARENTS missions
#define MODULE exampleMission

//// Mission get var
//#define MGVAR(var, defVal)      (KPLIB_mission_data getVariable [var, defVal])
//// Mission set var
//#define MSVAR(var, val)         (KPLIB_mission_data setVariable [var, val, true])

#ifndef Q
#define Q(x) #x
#endif // QUOTE

#define PVAR(var) LIB##_##PARENT##var
#define QPVAR(var) Q(PVAR(var))

#define PSVAR(var) LIB##_##PARENTS##var
#define QPSVAR(var) Q(PSVAR(var))

#define PFUNC(func) LIB##_fnc_##PARENT##func
#define QPFUNC(func) Q(PFUNC(func))

#define PSFUNC(func) LIB##_fnc_##PARENTS##func
#define QPSFUNC(func) Q(PSFUNC(func))

#define MVAR(var) LIB##_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(func) LIB##_fnc_##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))

#define MPARAM(var) LIB##_param_##MODULE##var
#define QMPARAM(var) Q(MPARAM(var))
