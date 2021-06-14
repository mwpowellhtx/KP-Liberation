/*
    File: script_component.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-14 10:40:09
    Last Update: 2021-06-14 17:19:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Shorthand preprocessor definitions.
 */

// To workaround a glitch in the expansion, since 'capture' is a keyword
#define MODULE _captive

#define Q(x) #x

#define MPRESET(var) KPLIB_preset##MODULE##var
#define QMPRESET(var) Q(MPRESET(var))

#define MPARAM(var) KPLIB_param##MODULE##var
#define QMPARAM(var) Q(MPARAM(var))

#define MVAR(var) KPLIB##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(func) KPLIB_fnc##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))
