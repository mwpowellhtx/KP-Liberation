/*
    File: KPLIB_hud.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-25 13:00:39
    Last Update: 2021-05-17 15:00:40
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
        https://community.bistudio.com/wiki/CT_CONTROLS_TABLE
        https://community.bistudio.com/wiki/CT_PROGRESS
        https://community.bistudio.com/wiki/Arma:_GUI_Configuration#Common_Properties
 */

/*
    --- SECTOR CT_CONTROLS_GROUP geometry ---
 */


// TODO: TBD: kind of experimental at this stage... tinker with the widths etc
#define KPLIB_HUD_GRP_SECTOR_W              (0.75 * KPX_DEFAULT_SIDEBAR_CTRLAREA_W)
#define KPLIB_HUD_GRP_SECTOR_X              (KPX_DEFAULT_SIDEBAR_CTRLAREA_XR + (KPX_DEFAULT_SIDEBAR_CTRLAREA_W - KPLIB_HUD_GRP_SECTOR_W))
#define KPLIB_HUD_GRP_SECTOR_Y              (KPX_DEFAULT_SIDEBAR_CTRLAREA_YB - KPLIB_HUD_SIDEBAR_H_2)

// Y coord is 0 meaning very top-most of the group
#define KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_W  KPX_GETW_VWGS(KPLIB_HUD_GRP_SECTOR_W,7,10,KPX_SPACING_W)
#define KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_H  KPX_BUTTON_M_H
#define KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_X  (KPLIB_HUD_GRP_SECTOR_W - KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_W)

// XY coordinates are both 0, very left-most, top-most of the group
#define KPLIB_HUD_GRP_SECTOR_LBL_TIMER_W    (KPLIB_HUD_GRP_SECTOR_W - (KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_W + KPX_SPACING_W))
#define KPLIB_HUD_GRP_SECTOR_LBL_TIMER_H    KPX_BUTTON_S_H

#define KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_X  KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_X
#define KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_Y  (KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_H + KPX_SPACING_H)
#define KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_W  KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_W
#define KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_H  KPX_BUTTON_S_H

#define KPLIB_HUD_GRP_SECTOR_H              (KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_H + KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_H + KPX_SPACING_H)


// TODO: TBD: refactor the HUD UI oriented functions to the same folders...
// TODO: TBD: we should also separate the RscTitles to a root file...
// TODO: TBD: then also separate each HUD class accordingly...
// TODO: TBD: because we have a couple of them that are more or less 'working' albeit need to be retouched a bit...
// TODO: TBD: but we also have two or three more that we will need to identify...

class KPLIB_hud {
    idd = KPLIB_IDD_UNDEFINED;
    // Duration of fade in/out effects when opening/closing in seconds
    fadeIn = 0;
    fadeOut = 0;
    duration = 1e+011; // Must be a good long number, in seconds to expect it to stuck around
    movingEnable = true;
    controls[] = {};
};

class KPLIB_hudSector_blank : KPLIB_hud {
    name = "KPLIB_hudSector_blank";
    idd = KPLIB_IDD_HUD_SECTOR_OVERLAY;

    onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hudSector_blank')]) spawn KPLIB_fnc_hudSector_onLoad";
};

class KPLIB_hudSector_overlay : KPLIB_hud {
    name = "KPLIB_hudSector_overlay";
    idd = KPLIB_IDD_HUD_SECTOR_OVERLAY;

    controls[] = {
        KPLIB_hudSector_ctrlsGrpSector
    };

    /* Which is not for shadow purposes in this instance, but rather so that the BG
        * half of the poor man's 'progress bar' is always in the background. BG serves
        * as the back drop color behind the pseudo progress bar, and also informs the
        * total available width of the foreground for percentage and X coordinate reasons. */

    controlsBackground[] = {
        KPLIB_hudSector_ctrlsGrpSectorBackground
    };

    onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hudSector_overlay')]) spawn KPLIB_fnc_hudSector_onLoad";

    class KPLIB_hudSector_ctrlsGrpSector_lblProgressBarBase : XGUI_PRE_Label {
        x = KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_X;
        y = KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_Y;
        w = KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_W;
        h = KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_H;
        onLoad = "_this spawn KPLIB_fnc_hudSector_ctrlsGrpSector_lblProgressBar_onLoad";
    };

    class KPLIB_hudSector_ctrlsGrpSectorBase : XGUI_PRE_ControlsGroup {
        x = KPLIB_HUD_GRP_SECTOR_X;
        y = KPLIB_HUD_GRP_SECTOR_Y;
        w = KPLIB_HUD_GRP_SECTOR_W;
        h = KPLIB_HUD_GRP_SECTOR_H;

        // Zero the V+H scrollbars, i.e. no scroll bars
        class VScrollbar: XGUI_PRE_ScrollBar {
            width = 0;
        };

        class HScrollbar: XGUI_PRE_ScrollBar {
            height = 0;
        };
    };

    class KPLIB_hudSector_ctrlsGrpSectorBackground : KPLIB_hudSector_ctrlsGrpSectorBase {
        idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_BG;

        class controls {
            class KPLIB_hudSector_ctrlsGrpSector_lblPbBlufor : KPLIB_hudSector_ctrlsGrpSector_lblProgressBarBase {
                idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_PB_BLUFOR;
                colorBackground[] = {0, 0, 0.85, 1};
                progressBarSide = "blufor";
            };
        };
    };

    class KPLIB_hudSector_ctrlsGrpSector : KPLIB_hudSector_ctrlsGrpSectorBase {
        idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR;

        x = KPLIB_HUD_GRP_SECTOR_X;
        y = KPLIB_HUD_GRP_SECTOR_Y;
        w = KPLIB_HUD_GRP_SECTOR_W;
        h = KPLIB_HUD_GRP_SECTOR_H;

        // Zero the V+H scrollbars, i.e. no scroll bars
        class VScrollbar : XGUI_PRE_ScrollBar {
            width = 0;
        };

        class HScrollbar : XGUI_PRE_ScrollBar {
            height = 0;
        };

        // TODO: TBD: "forward" controls i.e. the PB
        class controls {
            class KPLIB_hudSector_ctrlsGrpSector_lblTimer : XGUI_PRE_Label {
                idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_TIMER;
                w = KPLIB_HUD_GRP_SECTOR_LBL_TIMER_W;
                h = KPLIB_HUD_GRP_SECTOR_LBL_TIMER_H;
                colorText[] = {0.85, 0.85, 0, 1};
                sizeEx = KPX_TITLE_XS_H;
                onLoad = "_this spawn KPLIB_fnc_hudSector_ctrlsGrpSector_lblTimer_onLoad";
            };
            class KPLIB_hudSector_ctrlsGrpSector_lblSectorText : XGUI_PRE_Label {
                idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_SECTOR_TEXT;
                x = KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_X;
                w = KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_W;
                h = KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_H;
                sizeEx = KPX_TITLE_M_H;
                colorText[] = {1, 1, 1, 1};
                onLoad = "_this spawn KPLIB_fnc_hudSector_ctrlsGrpSector_lblSectorText_onLoad";
            };
            // Whereas progress bar always aligns with side OPFOR the sector
            class KPLIB_hudSector_ctrlsGrpSector_lblPbOpfor : KPLIB_hudSector_ctrlsGrpSector_lblProgressBarBase {
                idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_PB_OPFOR;
                colorBackground[] = {0.85, 0, 0, 1};
                progressBarSide = "opfor";
            };
        };
    };
};
