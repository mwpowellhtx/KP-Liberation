/*
    File: script_component.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-28 10:31:06
    Last Update: 2021-06-14 17:04:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Defines some helpful preprocessor macro tricks to make life a little easier.
 */

#define MODULE hudSector
#define MODULEUI hudSectorUI

#define Q(x) #x

// Setup some basic macros here
#define MPRESET(var) KPLIB_preset_##MODULE##var
#define QMPRESET(var) Q(MPRESET(var))

#define MPARAM(var) KPLIB_param_##MODULE##var
#define QMPARAM(var) Q(MPARAM(var))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(func) KPLIB_fnc_##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))

// Setup the UI oriented macros here
#define MPRESETUI(var) KPLIB_preset_##MODULEUI##var
#define QMPRESETUI(var) Q(MPRESETUI(var))

#define MPARAMUI(var) KPLIB_param_##MODULEUI##var
#define QMPARAMUI(var) Q(MPARAMUI(var))

#define MVARUI(var) KPLIB_##MODULEUI##var
#define QMVARUI(var) Q(MVARUI(var))

#define MFUNCUI(func) KPLIB_fnc_##MODULEUI##func
#define QMFUNCUI(func) Q(MFUNCUI(func))

#define MLAYERUI(layer) KPLIB_TAG_##MODULEUI##layer
#define QMLAYERUI(layer) Q(MLAYERUI(layer))
