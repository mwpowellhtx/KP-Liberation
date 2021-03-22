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
        https://community.bistudio.com/wiki/Arma:_GUI_Configuration#Control_Styles
 */

/*
    --- Small sized classes ---
*/

// Scroll bar
class XGUI_PRE_ScrollBar : KPGUI_PRE_ScrollBar {
};

// Controls table with nominal default settings
class XGUI_PRE_ControlTable {
    idc = KPLIB_IDC_UNDEFINED;
    x = 0;
    y = 0;
    w = 0;
    h = 0;

    type = CT_CONTROLS_TABLE;
    style = SL_TEXTURES;

    lineSpacing = 0;
    // TODO: TBD: may run with nominal defaults...
    // rowHeight = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_H;
    // headerHeight = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_H;

    // firstIDC = KPLIB_IDC_MISSIONSMGR_CT_BRIEFING_IDC_FIRST;
    // lastIDC = KPLIB_IDC_MISSIONSMGR_CT_BRIEFING_IDC_LAST;

    // Colors which are used for animation (i.e. change of colour) of the selected line
    selectedRowColorFrom[]  = {0, 0, 0, 0};
    selectedRowColorTo[]    = {0, 0, 0, 0};
    // Length of the animation cycle in seconds
    selectedRowAnimLength = 1;

    class VScrollBar : XGUI_PRE_ScrollBar {
        // width = 0.021;
        // autoScrollEnabled = 0;
        // autoScrollDelay = 1;
        // autoScrollRewind = 1;
        // autoScrollSpeed = 1;
    };

    class HScrollBar : XGUI_PRE_ScrollBar {
        // height = 0.028;
    };
};

// // TODO: TBD: could not seem to get this to work quite right
// StructuredText
class XGUI_PRE_StructuredText {
    idc = KPLIB_IDC_UNDEFINED;
    x = 0;
    y = 0;
    w = 0;
    h = 0;
    default = 0;
    deletable = 0;
    type = CT_STRUCTURED_TEXT;
    style = ST_LEFT;
    text = "";
};

// Label
class XGUI_PRE_Label : KPGUI_PRE_Label {
    h = KPX_BUTTON_M_H;
    sizeEx = KPX_TEXT_M;
};

// Slider
class XGUI_PRE_Slider : KPGUI_PRE_Slider {
};

// Edit text
class XGUI_PRE_EditText : KPGUI_PRE_EditText {
};

// Active Text
class XGUI_PRE_ActiveText : KPGUI_PRE_ActiveText {
};

// Combo
class XGUI_PRE_Combo : KPGUI_PRE_Combo {
};

// Picture
class XGUI_PRE_Picture : KPGUI_PRE_Picture {
};

// Picture which keeps aspect ratio
class XGUI_PRE_PictureRatio : KPGUI_PRE_PictureRatio {
};

// Button
class XGUI_PRE_Button : KPGUI_PRE_Button {
    h = KPX_BUTTON_M_H;
    sizeEx = KPX_TEXT_M;
    soundEnter[] = { "\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1 };
    soundPush[] = { "\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1 };
    soundClick[] = { "\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1 };
};

// Controls group
class XGUI_PRE_ControlsGroup : KPGUI_PRE_ControlsGroup {
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
