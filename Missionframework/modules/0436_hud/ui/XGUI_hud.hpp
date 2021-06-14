/*
    File: geometry.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-25 15:58:46
    Last Update: 2021-06-14 17:06:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Defines common geometry definitions used throughout the HUD module.
 */

// TODO: TBD: these bits may just go in the XGUI include itself...
#define KPX_SPACING_W_SHADOW                (0.75 * KPX_SPACING_W)
#define KPX_SPACING_H_SHADOW                (0.75 * KPX_SPACING_H)

#define KPLIB_HUD_SHADOW_COLOR              {0.2, 0.2, 0.2, 0.9}

#define KPLIB_HUD_CTRLAREA_H2               (0.5 * KPX_DEFAULT_SIDEBAR_CTRLAREA_H)

class KPLIB_hud {
    idd = KPLIB_IDD_UNDEFINED;
    // Duration of fade in/out effects when opening/closing in seconds
    fadeIn = 0;
    fadeOut = 0;
    duration = 1e+011; // Must be a good long number, in seconds to expect it to stuck around
    movingEnable = true;
    controls[] = {};
};

/* Base class for all things PROGRESS METER, allows for such things as common attributes
* dealing with custom PB, colors, etc. This is the backbone that allows us to model a
* more or less well behaved PB with custom colors, ratios, etc.
 */
class XGUI_PRE_MeterElement : XGUI_PRE_Label {
};

// /* We want to define a common PROGRESS METER class that may be used in several places
//  * for different sections of the HUD.
//  */
// class XGUI_PRE_ctrlProgressMeter {
//     idc = KPLIB_IDC_UNDEFINED;
//     name = ""; // Fill in the blanks with the PM name
//     w = KPX_DEFAULT_SIDEBAR_W;
//     h = KPX_BUTTON_S_H;
//     controlsBackground[] = {
//         XGUI_PRE_lblProgressMeterBackground
//     };
//     controls[] = {
//         XGUI_PRE_lblProgressMeterControl
//     };
//     class XGUI_PRE_lblProgressMeterBackground : XGUI_PRE_lblProgressMeter {};
//     class XGUI_PRE_lblProgressMeterControl : XGUI_PRE_lblProgressMeter {};
// };
