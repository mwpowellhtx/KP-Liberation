/*
    File: script_component.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 14:16:45
    Last Update: 2021-05-24 16:57:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Shorthand preprocessor definitions.
 */

#define MODULE garrison
#define MODULEUI garrisonUI

#define Q(x) #x

// Root API definitions
#define MPRESET(var) KPLIB_preset_##MODULE##var
#define QMPRESET(var) Q(MPRESET(var))

#define MPARAM(var) KPLIB_param_##MODULE##var
#define QMPARAM(var) Q(MPARAM(var))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(func) KPLIB_fnc_##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))

// UI definitions
#define MPRESETUI(var) KPLIB_preset_##MODULEUI##var
#define QMPRESETUI(var) Q(MPRESETUI(var))

#define MPARAMUI(var) KPLIB_param_##MODULEUI##var
#define QMPARAMUI(var) Q(MPARAMUI(var))

#define MVARUI(var) KPLIB_##MODULEUI##var
#define QMVARUI(var) Q(MVARUI(var))

#define MFUNCUI(func) KPLIB_fnc_##MODULEUI##func
#define QMFUNCUI(func) Q(MFUNCUI(func))
