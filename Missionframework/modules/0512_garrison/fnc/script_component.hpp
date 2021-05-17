/*
    File: script_component.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-14 23:53:55
    Last Update: 2021-04-14 23:53:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Shorthand preprocessor definitions.
 */

#define MODULE garrison

#define Q(x) #x

#define MPRESET(x) KPLIB_preset_##MODULE##x
#define QMPRESET(x) Q(MPRESET(x))

#define MPARAM(x) KPLIB_param_##MODULE##x
#define QMPARAM(x) Q(MPARAM(x))

#define MPARAM2(x,y) KPLIB_param_##MODULE##x##y
#define QMPARAM2(x,y) Q(MPARAM2(x,y))

#define MPARAM3(x,y,z) KPLIB_param_##MODULE##x##y##z
#define QMPARAM3(x,y,z) Q(MPARAM3(x,y,z))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(func) KPLIB_fnc_##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))

// RATIO and PERCENTAGE
#define RAT(x,y) (x/y)
#define PCT(x) RAT(x,100)
