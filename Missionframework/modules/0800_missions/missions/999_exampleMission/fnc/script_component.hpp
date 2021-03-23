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
#define MODULEP1 mission
#define MODULEP missions
#define MODULE exampleMission

//// Mission get var
//#define MGVAR(var, defVal)      (KPLIB_mission_data getVariable [var, defVal])
//// Mission set var
//#define MSVAR(var, val)         (KPLIB_mission_data setVariable [var, val, true])

#ifndef Q
#define Q(x) #x
#endif // QUOTE

#define MSTATUS1(x) LIB##_##MODULEP1##_status_##x

#define PVAR1(var) LIB##_##MODULEP1##var
#define QPVAR1(var) Q(PVAR1(var))

// TODO: TBD: probably want to be careful of these names...
// Not to be confused with the PERMISSIONS module, for instance
#define PVAR(var) LIB##_##MODULEP##var
#define QPVAR(var) Q(PVAR(var))

#define PFUNC1(func) LIB##_fnc_##MODULEP1##func
#define QPFUNC1(func) Q(PFUNC1(func))

#define PFUNC(func) LIB##_fnc_##MODULEP##func
#define QPFUNC(func) Q(PFUNC(func))

#define MVAR(var) LIB##_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(func) LIB##_fnc_##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))

#define MPARAM(var) LIB##_param_##MODULE##var
#define QMPARAM(var) Q(MPARAM(var))
