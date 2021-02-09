/*
    Killah Potatoes XGUI base classes

    File: XGUI_classes.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-07 17:16:37
    Last Update: 2021-02-07 17:16:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Base UI classes for KPGUI.
*/

/*
    --- Small sized classes ---
*/

// Title bar
class XGUI_PRE_DialogTitleC : KPGUI_PRE_Title {
    x = KPX_DEFAULT_TITLE_XC;
    y = KPX_DEFAULT_TITLE_YC;
    w = KPX_DEFAULT_TITLE_WC;
    h = KPX_DEFAULT_TITLE_HC;
    sizeEx = KPX_TEXT_M;
};

// Cross symbol
class XGUI_PRE_DialogCrossC : KPGUI_PRE_CloseCross {
    x = KPX_DEFAULT_CROSS_XC;
    y = KPX_DEFAULT_CROSS_YC;
    w = KPX_DEFAULT_CROSS_WC;
    h = KPX_DEFAULT_CROSS_HC;
};

// Background
class XGUI_PRE_DialogBackgroundC : KPGUI_PRE_Background {
    x = KPX_DEFAULT_DIALOG_XC;
    y = KPX_DEFAULT_DIALOG_YC;
    w = KPX_DEFAULT_DIALOG_WC;
    h = KPX_DEFAULT_DIALOG_HC;
};
