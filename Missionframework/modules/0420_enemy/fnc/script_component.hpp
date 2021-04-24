/*
    File: script_component.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 15:43:27
    Last Update: 2021-04-24 11:28:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Shorthand preprocessor definitions.
 */

// To workaround a glitch in the expansion, since enemy is a keyword
#define MODULE _enemy

#define Q(x) #x

#define MPRESET(x) KPLIB_preset##MODULE##x
#define QMPRESET(x) Q(MPRESET(x))

#define MPARAM(x) KPLIB_param##MODULE##x
#define QMPARAM(x) Q(MPARAM(x))

#define MSTATUS(x) KPLIB##MODULE##_status##x
#define QMSTATUS(x) Q(MSTATUS(x))

#define MVAR(var) KPLIB##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(var) KPLIB_fnc##MODULE##var
#define QMFUNC(var) Q(MFUNC(var))

#define IGNORE_BUILDINGS(var) MPRESET(var) = []
#define ADD_IGNORED_BUILDING(var,x) MPRESET(var) pushBackUnique #x
