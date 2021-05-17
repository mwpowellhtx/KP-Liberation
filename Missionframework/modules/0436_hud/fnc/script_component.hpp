/*
    File: script_component.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Defines some helpful preprocessor macro tricks to make life a little easier.

    Remarks:
        One caveat, there are trade offs in virtually every walk of life, and this is
        no exception. The trade off is that we sacrifice log readability for coding
        convenience. We think the returns are about 25% improved efficiency.
 */

#define MODULE hud

#define Q(x) #x

#define MPARAM(arg) KPLIB_param_##MODULE##arg
#define QMPARAM(arg) Q(MPARAM(arg))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(var) KPLIB_fnc_##MODULE##var
#define QMFUNC(var) Q(MFUNC(var))

#define MSTATUS(var) KPLIB_##MODULE##_status##var
#define QMSTATUS(var) Q(MSTATUS(var))

#define MFOB(rep) KPLIB_##MODULE##_fob##rep
#define QMFOB(rep) Q(MFOB(rep))

#define MSECTOR(rep) KPLIB_##MODULE##_sector##rep
#define QMSECTOR(rep) Q(MSECTOR(rep))

#define MOVERLAY(x) KPLIB_##MODULE##x
#define QMOVERLAY(x) Q(MOVERLAY(x))

#define MLAYER(x) KPLIB_TAG_##MODULE##x
#define QMLAYER(x) Q(MLAYER(x))

// Then define some that allow for different AREA elements, i.e. SECTOR
#define MPARAM2(area,arg) KPLIB_param_##MODULE##area##arg
#define QMPARAM2(area,arg) Q(MPARAM2(area,arg))

#define MVAR2(area,var) KPLIB_##MODULE##area##var
#define QMVAR2(area,var) Q(MVAR2(area,var))

#define MFUNC2(area,var) KPLIB_fnc_##MODULE##area##var
#define QMFUNC2(area,var) Q(MFUNC2(area,var))

#define MLAYER2(area,x) KPLIB_TAG_##MODULE##area##x
#define QMLAYER2(area,x) Q(MLAYER2(area,x))
