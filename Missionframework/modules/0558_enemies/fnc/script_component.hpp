/*
    File: script_component.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 15:43:27
    Last Update: 2021-05-17 16:14:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Shorthand preprocessor definitions.
 */

// To workaround a glitch in the expansion, since enemy is a keyword
#define MODULE enemies

#define Q(x) #x

#define MPRESET(var) KPLIB_preset_##MODULE##var
#define QMPRESET(var) Q(MPRESET(var))

#define MPARAM(var) KPLIB_param_##MODULE##var
#define QMPARAM(var) Q(MPARAM(var))

#define MSTATUS(val) KPLIB_##MODULE##_status##val
#define QMSTATUS(val) Q(MSTATUS(val))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(func) KPLIB_fnc_##MODULE##func
#define QMFUNC(func) Q(MFUNC(func))

#define PCT(x) (x/100)

#define IGNORE_BUILDINGS(var) MPRESET(var) = []
#define ADD_IGNORED_BUILDING(var,x) MPRESET(var) pushBackUnique #x
