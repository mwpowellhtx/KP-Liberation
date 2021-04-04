/*
    File: notifications.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-04 13:10:46
    Last Update: 2021-04-04 13:10:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Starting with a default notification configuration.

    References:
        https://community.bistudio.com/wiki/Arma_3:_Notification
        https://community.bistudio.com/wiki/BIS_fnc_showNotification
*/

class Default {
    title = "KP LIBERATION";
    iconPicture = "";
    description = "%1";
    color[] = {1, 1, 1, 1};
    duration = 5;
    priority = 0;
    difficulty[] = {};
};

class KPLIB_defaultNotification : Default {
};

// Verified yes, can replace based on the arguments given
class KPLIB_notification_TestParams : KPLIB_defaultNotification {
    description = "%1 - %2 (%3)";
    duration = 10;
};

// i.e. ["KPLIB_notification_TestParams", [mapGridPosition getPos player, "This is a test", 10]] call BIS_fnc_showNotification;
