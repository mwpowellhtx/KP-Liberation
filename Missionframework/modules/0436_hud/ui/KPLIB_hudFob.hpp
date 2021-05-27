/*
    File: KPLIB_hudFob.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-25 16:05:14
    Last Update: 2021-05-25 16:05:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Defines the FOB HUD control and it related geometry.

    References:
        https://community.bistudio.com/wiki/cutRsc
        https://community.bistudio.com/wiki/Description.ext
        https://community.bistudio.com/wiki/Arma:_GUI_Configuration
        https://community.bistudio.com/wiki/CT_CONTROLS_GROUP
        https://community.bistudio.com/wiki/CT_CONTROLS_TABLE
        https://community.bistudio.com/wiki/CT_PROGRESS
        https://community.bistudio.com/wiki/Arma:_GUI_Configuration#Common_Properties
 */

/*
    --- FOB LISTNBOX geometry ---

    Yes, that's right, we ended up rolling with a "simple" LISTNBOX for purposes
    of containing the FOB HUD elements. Each REPORT ends up being a single ROW in
    the LISTNBOX. For SHADOW effect, we use the same control meta data, and offset
    by a little bit. We introduce a custom 'shadowColor[]' attribute for purposes
    of overriding the COLOR reported in the DISPATCH, which turns out to be a very
    nice effect indeed.
 */

#define KPLIB_HUD_FOB_LNB_W                 (0.5 * KPX_DEFAULT_SIDEBAR_CTRLAREA_W)
#define KPLIB_HUD_FOB_LNB_X                 (KPX_DEFAULT_SIDEBAR_CTRLAREA_XR + (KPX_DEFAULT_SIDEBAR_CTRLAREA_W - KPLIB_HUD_FOB_LNB_W))
#define KPLIB_HUD_FOB_LNB_Y                 KPX_DEFAULT_SIDEBAR_CTRLAREA_YB
#define KPLIB_HUD_FOB_LNB_H                 (KPX_BUTTON_L_H + (10 * (KPX_SPACING_H + KPX_BUTTON_M_H)))

// Offset by just a little bit, plus using a shadow color, gives the impression of a raised, shadow effect
#define KPLIB_HUD_FOB_LNB_X_SHADOW          (KPLIB_HUD_FOB_LNB_X + KPX_SPACING_W_SHADOW)
#define KPLIB_HUD_FOB_LNB_Y_SHADOW          (KPLIB_HUD_FOB_LNB_Y + KPX_SPACING_H_SHADOW)

// In either HORIZONTAL or VERTICAL directions we assume
#define KPLIB_HUD_FOB_LNB_PADDING           KPX_SPACING_H

// // TODO: TBD: for when we tried a CONTROL TABLE...
// #define KPLIB_HUD_CT_FOB_W                  KPX_DEFAULT_SIDEBAR_CTRLAREA_W
// #define KPLIB_HUD_CT_FOB_X                  KPX_DEFAULT_SIDEBAR_CTRLAREA_XR
// #define KPLIB_HUD_CT_FOB_Y                  KPX_DEFAULT_SIDEBAR_CTRLAREA_YB
//                                             // Using forward knowledge of the known FOB REPORT items
// #define KPLIB_HUD_CT_FOB_H                  (KPX_BUTTON_L_H + (10 * (KPX_SPACING_H + KPX_BUTTON_M_H)))

// #define KPLIB_HUD_CT_FOB_LINE_SPACING       KPX_SPACING_H

// #define KPLIB_HUD_CT_FOB_ROWBG_W            KPLIB_HUD_CT_FOB_W
// #define KPLIB_HUD_CT_FOB_ROWBG_X            0

// #define KPLIB_HUD_CT_FOB_HEADERBG_W         KPLIB_HUD_CT_FOB_ROWBG_W
// #define KPLIB_HUD_CT_FOB_HEADERBG_X         KPLIB_HUD_CT_FOB_ROWBG_X

// #define KPLIB_HUD_CT_FOB_ROW_REPORT_W       KPX_GETW_VWGS(KPLIB_HUD_CT_FOB_ROWBG_W,9,10,KPX_SPACING_W)
// #define KPLIB_HUD_CT_FOB_ROW_REPORT_X       0
// #define KPLIB_HUD_CT_FOB_ROW_PICTURE_W      (KPLIB_HUD_CT_FOB_ROWBG_W - KPLIB_HUD_CT_FOB_ROW_REPORT_W - KPX_SPACING_W)
// #define KPLIB_HUD_CT_FOB_ROW_PICTURE_X      (KPLIB_HUD_CT_FOB_ROW_REPORT_W + KPX_SPACING_W)
// #define KPLIB_HUD_CT_FOB_ROW_H              KPX_BUTTON_M_H

// #define KPLIB_HUD_CT_FOB_HEADER_REPORT_W    KPLIB_HUD_CT_FOB_ROW_REPORT_W
// #define KPLIB_HUD_CT_FOB_HEADER_REPORT_X    KPLIB_HUD_CT_FOB_ROW_REPORT_X
// #define KPLIB_HUD_CT_FOB_HEADER_PICTURE_W   KPLIB_HUD_CT_FOB_ROW_PICTURE_W
// #define KPLIB_HUD_CT_FOB_HEADER_PICTURE_X   KPLIB_HUD_CT_FOB_ROW_PICTURE_X
// #define KPLIB_HUD_CT_FOB_HEADER_H           KPX_BUTTON_L_H

class KPLIB_hudFob_blank : KPLIB_hud {
    name = "KPLIB_hudFob_blank";
    idd = KPLIB_IDD_HUD_FOB;

    // Unfortunately cannot drop this on the base class and pickup a derived attribute
    onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hudFob_blank')]) spawn KPLIB_fnc_hudFobUI_onLoad";
};

// Separate key sitrep bits for use via a layered cutRsc approach
class KPLIB_hudFob_overlay : KPLIB_hud {
    name = "KPLIB_hudFob_overlay";
    idd = KPLIB_IDD_HUD_FOB;

    // Unfortunately cannot drop this on the base class and pickup a derived attribute
    onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hudFob_overlay')]) spawn KPLIB_fnc_hudFobUI_onLoad";

    controls[] = {
        KPLIB_hudFob_lnbFob
    };

    // We send the shadow LISTNBOX to background
    controlsBackground[] = {
        KPLIB_hudFob_lnbFobShadow
    };

    class KPLIB_hudFob_lnbFob : XGUI_PRE_ListNBox {
        idc = KPLIB_IDC_HUD_FOB_LNB_FOB;

        x = KPLIB_HUD_FOB_LNB_X;
        y = KPLIB_HUD_FOB_LNB_Y;
        w = KPLIB_HUD_FOB_LNB_W;
        h = KPLIB_HUD_FOB_LNB_H;

        colorBackground[] = {0.2, 0.2, 0.2, 0.5};

        font = KPX_HUD_FONT_M;
        padding = KPLIB_HUD_FOB_LNB_PADDING;
        text = "res\hud-gradient.paa";

        //          {_report, _picture}
        columns[] = {      0,      0.65};

        onLoad = "_this spawn KPLIB_fnc_hudFobUI_lnbFob_onLoad";
    };

    class KPLIB_hudFob_lnbFobShadow : KPLIB_hudFob_lnbFob {
        idc = KPLIB_IDC_HUD_FOB_LNB_FOB_SHADOW;

        x = KPLIB_HUD_FOB_LNB_X_SHADOW;
        y = KPLIB_HUD_FOB_LNB_Y_SHADOW;

        colorShadow[] = KPLIB_HUD_SHADOW_COLOR;

        onLoad = "_this spawn KPLIB_fnc_hudFobUI_lnbFob_onLoad";
    };
};

