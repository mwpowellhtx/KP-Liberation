/*
    File: script_components.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-10-07
    Last Update: 2021-01-26 15:23:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for build module scripts
*/

// TODO: TBD: may want to review these, make sure we are handling them consistently, i.e. #var conventions, etc
// TODO: TBD: then also potentially pending "KPLIB_build_" prefixes...
// Logic get var
#define LGVAR(var)              (KPLIB_buildLogic getVariable #var)
// Logic get var with default val
#define LGVAR_D(var, defVal)    (KPLIB_buildLogic getVariable [#var, defVal])
// Logic set var
// TODO: TBD: we think the intent here might be to name the variable being set, like the LGVAR does...
// TODO: TBD: but this is a sweeping change...
#define LSVAR(var, val)         (KPLIB_buildLogic setVariable [var, val])
