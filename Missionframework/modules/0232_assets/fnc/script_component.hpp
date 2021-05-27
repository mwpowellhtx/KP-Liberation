/*
    File: script_component.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-25 22:57:14
    Last Update: 2021-05-25 22:57:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Shorthand preprocessor definitions.
 */

#define MODULE assets

#define Q(x) #x

#define MPRESET(var) KPLIB_preset_##MODULE##var
#define QMPRESET(var) Q(MPRESET(var))

#define MPARAM(var) KPLIB_param_##MODULE##var
#define QMPARAM(var) Q(MPARAM(var))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(func) KPLIB_fnc_##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))
