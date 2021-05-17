/*
    File: script_component.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 16:44:37
    Last Update: 2021-04-05 16:44:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Shorthand preprocessor definitions.
 */

#define MODULE namespace

#define Q(x) #x

#define MPRESET(x) KPLIB_preset_##MODULE##x
#define QMPRESET(x) Q(MPRESET(x))

#define MPARAM(x) KPLIB_param_##MODULE##x
#define QMPARAM(x) Q(MPARAM(x))

#define MSTATUS(x) KPLIB_##MODULE##_status##x
#define QMSTATUS(x) Q(MSTATUS(x))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(var) KPLIB_fnc_##MODULE##var
#define QMFUNC(var) Q(MFUNC(var))
