/*

    File: script_component.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 12:25:27
    Last Update: 2021-03-20 19:20:04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for mission module scripts
 */

// TODO: TBD: could potentially hike this up the include chain...
#define LIB KPLIB
#define MODULE missionsMgr

#ifndef Q
#define Q(x) #x
#endif // QUOTE

#define MPARAM(x) LIB##_param_##MODULE##x
#define QMPARAM(x) Q(MPARAM(x))

#define MVAR(var) LIB##_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(func) LIB##_fnc_##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))
