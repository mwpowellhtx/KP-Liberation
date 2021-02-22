/*
    Killah Potatoes XGUI base classes

    File: XGUI_classes.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-07 17:16:37
    Last Update: 2021-02-21 22:19:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Base UI classes for KPGUI.

    References:
        https://community.bistudio.com/wiki/CT_BUTTON#soundClick
        https://community.bistudio.com/wiki/CT_BUTTON#soundEnter
 */

/*
    --- Small sized classes ---
*/

class XGUI_PRE_Label : KPGUI_PRE_Label {
    h = KPX_BUTTON_M_H;
    sizeEx = KPX_TEXT_M;
};

class XGUI_PRE_Button : KPGUI_PRE_Button {
    h = KPX_BUTTON_M_H;
    sizeEx = KPX_TEXT_M;
    soundEnter[] = { "\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1 };
    soundPush[] = { "\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1 };
    soundClick[] = { "\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1 };
};

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

class XGUI_PRE_ListNBox : KPGUI_PRE_ListNBox {
    // TODO: TBD: we need to know which colors are doing what...
    // TODO: TBD: goal being, we have several such LBs in play...
    // TODO: TBD: and we want for there to be some contrast between the LB and surrounding area...
    //colorBackground[] = KPX_COLOR_LBBACKGROUND;
    //colorFocused[] = KPX_COLOR_BACKGROUND;
    disableOverflow = 1;
};

class XGUI_PRE_MapControl : KPGUI_PRE_MapControl {
};
