/*
    File: script_component.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 14:16:45
    Last Update: 2021-04-16 14:16:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Shorthand preprocessor definitions.
 */

#define MODULE garrison
#define MODULEUI garrisonUI

#define Q(x) #x

// Root API definitions
#define MPRESET(x) KPLIB_preset##MODULE##x
#define QMPRESET(x) Q(MPRESET(x))

#define MPARAM(x) KPLIB_preset##MODULE##x
#define QMPARAM(x) Q(MPARAM(x))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(func) KPLIB_fnc_##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))

// UI definitions
#define MPRESETUI(x) KPLIB_preset##MODULEUI##x
#define QMPRESETUI(x) Q(MPRESETUI(x))

#define MPARAMUI(x) KPLIB_preset##MODULEUI##x
#define QMPARAMUI(x) Q(MPARAMUI(x))

#define MVARUI(var) KPLIB_##MODULEUI##var
#define QMVARUI(var) Q(MVARUI(var))

#define MFUNCUI(func) KPLIB_fnc_##MODULEUI##func
#define QMFUNCUI(func) Q(MFUNCUI(func))
