/*
    File: script_component.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-25 17:00:35
    Last Update: 2021-05-26 10:56:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Defines some helpful preprocessor macro tricks to make life a little easier.
 */

#define MODULE hudFob
#define MODULEUI hudFobUI

#define Q(x) #x

/*
    --- HUD FOB ---
 */

#define MPARAM(var) KPLIB_param_##MODULE##var
#define QMPARAM(var) Q(MPARAM(var))

#define MPRESET(var) KPLIB_preset_##MODULE##var
#define QMPRESET(var) Q(MPRESET(var))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(func) KPLIB_fnc_##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))

#define MOVERLAY(cls) KPLIB_##MODULE##cls
#define QMOVERLAY(cls) Q(MOVERLAY(cls))

#define MLAYER(cls) KPLIB_TAG_##MODULE##cls
#define QMLAYER(cls) Q(MLAYER(cls))

#define MVAR_SP(var,val) \
MVAR(var) = val; \
publicVariable QMVAR(var)

#define MPRESET_SP(var,val) \
MPRESET(var) = val; \
publicVariable QMPRESET(var)

/*
    --- HUD FOB UI ---
 */

#define MPARAMUI(var) KPLIB_param_##MODULEUI##var
#define QMPARAMUI(var) Q(MPARAMUI(var))

#define MVARUI(var) KPLIB_##MODULEUI##var
#define QMVARUI(var) Q(MVARUI(var))

#define MFUNCUI(func) KPLIB_fnc_##MODULEUI##func
#define QMFUNCUI(func) Q(MFUNCUI(func))

/*
    --- NUMERICS ---
 */

#define RAT(a,b) (a/b)
#define PCT(a) (a*100)
