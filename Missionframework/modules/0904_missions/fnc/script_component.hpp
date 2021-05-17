/*

    File: script_component.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 17:42:23
    Last Update: 2021-03-19 17:42:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for mission module scripts
 */

// TODO: TBD: could potentially hike this up the include chain...
#define LIB KPLIB
#define MODULE1 mission
#define MODULE missions

//// Mission get var
//#define MGVAR(var, defVal)      (KPLIB_mission_data getVariable [var, defVal])
//// Mission set var
//#define MVAR(var, val)         (KPLIB_mission_data setVariable [var, val, true])

#ifndef Q
#define Q(x) #x
#endif // QUOTE

// Align variants for "one" and for the module
#define MPARAM1(x) LIB##_param_##MODULE1##x
#define QMPARAM1(x) Q(MPARAM1(x))

#define MPARAM(x) LIB##_param_##MODULE##x
#define QMPARAM(x) Q(MPARAM(x))

#define MVAR1(var) LIB##_##MODULE1##var
#define QMVAR1(var) Q(MVAR1(var))

#define MVAR(var) LIB##_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC1(func) LIB##_fnc_##MODULE1##func
#define QMFUNC1(func) Q(MFUNC1(func))

#define MFUNC(func) LIB##_fnc_##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))

#define MSTATUS1(stat) LIB##_##MODULE1##_status##stat
