/*
    KPLIB HUD CONFIG

    File: KPLIB_hud.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-25 13:00:39
    Last Update: 2021-03-25 13:00:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        There is not really a manager in this instance, but rather a heads up display. We
        also reserved the name "hud" for use as the core KPLIB HUD API, of sorts, so this
        is what we are running with for purposes of defining and supporting the heads up
        display configuration, event handlers, and so on.

    References:
        https://community.bistudio.com/wiki/cutRsc
        https://community.bistudio.com/wiki/Description.ext
        https://community.bistudio.com/wiki/Arma:_GUI_Configuration
        https://community.bistudio.com/wiki/CT_CONTROLS_GROUP

    References:
        https://community.bistudio.com/wiki/Arma:_GUI_Configuration
 */

// TODO: TBD: these are really off the cuff...
// TODO: TBD: might be better if we took a little time to lay it out in spreadsheet story board
// TODO: TBD: they do not need to be exactly the same width...
// TODO: TBD: in fact, the sector group should perhaps be wider...
#define KPLIB_HUD_GRPFOB_W                  ((0.75 * KPX_DEFAULT_SIDEBAR_W) - (2 * KPX_SPACING_W))
#define KPLIB_HUD_GRPFOB_X                  (KPX_DEFAULT_SIDEBAR_XR + KPX_SPACING_W + (KPX_DEFAULT_SIDEBAR_W - KPLIB_HUD_GRPFOB_W))
#define KPLIB_HUD_GRPFOB_H                  (KPX_DEFAULT_SIDEBAR_H - (2 * KPX_SPACING_H))
#define KPLIB_HUD_GRPFOB_Y                  KPX_DEFAULT_SIDEBAR_YB0

// TODO: TBD: starting with this for height
#define KPLIB_HUD_GRP_TITLE_H               KPX_BUTTON_L_H

#define KPLIB_HUD_GRPFOB_LBLPICTURE_X       KPX_GETW_VWGS(KPLIB_HUD_GRPFOB_W,12,16,KPX_SPACING_W)
#define KPLIB_HUD_GRPFOB_LBLPICTURE_W       KPX_GETW_VWGS(KPLIB_HUD_GRPFOB_W,4,16,KPX_SPACING_W)

// Leaving enough geometry for the PICTURE
#define KPLIB_HUD_GRPFOB_LBLTEXT_W          KPX_GETW_VWGS(KPLIB_HUD_GRPFOB_W,11,16,KPX_SPACING_W)

// Remember, as long as this is in a "group" then the coords are relative
#define KPLIB_HUD_TEST_W            (0.5 * (KPLIB_HUD_GRPFOB_W - KPX_SPACING_W))
#define KPLIB_HUD_TEST_X0           ((0.5 * KPLIB_HUD_TEST_W) + KPX_SPACING_W)


#define KPLIB_HUD_GRPFOB_LBLMARKERPICTURE_W     KPX_GETW_VWGS(KPLIB_HUD_GRPFOB_W,4,16,KPX_SPACING_W)
#define KPLIB_HUD_GRPFOB_LBLMARKERPICTURE_H     KPX_GETH_VHGS(KPLIB_HUD_GRPFOB_H,4,16,KPX_SPACING_H)
#define KPLIB_HUD_GRPFOB_LBLMARKERPICTURE_X     (KPLIB_HUD_GRPFOB_X + KPLIB_HUD_GRPFOB_W - KPLIB_HUD_GRPFOB_LBLMARKERPICTURE_W)

#define KPLIB_HUD_GRPFOB_LBLMARKERTEXT_H        KPLIB_HUD_GRPFOB_LBLMARKERPICTURE_H
#define KPLIB_HUD_GRPFOB_LBLMARKERTEXT_W        (KPLIB_HUD_GRPFOB_W - KPLIB_HUD_GRPFOB_LBLMARKERPICTURE_W - KPX_SPACING_W)


#define KPLIB_HUD_GRPSECTOR_W               KPX_DEFAULT_SIDEBAR_W
#define KPLIB_HUD_GRPSECTOR_X               KPX_DEFAULT_SIDEBAR_XR
#define KPLIB_HUD_GRPSECTOR_H               KPX_DEFAULT_SIDEBAR_H
#define KPLIB_HUD_GRPSECTOR_Y               KPX_DEFAULT_SIDEBAR_YB1

// // TODO: TBD: using these as a basis, reference
// KPX_DEFAULT_SIDEBAR_YB0
// KPX_DEFAULT_SIDEBAR_YB1
// KPX_DEFAULT_SIDEBAR_W
// KPX_DEFAULT_SIDEBAR_H

// TODO: TBD: should consider refactoring the RscTitles themselves...
// TODO: TBD: along similar lines as with the functions, statemachine, etc...
// TODO: TBD: which would allow for potentially multiple different layers supported by other modules
class RscTitles {

    // // TODO: TBD: "Intro" cameras were an artifact of the legacy mod...
    // // TODO: TBD: we may pick these back up again in the future, but in the meanwhile, commented out...
    // class Intro1 {
    //     name = "Intro1";
    //     duration = 4;
    //     idd = KPLIB_IDD_UNDEFINED;
    //     movingEnable = false;
    //     controls[]=
    //    {
    //         GenericLabelShadow, GenericLabel2
    //     };

    //     class GenericLabel2 {
    //         idc = KPLIB_IDC_UNDEFINED;
    //         type =  CT_STATIC;
    //         style = ST_CENTER;
    //         colorText[] = COLOR_WHITE;
    //         colorBackground[] = COLOR_NOALPHA;
    //         font = KPX_HUD_FONT_M;
    //         sizeEx = 0.035 * safezoneH;
    //         x = 0.3 * safezoneW + safezoneX;
    //         w = 0.4 * safezoneW;
    //         y = 0.65 * safezoneH + safezoneY;
    //         h = 0.1 * safezoneH;
    //         text = KPLIB_UIMANAGER_LBL_TEXT;
    //         shadow = SH_NO_SHADOW;
    //     };

    //     class GenericLabelShadow : GenericLabel2 {
    //         shadow = SH_STROKE;
    //     };
    // };

    // class Intro2 {
    //     name = "Intro2";
    //     duration = 7;
    //     idd = KPLIB_IDD_UNDEFINED;
    //     movingEnable = false;
    //     controls[] =
    //    {
    //         VersionLabelShadow, Splash, VersionLabel
    //     };

    //     class Splash {
    //         idc = KPLIB_IDC_UNDEFINED;
    //         type =  CT_STATIC ;
    //         style = ST_PICTURE;
    //         colorText[] = COLOR_WHITE;
    //         colorBackground[] = COLOR_NOALPHA;
    //         font = KPX_HUD_FONT_M;
    //         sizeEx = 0.1 * safezoneH;
    //         x = 0.325 * safezoneW + safezoneX;
    //         w = 0.35 * safezoneW;
    //         y = 0.2 * safezoneH + safezoneY;
    //         h = 0.6 * safezoneH;
    //         text = "res\splash_libe2.paa";
    //     };

    //     class VersionLabel {
    //         idc = KPLIB_IDC_UNDEFINED;
    //         type =  CT_STATIC;
    //         style = ST_CENTER;
    //         shadow = SH_NO_SHADOW;
    //         colorText[] = COLOR_WHITE;
    //         colorBackground[] = COLOR_NOALPHA;
    //         font = KPX_HUD_FONT_M;
    //         sizeEx = 0.035 * safezoneH;
    //         x = 0.45 * safezoneW + safezoneX;
    //         w = 0.3 * safezoneW;
    //         y = 0.65 * safezoneH + safezoneY;
    //         h = 0.1 * safezoneH;
    //         text = $STR_MISSION_VERSION;
    //     };

    //     class VersionLabelShadow : VersionLabel {
    //         shadow = SH_STROKE;
    //         font = KPX_HUD_FONT_M;
    //     };
    // };

    // // TODO: TBD: the legacy mod also had HALO support which used "FastTravel"...
    // // TODO: TBD: not so this one, at least not for the moment...
    // class FastTravel {
    //     name = "FastTravel";
    //     duration = 4;
    //     idd = -1;
    //     movingEnable = true;
    //     controls[]= {
    //         OuterBackground,GenericLabel111
    //     };

    //     class OuterBackground {
    //         idc = -1;
    //         type =  CT_STATIC ;
    //         style = ST_LEFT;
    //         colorText[] = COLOR_BLACK;
    //         colorBackground[] = COLOR_BLACK;
    //         font = KPX_HUD_FONT_M;
    //         sizeEx = 0.023;
    //         x = -3; y = -3;
    //         w = 9;  h = 9;
    //         text = "";
    //     };

    //     class GenericLabel111 {
    //         idc = -1;
    //         type =  CT_STATIC ;
    //         style = ST_CENTER;
    //         colorText[] = COLOR_WHITE;
    //         colorBackground[] = COLOR_NOALPHA;
    //         font = KPX_HUD_FONT_M;
    //         sizeEx = 0.03;
    //         x = 0; y = 0.75;
    //         w = 1.0;  h = 0.1;
    //         text = $STR_DEPLOY_IN_PROGRESS;
    //     };
    // };

    class KPLIB_hud {
        idd = KPLIB_IDD_UNDEFINED;
        // Duration of fade in/out effects when opening/closing in seconds
        fadeIn = 0;
        fadeOut = 0;
        duration = 1e+011; // Must be a good long number, in seconds to expect it to stuck around
        movingEnable = true;
        controls[] = {};
    };

    class KPLIB_hud_blank : KPLIB_hud {
        name = "KPLIB_hud_blank";
        idd = KPLIB_IDD_HUD_OVERLAY;

        // Unfortunately cannot drop this on the base class and pickup a derived attribute
        onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hud_blank')]) spawn KPLIB_fnc_hud_onLoad";
        // onUnload = "_this spawn KPLIB_fnc_hud_onUnload";
    };

    // Separate key sitrep bits for use via a layered cutRsc approach
    class KPLIB_hud_overlay : KPLIB_hud {
        name = "KPLIB_hud_overlay";
        idd = KPLIB_IDD_HUD_OVERLAY;

        // Unfortunately cannot drop this on the base class and pickup a derived attribute
        onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hud_overlay')]) spawn KPLIB_fnc_hud_onLoad";
        // onUnload = "_this spawn KPLIB_fnc_hud_onUnload";

        controls[] = {
            KPLIB_hud_grpSector
            , KPLIB_hud_grpFob
        };

        class KPLIB_hud_grpCtrlsGroupBase {
            idc = KPLIB_IDC_UNDEFINED;
            type = CT_CONTROLS_GROUP;
            style = ST_MULTI;
            x = 0;
            y = 0;
            w = 0;
            h = 0;
            colorBackground[] = {0, 0, 0, 0.15};
            // TODO: TBD: scroll bars are not really appropriate for this use, but they come with the territory
            // TODO: TBD: can they be disabled at all? or hidden?
            class VScrollbar : XGUI_PRE_ScrollBar {
                // color[] = {1, 1, 1, 1};
                // width = 0.021;
                // autoScrollEnabled = 1;
            };
            class HScrollbar : XGUI_PRE_ScrollBar {
                // color[] = {1, 1, 1, 1};
                // height = 0.028;
            };
            lineHeight = 0;
            controls[] = {};
            // // TODO: TBD: what to do with scrollbars... really want to lay it out in such a way as to disable it
            //class HScrollbar {};
            //class VScrollbar {};
            onLoad = "_this spawn KPLIB_fnc_hud_ctrlBase_onLoad";
        };

        class KPLIB_hud_lblTextBase : XGUI_PRE_Label {
            type = CT_STATIC;
            h = KPLIB_HUD_TEST_H;
            style = ST_RIGHT + ST_SHADOW;
            colorBackground[] = COLOR_NOALPHA;
            font = KPX_HUD_FONT_M;
            sizeEx = KPX_TITLE_L_H;
            shadow = SH_STROKE;
            onLoad = "_this spawn KPLIB_fnc_hud_ctrlBase_onLoad";
            // Report which HASHMAP keys are required for the 'text' and 'colorText' attributes
            hashMapKey = "";
            hashMapColorKey = "";
        };

        class KPLIB_hud_lblPictureBase : XGUI_PRE_PictureRatio {
            h = KPLIB_HUD_TEST_H;
            onLoad = "_this spawn KPLIB_fnc_hud_ctrlBase_onLoad";
            hashMapKey = "";
            hashMapColorKey = "";
        };

        class KPLIB_hud_grpSector : KPLIB_hud_grpCtrlsGroupBase {
            idc = KPLIB_IDC_HUD_GRPSECTOR;
            x = KPLIB_HUD_GRPSECTOR_X;
            y = KPLIB_HUD_GRPSECTOR_Y;
            w = KPLIB_HUD_GRPSECTOR_W;
            h = KPLIB_HUD_GRPSECTOR_H;

            class controls {

                // TODO: TBD: not counting sector image geometries, for the moment...
                class KPLIB_hud_grpSector_lblMarkerText : KPLIB_hud_lblTextBase {
                    idc = KPLIB_IDC_HUD_GRPSECTOR_LBLMARKERTEXT;
                    h = KPLIB_HUD_GRP_TITLE_H;
                    hashMapKey = "KPLIB_hudDispatchSM_sectorReport_markerText";
                    onLoad = "_this spawn KPLIB_fnc_hud_ctrlBase_onLoad";
                };
            };
        };

        class KPLIB_hud_grpFob : KPLIB_hud_grpCtrlsGroupBase {
            idc = KPLIB_IDC_HUD_GRPFOB;
            x = KPLIB_HUD_GRPFOB_X;
            y = KPLIB_HUD_GRPFOB_Y;
            w = KPLIB_HUD_GRPFOB_W;
            h = KPLIB_HUD_GRPFOB_H;

            class controls {

                // TODO: TBD: not counting FOB images, for the moment...
                class KPLIB_hud_grpFob_lblMarkerText : KPLIB_hud_lblTextBase {
                    idc = KPLIB_IDC_HUD_GRPFOB_LBLMARKERTEXT;
                    w = KPLIB_HUD_GRPFOB_LBLTEXT_W;
                    h = KPLIB_HUD_GRP_TITLE_H;
                    hashMapKey = "KPLIB_hudDispatchSM_fobReport_markerText";
                    hashMapColorKey = "KPLIB_hudDispatchSM_fobReport_markerColor";
                    //onLoad = "_this spawn KPLIB_fnc_hud_ctrlBase_onLoad";
                };

                // With alignment on the RHS of the label: i.e. [ ---- MARKER TEXT [IMG] ]
                class KPLIB_hud_grpFob_lblMarkerPicture : KPLIB_hud_lblPictureBase {
                    idc = KPLIB_IDC_HUD_GRPFOB_LBLMARKERPICTURE;
                    x = KPLIB_HUD_GRPFOB_LBLPICTURE_X;
                    w = KPLIB_HUD_GRPFOB_LBLPICTURE_W;
                    h = KPLIB_HUD_GRP_TITLE_H;
                    hashMapKey = "KPLIB_hudDispatchSM_fobReport_markerPath";
                    hashMapColorKey = "KPLIB_hudDispatchSM_fobReport_markerColor";
                    //onLoad = "_this spawn KPLIB_fnc_hud_ctrlBase_onLoad";
                };
            };
        };
    };

    // class KPLIB_hud_overlay_fobSitrep : KPLIB_hud_overlay_sitrep {
    //     name = "KPLIB_hud_overlay_fobSitrep";
    //     idd = KPLIB_IDD_HUD_OVERLAY;
    //     onLoad = "";
    //     controls[] = {
    //         // TODO: TBD: add control classes here...
    //     };
    // };

    // class KPLIB_hud_overlay_sectorSitrep : KPLIB_hud_overlay_sitrep {
    //     name = "KPLIB_hud_overlay_sectorSitrep";
    //     idd = KPLIB_IDD_HUD_OVERLAY_SITREP_SECTOR;
    //     controls[] = {
    //         // TODO: TBD: add control classes here...
    //     };
    // };

    // // TODO: TBD: possibly for future use, but not right this moment...
    // class KPLIB_hud_overlay_haloSitrep : KPLIB_hud_overlay_sitrep {
    // };
};
