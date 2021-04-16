/*
    File: script_component.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-06 11:38:17
    Last Update: 2021-04-06 11:38:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Shorthand preprocessor definitions.
 */

#define MODULE _units

#define Q(x) #x

#define MPRESET(x) KPLIB_preset##MODULE##x
#define QMPRESET(x) Q(MPRESET(x))

#define MPARAM(x) KPLIB_param##MODULE##x
#define QMPARAM(x) Q(MPARAM(x))

#define MVAR(var) KPLIB##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(var) KPLIB_fnc##MODULE##var
#define QMFUNC(var) Q(MFUNC(var))
