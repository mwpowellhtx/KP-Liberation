/*
    File: script_component.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-27 10:51:04
    Last Update: 2021-05-27 14:42:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Defines some helpful preprocessor macro tricks to make life a little easier.
 */

#define MODULE hud

#define Q(x) #x

/*
    --- HUD ---
 */

#define MPARAM(var) KPLIB_param_##MODULE##var
#define QMPARAM(var) Q(MPARAM(var))

#define MPRESET(var) KPLIB_preset_##MODULE##var
#define QMPRESET(var) Q(MPRESET(var))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(func) KPLIB_fnc_##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))

#define MVAR_SP(var,val) \
MVAR(var) = val; \
publicVariable QMVAR(var)

#define MPRESET_SP(var,val) \
MPRESET(var) = val; \
publicVariable QMPRESET(var)
