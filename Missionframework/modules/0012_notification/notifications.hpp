/*
    File: notifications.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-04 13:10:46
    Last Update: 2021-04-24 10:58:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Starting with a default notification configuration.

    References:
        https://community.bistudio.com/wiki/Arma_3:_Notification
        https://community.bistudio.com/wiki/BIS_fnc_showNotification
        https://community.bistudio.com/wiki/Structured_Text
*/

// Description and such will support structured text elements
class Default {
    title = "%1";
    iconPicture = "%2";
    description = "%3";
    color[] = {1, 1, 1, 1};
    duration = 5;
    priority = 0;
    difficulty[] = {};
};

class KPLIB_notification_default : Default {
    duration = 7;
};

class KPLIB_notification_blufor : KPLIB_notification_default {
    color[] = {0, 0.6, 0.9, 1};
    // color[] = {0, 0.3, 0.6, 1};
};

class KPLIB_notification_opfor : KPLIB_notification_default {
    color[] = {0.8, 0, 0, 1};
    // color[] = {0.5, 0, 0, 1};
};

class KPLIB_notification_civilian : KPLIB_notification_default {
    color[] = {0.7, 0, 0.8, 1};
    // color[] = {0.4, 0, 0.5, 1};
};

class KPLIB_notification_resistance : KPLIB_notification_default {
    color[] = {0, 0.8, 0, 1};
    // color[] = {0, 0.5, 0, 1};
};

// i.e. ["KPLIB_notification_default", ["\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa", "<img color='#ffffff' image='res\StatusWarning_exp_16x_gs.paa'/> This is a test"]] call BIS_fnc_showNotification;
// i.e. ["KPLIB_notification_resistance", ["\a3\ui_f\data\map\markers\nato\n_service.paa", "<t color='#ffffff'><img image='res\StatusWarning_exp_16x_gs.paa'/> This is a test</t>"]] call BIS_fnc_showNotification;
// i.e. ["KPLIB_notification_resistance", [KPLIB_preset_eden_factory, "<t color='#ffffff'><img image='res\StatusWarning_exp_16x_gs.paa'/> This is a test</t>"]] call BIS_fnc_showNotification;
