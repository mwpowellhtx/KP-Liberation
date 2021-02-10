/*
    Prototype GUI definitions based on the CBA 'defineCommonGrids.hpp'.

    File: XGUI_defines.hpp
    Author: Michael W. Powell [22nd MEU SOD]
    Created: 2021-02-06 21:14:16
    Last Update: 2021-02-09 20:23:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:

        While we grasp what the intention of the 'KPGUI_defines.hpp' was trying to accomplish,
        we think that what it succeeds in doing vis-a-vis 'XY' coordinates, it utterly fails in
        accomplishing concerning 'HW' components of the same geometry.

        Our goal here is simple. To decompose grid layouts in terms of grid, for starters: for
        both 'XY' coordinates as well as 'HW' components. Most definitely we do not want to be
        guessing how many of a component would fit in a given region. That is the last thing we
        want to do.

        After that, we need to be able to envision regions and subregions during component layout.
        This means being able to continually refine the world coordinate system, so to speak, in
        as many layers as it takes for layouts to begin to take shape. Or at the very least,
        provide a vocabulary rich enough for UI authors to be able to do so with relative ease.

    References:
        https://www.w3schools.com/colors/colors_picker.asp
*/

// Prefix for this use case to avoid issues with duplicated definitions
#define XGUI_PRE                        KPLIB

#define KPX_COLOR_LBBACKGROUND          {0, 0, 0, 0.95}
#define KPX_COLOR_LBFOCUSED             {0, 0, 0, 0.9}

/*
    --- CBA assumptions ---

    Code:
        // Total width of the grid
        #define GUI_GRID_WAbs       ((safeZoneW / safeZoneH) min 1.2)

        // Total height of the grid
        #define GUI_GRID_HAbs       (GUI_GRID_WAbs / 1.2)

        // Width of one grid
        #define GUI_GRID_W          (GUI_GRID_WAbs / 40)

        // Height of one grid
        #define GUI_GRID_H          (GUI_GRID_HAbs / 25)

        // Horizontal origin
        #define GUI_GRID_X          (safeZoneX)

        // Vertical origin
        #define GUI_GRID_Y          (safeZoneY + safeZoneH - GUI_GRID_HAbs)

    Description:
        Literally, '40 / 25', or 40:25, which is literally a function of 8:5. We will also
        provide a handful of more detailed grids for use throughout the UI layout assets.

    References:
        https://en.wikipedia.org/wiki/Aspect_ratio
 */
#define GUI_GRID_ASPECT_RATIO       (1.6)

// Width and height components by halves, quarters, eighths
#define GUI_GRID_W2                 (0.5   * GUI_GRID_W)
#define GUI_GRID_W4                 (0.25  * GUI_GRID_W)
#define GUI_GRID_W8                 (0.125 * GUI_GRID_W)

#define GUI_GRID_H2                 (0.5   * GUI_GRID_H)
#define GUI_GRID_H4                 (0.25  * GUI_GRID_H)
#define GUI_GRID_H8                 (0.125 * GUI_GRID_H)

/*
    --- General Defines ---
 */

/* Text sizes - we spent a little time reverse engineering the ratios etc,
 * especially as a function of the "medium" or normative text size. */

// safeZoneH * 0.02
#define KPX_TEXT_M                      (safeZoneH * 0.02)

// (safeZoneH * 0.016)
#define KPX_TEXT_XS                     (KPX_TEXT_M * 0.7)
// (safeZoneH * 0.018)
#define KPX_TEXT_S                      (KPX_TEXT_M * 0.85)

// (safeZoneH * 0.025)
#define KPX_TEXT_L                      (KPX_TEXT_M * 1.075)
// (safeZoneH * 0.03)
#define KPX_TEXT_XL                     (KPX_TEXT_M * 1.115)

// TODO: TBD: we think that perhaps these might flow better being derived from GUI_GRID bits...
// Constant values for calculation

// 0.001875 or factor of 640 (was: 0.002)
#define KPX_SPACING_W                   (0.002)
#define KPX_SPACING_H                   (KPX_SPACING_W * 2)

// Define title as a function of the text sizes
#define KPX_TITLE_XS_H                  (1.2 * KPX_TEXT_XS)
#define KPX_TITLE_S_H                   (1.2 * KPX_TEXT_S)
#define KPX_TITLE_M_H                   (1.2 * KPX_TEXT_M)
#define KPX_TITLE_L_H                   (1.2 * KPX_TEXT_L)
#define KPX_TITLE_XL_H                  (1.2 * KPX_TEXT_XL)

// Define button as a function also of the text sizes
#define KPX_BUTTON_XS_H                 (1.2 * KPX_TEXT_XS)
#define KPX_BUTTON_S_H                  (1.2 * KPX_TEXT_S)
#define KPX_BUTTON_M_H                  (1.2 * KPX_TEXT_M)
#define KPX_BUTTON_L_H                  (1.2 * KPX_TEXT_L)
#define KPX_BUTTON_XL_H                 (1.2 * KPX_TEXT_XL)

// Same as for text, by halves, quarters, eighths
#define KPX_SPACING_W2                  (0.5   * KPX_SPACING_W)
#define KPX_SPACING_W4                  (0.25  * KPX_SPACING_W)
#define KPX_SPACING_W8                  (0.125 * KPX_SPACING_W)

#define KPX_SPACING_H2                  (0.5   * KPX_SPACING_H)
#define KPX_SPACING_H4                  (0.25  * KPX_SPACING_H)
#define KPX_SPACING_H8                  (0.125 * KPX_SPACING_H)

/*
    --- Colors ---
 */

#define KPX_COLOR_PLAYERDEFINE          {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"}
#define KPX_COLOR_BG                    {0, 0, 0, 0.5}

// TODO: TBD: Will be removed/replaced in further development...
// Leftovers from the old framework.
#define XCOLOR_BROWN                    {0.30, 0.25, 0.2, 0.75}
#define XCOLOR_GREEN                    {0.2, 0.23, 0.18, 0.75}
#define XCOLOR_WHITE                    {1, 1, 1, 1}
#define XCOLOR_NOALPHA                  {0, 0, 0, 0}
#define XCOLOR_BLACK                    {0, 0, 0, 1}
#define XCOLOR_OPFOR_NOALPHA            {1, 0, 0, 1}

/*
    === UI layout macros ===

    Description:
        Our goal is for the macros to actually be HELPFUL. That is, for them not to be too awfully
        cumbersome, to wield. Historically, macros used by A3 HPP configuration is not that great
        to work with. It does not expand in quite the same way as a conventional preprocessor
        environment such as C or Cplusplus, for example. So just fair warning where that is
        concerned.

        1. View scaling is fairly straightforward, we think, as a function of both 'GUI_GRID_WAbs'
            or 'GUI_GRID_HAbs' in the horizontal or vertical, respectively. Identifying view
            dimension is simple, i.e. '0.5 * GUI_GRID_WAbs', is exactly one half the useful
            world view area.

        2. Then we must locate the XY cartesian coordinates. We can start with the world view
            coordinates, 'GUI_GRID_X' and 'GUI_GRID_Y', respectively. Every other coordinate
            has its root bits based on those values. In our case, we will support LEFT (L),
            CENTER (C), and RIGHT (R) aligned coordinates, respectively.

        3. Grid comprehension is a helpful concept when envisioning the layout for on screen
            widgets. The default aspect ratio is something like ~'1.6', literally '40 / 25',
            that is:

                GUI_GRID_W = GUI_GRID_WAbs / 40
                GUI_GRID_H = GUI_GRID_HAbs / 25

            This is the default grid comprehension decomposing the available width or height,
            respectively, but the subdivision could be anything. We provide a handful of more
            detailed grid definitions. Note that, these definitions do not incorporate
            comprehension of spacing. Spacing is a separate matter.

        4. Spacing, we think, is important, but to expect it between each and every grid, as
            defined here, is perhaps not a right thing to do, and only serves to further
            complicate things. We think it is more important to identify actual width of
            a core set of anchor widgets, and let the rest of the composition arrange based
            on those bits within a well defined horizontal and vertical view areas.

            Rather, we think it is of more value to allow spacing between known components
            in either the horizontal or vertical, as the case may be.

    References:
        https://en.wikipedia.org/wiki/Cartesian_coordinate_system#Two_dimensions
        https://codepoints.net/U+2261 (≡, identical to, equivalent to, congruent with)

    Definition of terms:
        V - the view under consideration
        X - the X coordinate; 'X' ≡ 'Y' (i.e. congruent, interchangeable)
        W - the W dimension; 'W' ≡ 'H' (i.e. width, height)
        L - the L concern; 'L' ≡ 'T' (i.e. left, top)
        R - the R concern; 'R' ≡ 'B' (i.e. right, bottom)
        C - the C concern (i.e. center)
 */

// TODO: TBD: Some of the center and left aligning bits have been vetted...
// TODO: TBD: Right aligning bits have not been vetted yet
#define KPX_GETXL_VXW(VX,W)         (VX + W)
#define KPX_GETYT_VYH(VY,H)          KPX_GETXL_VXW(VY,H)

#define KPX_GETXR_VXW(VX,VW,W)      (VX + (VW - W))

#define KPX_GETXC_CXW(CX,W)         (CX - (W/2))
#define KPX_GETYC_CYW(CY,H)         KPX_GETXC_CXW(CY,H)

// TODO: TBD: working out the kinks in centered scenarios...
// TODO: TBD: rinse and repeat for left and right aligned...

#define KPX_GETXL_W(W)              KPX_GETXL_VXW(safeZoneX,W)
#define KPX_GETXR_W(W)              KPX_GETXR_VXW(GUI_GRID_X,GUI_GRID_WAbs,W)
#define KPX_GETXC_W(W)              KPX_GETXC_CXW((safeZoneX + (safeZoneW/2)),W)

#define KPX_GETYT_H(H)              KPX_GETYT_VYH(safeZoneY,H)
#define KPX_GETYB(H)                KPX_GETXR_VXW(GUI_GRID_Y,GUI_GRID_HAbs,H)
#define KPX_GETYC_H(H)              KPX_GETYC_CYW((safeZoneY + (safeZoneH/2)),H)

/*
    --- Dialog defaults ---

    Description:
        We orient horizontally and vertically centered dialog, title, and cross bits by default.

        =================================================================================
        === TITLE                                                                 [X] ===
        =================================================================================
        ---------------------------------------------------------------------------------
        ---                                                                           ---
        ---                                 VIEW AREA                                 ---
        ---                                                                           ---
        ---------------------------------------------------------------------------------
 */

// TODO: TBD: should there be WAbs or HAbs aspect ratio comprehension (?)
#define KPX_DEFAULT_DIALOG_WC       (0.5 * safeZoneW)
#define KPX_DEFAULT_DIALOG_HC       (0.5 * safeZoneH)

#define KPX_DEFAULT_DIALOG_XC       KPX_GETXC_W(KPX_DEFAULT_DIALOG_WC)
#define KPX_DEFAULT_DIALOG_YC       KPX_GETYC_H(KPX_DEFAULT_DIALOG_HC)

/*
    We could just use dialog and title XY coordinates, but we define them here. This serves
    a couple of purposes.

        1. We gain consistency throughout when they are used.

        2. If their definition should ever change for any reason, then we do not need to
            chase them throughout the rest of the UI usage.
 */

#define KPX_DEFAULT_TITLE_WC        KPX_DEFAULT_DIALOG_WC
#define KPX_DEFAULT_TITLE_HC        KPX_TITLE_M_H

#define KPX_DEFAULT_TITLE_XC        KPX_DEFAULT_DIALOG_XC
#define KPX_DEFAULT_TITLE_YC        (KPX_DEFAULT_DIALOG_YC - KPX_SPACING_H - KPX_TITLE_M_H)

#define KPX_DEFAULT_CROSS_WC        GUI_GRID_W
#define KPX_DEFAULT_CROSS_HC        KPX_DEFAULT_TITLE_HC

#define KPX_DEFAULT_CROSS_XC        (KPX_DEFAULT_TITLE_XC + KPX_DEFAULT_TITLE_WC - GUI_GRID_W)
#define KPX_DEFAULT_CROSS_YC        KPX_DEFAULT_TITLE_YC

/* Control area XY coordinates defined as the dialog XY plus spacing. Downstream
 * calculations must also consider spacing on the right and/or bottom, respectively. */

#define KPX_DEFAULT_CTRLAREA_WC     (KPX_DEFAULT_DIALOG_WC - (2 * KPX_SPACING_W))
#define KPX_DEFAULT_CTRLAREA_HC     (KPX_DEFAULT_DIALOG_HC - (2 * KPX_SPACING_H))

#define KPX_DEFAULT_CTRLAREA_XC     (KPX_DEFAULT_DIALOG_XC + KPX_SPACING_W)
#define KPX_DEFAULT_CTRLAREA_YC     (KPX_DEFAULT_DIALOG_YC + KPX_SPACING_H)

/*
    --- Control sizing ---

    Definition of terms:
        Continuing the set of enumerated terms (see above):

        G - total number of cells under consideration
        S - spacing used between grid cells
 */

/*
    Assumes that the view being apportioned into a grid, with interlacing spacing. If there
    are N grid cells, then there shall be N-1 interlacing spacing margins. This allows for
    layouts with widget abuttments right up to the edge of a specified view.

    Procedurally, we tack on an additional space in order for the math to work out correctly.
    Remember also to subtract out that space for the final response, because we do not want
    it to be included in the final response.

    Example:
            [           W          ]
            [GS|GS|GS|GS|GS|GS|GS|G]
            [        X        ]
        =>  [GS|GS|GS|GS|GS|G]
 */

#define KPX_GETW_VWGS(VW,W,G,S)     ((W * ((VW + S) / G)) - S)
#define KPX_GETH_VHGS(VH,H,G,S)     KPX_GETW_VWGS(H,Y,G,S)

#define KPX_GETWC_CTRLAREA_XG(X,G)  KPX_GETW_WXGS(KPX_DEFAULT_CTRLAREA_WC,X,G,KPX_SPACING_W)
#define KPX_GETHC_CTRLAREA_YG(Y,G)  KPX_GETH_HYGS(KPX_DEFAULT_CTRLAREA_HC,Y,G,KPX_SPACING_H)

// Get L/T aligned X/Y cartesian coordinates within the W/H grid (G) view
#define KPX_GETXL_VXWGS(VX,W,X,G,S)  (VX + KPX_GETW_WXGS(W,X,G,S))
#define KPX_GETYT_VYHGS(VY,H,Y,G,S)  (VY + KPX_GETW_WXGS(H,Y,G,S))

// TODO: TBD: should also review the dialog component definitions from the refactor KPGUI_defines.hpp file...
// TODO: TBD: for purposes of evaluating whether they fit here...
// TODO: TBD: then eventually perhaps make the transition to use these in the other UI bits...
