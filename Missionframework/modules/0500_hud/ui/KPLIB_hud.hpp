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
 */

// TODO: TBD: should consider refactoring the RscTitles themselves...
// TODO: TBD: along similar lines as with the functions, statemachine, etc...
// TODO: TBD: which would allow for potentially multiple different layers supported by other modules
class RscTitles {

    // // TODO: TBD: "Intro" cameras were an artifact of the legacy mod...
    // // TODO: TBD: we may pick these back up again in the future, but in the meanwhile, commented out...
    // class Intro1 {
    //     name = "Intro1";
    //     duration = 4;
    //     idd = KPLIB_HUD_IDD_UNDEFINED;
    //     movingEnable = false;
    //     controls[]=
    //    {
    //         GenericLabelShadow, GenericLabel2
    //     };

    //     class GenericLabel2 {
    //         idc = KPLIB_HUD_IDC_UNDEFINED;
    //         type =  CT_STATIC;
    //         style = ST_CENTER;
    //         colorText[] = COLOR_WHITE;
    //         colorBackground[] = COLOR_NOALPHA;
    //         font = FontM;
    //         sizeEx = 0.035 * safezoneH;
    //         x = 0.3 * safezoneW + safezoneX;
    //         w = 0.4 * safezoneW;
    //         y = 0.65 * safezoneH + safezoneY;
    //         h = 0.1 * safezoneH;
    //         text = KPLIB_UIMANAGER_LBL_TEXT;
    //         shadow = 1;
    //     };

    //     class GenericLabelShadow : GenericLabel2 {
    //         shadow = 2;
    //     };
    // };

    // class Intro2 {
    //     name = "Intro2";
    //     duration = 7;
    //     idd = KPLIB_HUD_IDD_UNDEFINED;
    //     movingEnable = false;
    //     controls[] =
    //    {
    //         VersionLabelShadow, Splash, VersionLabel
    //     };

    //     class Splash {
    //         idc = KPLIB_HUD_IDC_UNDEFINED;
    //         type =  CT_STATIC ;
    //         style = ST_PICTURE;
    //         colorText[] = COLOR_WHITE;
    //         colorBackground[] = COLOR_NOALPHA;
    //         font = FontM;
    //         sizeEx = 0.1 * safezoneH;
    //         x = 0.325 * safezoneW + safezoneX;
    //         w = 0.35 * safezoneW;
    //         y = 0.2 * safezoneH + safezoneY;
    //         h = 0.6 * safezoneH;
    //         text = "res\splash_libe2.paa";
    //     };

    //     class VersionLabel {
    //         idc = KPLIB_HUD_IDD_UNDEFINED;
    //         type =  CT_STATIC;
    //         style = ST_CENTER;
    //         shadow = 1;
    //         colorText[] = COLOR_WHITE;
    //         colorBackground[] = COLOR_NOALPHA;
    //         font = FontM;
    //         sizeEx = 0.035 * safezoneH;
    //         x = 0.45 * safezoneW + safezoneX;
    //         w = 0.3 * safezoneW;
    //         y = 0.65 * safezoneH + safezoneY;
    //         h = 0.1 * safezoneH;
    //         text = $STR_MISSION_VERSION;
    //     };

    //     class VersionLabelShadow : VersionLabel {
    //         shadow = 2;
    //         font = FontM;
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
    //         font = FontM;
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
    //         font = FontM;
    //         sizeEx = 0.03;
    //         x = 0; y = 0.75;
    //         w = 1.0;  h = 0.1;
    //         text = $STR_DEPLOY_IN_PROGRESS;
    //     };
    // };

    class KPLIB_hud {
        idd = KPLIB_HUD_IDD_UNDEFINED;
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
    };

    // Separate key sitrep bits for use via a layered cutRsc approach
    class KPLIB_hud_overlay : KPLIB_hud {
        name = "KPLIB_hud_overlay"
        // Used to indicate which sitrep is being loaded
        sitrep = "";

        onLoad = "_this call KPLIB_fnc_hud_onLoad";
        onUnload = "_this call KPLIB_fnc_hud_onUnload";
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
