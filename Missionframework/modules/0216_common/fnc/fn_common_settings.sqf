/*
    KPLIB_fnc_common_settings

    File: fn_common_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-02 14:35:07
    Last Update: 2021-06-14 16:38:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Defines the settings for the module.

    Parameters:
        NONE

    Returns:
        The callback has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/Color
        https://www.w3schools.com/colors/colors_picker.asp
*/

KPLIB_param_common_debug                        = false;
KPLIB_param_common_createUnit_debug             = false;
KPLIB_param_common_createGroup_debug            = false;
KPLIB_param_common_createCrew_debug             = false;
KPLIB_param_common_getNearestObjects_debug      = false;
KPLIB_param_common_addAction_debug              = false;
KPLIB_param_common_addPlayerAction_debug        = false;
KPLIB_param_common_onKilled_debug               = false;

KPLIB_param_common_defaultFixedWingVelocity     = 140;
KPLIB_param_common_airSpawnDeck                 = 10;

if (isServer) then {
    // TODO: TBD: may setup proper CBA settings for this...
    KPLIB_param_common_gcTimeoutOnKilled        = 500;
};

true;
