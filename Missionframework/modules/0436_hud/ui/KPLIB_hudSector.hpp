/*
    File: KPLIB_hudSector.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-25 13:00:39
    Last Update: 2021-06-14 17:06:07
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

#define KPLIB_HUDSECTORUI_X                             KPX_DEFAULT_SIDEBAR_CTRLAREA_XR
#define KPLIB_HUDSECTORUI_Y                             (KPX_DEFAULT_SIDEBAR_YB - KPX_SPACING_H - KPX_DEFAULT_SIDEBAR_H2)
#define KPLIB_HUDSECTORUI_W                             KPX_DEFAULT_SIDEBAR_CTRLAREA_W
#define KPLIB_HUDSECTURUI_H                             KPX_DEFAULT_SIDEBAR_H2

// TODO: TBD: instead of orienting the HUD controls individually, may want to arrange them in a control group (?)
// TODO: TBD: in which the ctrls are relative to the parent group, then we can move the grp itself around...
#define KPLIB_HUDSECTORUI_MARKERTEXT_X                  KPLIB_HUDSECTORUI_X
#define KPLIB_HUDSECTORUI_MARKERTEXT_Y                  KPLIB_HUDSECTORUI_Y
#define KPLIB_HUDSECTORUI_MARKERTEXT_W                  KPLIB_HUDSECTORUI_W
#define KPLIB_HUDSECTORUI_MARKERTEXT_H                  KPX_BUTTON_S_H

#define KPLIB_HUDSECTORUI_METERCTRLGRP_X                KPLIB_HUDSECTORUI_MARKERTEXT_X
#define KPLIB_HUDSECTORUI_METERCTRLGRP_Y                (KPLIB_HUDSECTORUI_MARKERTEXT_Y + KPLIB_HUDSECTORUI_MARKERTEXT_H + KPX_SPACING_H)
#define KPLIB_HUDSECTORUI_METERCTRLGRP_W                KPLIB_HUDSECTORUI_MARKERTEXT_W

#define KPLIB_HUDSECTORUI_METERELEMENT_Y                0
#define KPLIB_HUDSECTORUI_METERELEMENT_W                KPLIB_HUDSECTORUI_METERCTRLGRP_W
#define KPLIB_HUDSECTORUI_METERELEMENT_H                KPX_BUTTON_XS_H

// TODO: TBD: we'll start with this, but we might want to introduce spacing between them...
#define KPLIB_HUDSECTORUI_METERELEMENT_Y2               (KPLIB_HUDSECTORUI_METERELEMENT_Y + KPLIB_HUDSECTORUI_METERELEMENT_H)
#define KPLIB_HUDSECTORUI_METERELEMENT_W2               (0.5 * KPLIB_HUDSECTORUI_METERELEMENT_W)
#define KPLIB_HUDSECTORUI_METERELEMENT_H2               (0.5 * KPLIB_HUDSECTORUI_METERELEMENT_H)

#define KPLIB_HUDSECTORUI_METERCTRLGRP_H                (KPLIB_HUDSECTORUI_MARKERTEXT_H + KPX_SPACING_H + KPLIB_HUDSECTORUI_METERELEMENT_H + KPLIB_HUDSECTORUI_METERELEMENT_H2)

// TODO: TBD: kind of experimental at this stage... tinker with the widths etc
#define KPLIB_HUDSECTOR_GRP_SECTOR_W                    (0.75 * KPX_DEFAULT_SIDEBAR_CTRLAREA_W)
#define KPLIB_HUDSECTOR_GRP_SECTOR_X                    (KPX_DEFAULT_SIDEBAR_CTRLAREA_XR + (KPX_DEFAULT_SIDEBAR_CTRLAREA_W - KPLIB_HUDSECTOR_GRP_SECTOR_W))
#define KPLIB_HUDSECTOR_GRP_SECTOR_Y                    (KPX_DEFAULT_SIDEBAR_CTRLAREA_YB - KPX_DEFAULT_SIDEBAR_H2)

// Y coord is 0 meaning very top-most of the group
#define KPLIB_HUDSECTOR_GRP_SECTOR_LBL_SECTOR_TEXT_W    KPX_GETW_VWGS(KPLIB_HUDSECTOR_GRP_SECTOR_W,7,10,KPX_SPACING_W)
#define KPLIB_HUDSECTOR_GRP_SECTOR_LBL_SECTOR_TEXT_H    KPX_BUTTON_M_H
#define KPLIB_HUDSECTOR_GRP_SECTOR_LBL_SECTOR_TEXT_X    (KPLIB_HUDSECTOR_GRP_SECTOR_W - KPLIB_HUDSECTOR_GRP_SECTOR_LBL_SECTOR_TEXT_W)

// XY coordinates are both 0, very left-most, top-most of the group
#define KPLIB_HUDSECTOR_GRP_SECTOR_LBL_TIMER_W          (KPLIB_HUDSECTOR_GRP_SECTOR_W - (KPLIB_HUDSECTOR_GRP_SECTOR_LBL_SECTOR_TEXT_W + KPX_SPACING_W))
#define KPLIB_HUDSECTOR_GRP_SECTOR_LBL_TIMER_H          KPX_BUTTON_S_H

#define KPLIB_HUDSECTOR_GRP_SECTOR_PROGRESSBAR_X        KPLIB_HUDSECTOR_GRP_SECTOR_LBL_SECTOR_TEXT_X
#define KPLIB_HUDSECTOR_GRP_SECTOR_PROGRESSBAR_Y        (KPLIB_HUDSECTOR_GRP_SECTOR_LBL_SECTOR_TEXT_H + KPX_SPACING_H)
#define KPLIB_HUDSECTOR_GRP_SECTOR_PROGRESSBAR_W        KPLIB_HUDSECTOR_GRP_SECTOR_LBL_SECTOR_TEXT_W
#define KPLIB_HUDSECTOR_GRP_SECTOR_PROGRESSBAR_H        KPX_BUTTON_S_H

#define KPLIB_HUDSECTOR_GRP_SECTOR_H                    (KPLIB_HUDSECTOR_GRP_SECTOR_LBL_SECTOR_TEXT_H + KPLIB_HUDSECTOR_GRP_SECTOR_PROGRESSBAR_H + KPX_SPACING_H)

class KPLIB_hudSectorUI_MeterElement : XGUI_PRE_MeterElement {
    y = KPLIB_HUDSECTORUI_METERELEMENT_Y;
    w = KPLIB_HUDSECTORUI_METERELEMENT_W;
    h = KPLIB_HUDSECTORUI_METERELEMENT_H;
    meter = "";
    background = 0;
    maxWidth = KPLIB_HUDSECTORUI_METERELEMENT_W;
    onLoad = "_this spawn KPLIB_fnc_hudSectorUI_MeterElement_onLoad";
    colorBackground[] = {0, 0, 0.9, 1}; // {0, 0.3, 0.6, 1}
    colorDisabled[] = {0.65, 0.65, 0.65, 1};
};

class KPLIB_hudSectorUI_UnitsMeterElement : KPLIB_hudSectorUI_MeterElement {
    meter = "units";
};

class KPLIB_hudSectorUI_TanksMeterElement : KPLIB_hudSectorUI_MeterElement {
    y = KPLIB_HUDSECTORUI_METERELEMENT_Y2;
    w = KPLIB_HUDSECTORUI_METERELEMENT_W2;
    h = KPLIB_HUDSECTORUI_METERELEMENT_H2;
    maxWidth = KPLIB_HUDSECTORUI_METERELEMENT_W2;
    meter = "tanks";
};

class KPLIB_hudSectorUI_CivResMeterElement : KPLIB_hudSectorUI_TanksMeterElement {
    x = KPLIB_HUDSECTORUI_METERELEMENT_W2;
    meter = "civres";
};

// TODO: TBD: refactor the HUD UI oriented functions to the same folders...
// TODO: TBD: we should also separate the RscTitles to a root file...
// TODO: TBD: then also separate each HUD class accordingly...
// TODO: TBD: because we have a couple of them that are more or less 'working' albeit need to be retouched a bit...
// TODO: TBD: but we also have two or three more that we will need to identify...

// XGUI_PRE_ControlsGroupNoScrollbars

class KPLIB_hudSectorUI_blank : KPLIB_hud {
    name = "KPLIB_hudSectorUI_blank";
    idd = KPLIB_IDD_HUDSECTORUI_OVERLAY;

    onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hudSectorUI_blank')]) spawn KPLIB_fnc_hudSectorUI_onLoad";
};

// TODO: TBD: the first thing we want to do is to make sure we can 'see' the controls...
// TODO: TBD: prove this out first before we spend any calories on anything further...
// TODO: TBD: worst case we need the several piecemeal meter labels and arrange them separately
class KPLIB_hudSectorUI_overlay : KPLIB_hud {
    idd = KPLIB_IDD_HUDSECTORUI_OVERLAY;

    x = KPLIB_HUDSECTOR_GRP_SECTOR_PROGRESSBAR_X;
    y = KPLIB_HUDSECTOR_GRP_SECTOR_PROGRESSBAR_Y;
    w = KPLIB_HUDSECTOR_GRP_SECTOR_PROGRESSBAR_W;
    h = KPLIB_HUDSECTOR_GRP_SECTOR_PROGRESSBAR_H;

    onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hudSectorUI_overlay')]) spawn KPLIB_fnc_hudSectorUI_onLoad";

    controls[] = {
        KPLIB_hudSectorUI_lblMarkerText
        , KPLIB_hudSectorUI_MeterCtrlGrp
    };

    controlsBackground[] = {
        KPLIB_hudSectorUI_MeterCtrlGrpBg
    };

    class KPLIB_hudSectorUI_lblMarkerText : XGUI_PRE_Label {
        idc = KPLIB_IDC_HUDSECTORUI_LBL_MARKER_TEXT;
        x = KPLIB_HUDSECTORUI_MARKERTEXT_X;
        y = KPLIB_HUDSECTORUI_MARKERTEXT_Y;
        w = KPLIB_HUDSECTORUI_MARKERTEXT_W;
        h = KPLIB_HUDSECTORUI_MARKERTEXT_H;
        onLoad = "_this spawn KPLIB_fnc_hudSectorUI_lblMarkerText_onLoad";
    };

    // TODO: TBD: we'll start here with a CTRL GRP with internal ctrls+ctrlsbg elements...
    // TODO: TBD: however we may need to split this into a 'single' template, and convey that to the ctrls[] and ctrlsbg[] in the overlay itself...
    class KPLIB_hudSectorUI_MeterCtrlGrpTemplate : XGUI_PRE_ControlsGroupNoScrollbars {
        idc = KPLIB_IDC_HUDSECTORUI_CTRL_GRP_METERS;
        x = KPLIB_HUDSECTORUI_METERCTRLGRP_X;
        y = KPLIB_HUDSECTORUI_METERCTRLGRP_Y;
        w = KPLIB_HUDSECTORUI_METERCTRLGRP_W;
        h = KPLIB_HUDSECTORUI_METERCTRLGRP_H;
    };

    class KPLIB_hudSectorUI_MeterCtrlGrp : KPLIB_hudSectorUI_MeterCtrlGrpTemplate {
        class controls {
            class KPLIB_hudSectorUI_UnitsMeter : KPLIB_hudSectorUI_UnitsMeterElement {
                idc = KPLIB_IDC_HUDSECTORUI_METER_ELEMENT_UNITS;
            };
            class KPLIB_hudSectorUI_TanksMeter : KPLIB_hudSectorUI_TanksMeterElement {
                idc = KPLIB_IDC_HUDSECTORUI_METER_ELEMENT_TANKS;
            };
            class KPLIB_hudSectorUI_CivResMeter : KPLIB_hudSectorUI_CivResMeterElement {
                idc = KPLIB_IDC_HUDSECTORUI_METER_ELEMENT_CIVRES;
                colorBackground[] = {0.8, 0, 0.8, 1}; // {0.4, 0, 0.5, 1}
            };
        };
    };

    class KPLIB_hudSectorUI_MeterCtrlGrpBg : KPLIB_hudSectorUI_MeterCtrlGrpTemplate {
        class controls {
            class KPLIB_hudSectorUI_UnitsMeter : KPLIB_hudSectorUI_UnitsMeterElement {
                background = 1;
                colorBackground[] = {0.9, 0, 0, 1}; // {0.5, 0, 0, 1}
            };
            class KPLIB_hudSectorUI_TanksMeter : KPLIB_hudSectorUI_TanksMeterElement {
                background = 1;
                colorBackground[] = {0.9, 0, 0, 1}; // {0.5, 0, 0, 1}
            };
            class KPLIB_hudSectorUI_CivResMeter : KPLIB_hudSectorUI_CivResMeterElement {
                background = 1;
                colorBackground[] = {0, 0.9, 0, 1}; // {0, 0.5, 0, 1}
            };
        };
    };
};

// class KPLIB_hudSector_overlay : KPLIB_hud {
//     name = "KPLIB_hudSector_overlay";
//     idd = KPLIB_IDD_HUD_SECTOR_OVERLAY;

//     controls[] = {
//         KPLIB_hudSector_ctrlsGrpSector
//     };

//     /* Which is not for shadow purposes in this instance, but rather so that the BG
//         * half of the poor man's 'progress bar' is always in the background. BG serves
//         * as the back drop color behind the pseudo progress bar, and also informs the
//         * total available width of the foreground for percentage and X coordinate reasons. */

//     controlsBackground[] = {
//         KPLIB_hudSector_ctrlsGrpSectorBackground
//     };

//     onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hudSector_overlay')]) spawn KPLIB_fnc_hudSector_onLoad";

//     // class KPLIB_hudSector_ctrlsGrpSector_lblProgressBarBase : XGUI_PRE_Label {
//     //     x = KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_X;
//     //     y = KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_Y;
//     //     w = KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_W;
//     //     h = KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_H;
//     //     onLoad = "_this spawn KPLIB_fnc_hudSector_ctrlsGrpSector_lblProgressBar_onLoad";
//     // };

//     class KPLIB_hudSector_ctrlsGrpSectorBase : XGUI_PRE_ControlsGroup {
//         x = KPLIB_HUD_GRP_SECTOR_X;
//         y = KPLIB_HUD_GRP_SECTOR_Y;
//         w = KPLIB_HUD_GRP_SECTOR_W;
//         h = KPLIB_HUD_GRP_SECTOR_H;

//         // Zero the V+H scrollbars, i.e. no scroll bars
//         class VScrollbar: XGUI_PRE_ScrollBar {
//             width = 0;
//         };

//         class HScrollbar: XGUI_PRE_ScrollBar {
//             height = 0;
//         };
//     };

//     class KPLIB_hudSector_ctrlsGrpSectorBackground : KPLIB_hudSector_ctrlsGrpSectorBase {
//         idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_BG;

//         class controls {
//             class KPLIB_hudSector_ctrlsGrpSector_lblPbBlufor : KPLIB_lblProgressMeter {
//                 idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_PB_BLUFOR;
//                 colorBackground[] = {0, 0, 0.85, 1};
//                 progressBarSide = "blufor";
//             };
//         };
//     };

//     class KPLIB_hudSector_ctrlsGrpSector : KPLIB_hudSector_ctrlsGrpSectorBase {
//         idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR;

//         x = KPLIB_HUD_GRP_SECTOR_X;
//         y = KPLIB_HUD_GRP_SECTOR_Y;
//         w = KPLIB_HUD_GRP_SECTOR_W;
//         h = KPLIB_HUD_GRP_SECTOR_H;

//         // Zero the V+H scrollbars, i.e. no scroll bars
//         class VScrollbar : XGUI_PRE_ScrollBar {
//             width = 0;
//         };

//         class HScrollbar : XGUI_PRE_ScrollBar {
//             height = 0;
//         };

//         // TODO: TBD: "forward" controls i.e. the PB
//         class controls {
//             class KPLIB_hudSector_ctrlsGrpSector_lblTimer : XGUI_PRE_Label {
//                 idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_TIMER;
//                 w = KPLIB_HUD_GRP_SECTOR_LBL_TIMER_W;
//                 h = KPLIB_HUD_GRP_SECTOR_LBL_TIMER_H;
//                 colorText[] = {0.85, 0.85, 0, 1};
//                 sizeEx = KPX_TITLE_XS_H;
//                 onLoad = "_this spawn KPLIB_fnc_hudSector_ctrlsGrpSector_lblTimer_onLoad";
//             };
//             class KPLIB_hudSector_ctrlsGrpSector_lblSectorText : XGUI_PRE_Label {
//                 idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_SECTOR_TEXT;
//                 x = KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_X;
//                 w = KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_W;
//                 h = KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_H;
//                 sizeEx = KPX_TITLE_M_H;
//                 colorText[] = {1, 1, 1, 1};
//                 onLoad = "_this spawn KPLIB_fnc_hudSector_ctrlsGrpSector_lblSectorText_onLoad";
//             };
//             // Whereas progress bar always aligns with side OPFOR the sector
//             class KPLIB_hudSector_ctrlsGrpSector_lblPbOpfor : KPLIB_lblProgressMeter {
//                 idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_PB_OPFOR;
//                 colorBackground[] = {0.85, 0, 0, 1};
//                 progressBarSide = "opfor";
//             };
//         };
//     };
// };
