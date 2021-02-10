/*
    Prototype GUI definitions based on the CBA 'defineCommonGrids.hpp'.

    File: XGUI_defines.hpp
    Author: Michael W. Powell [22nd MEU SOD]
    Created: 2021-02-06 21:14:16
    Last Update: 2021-02-06 21:14:18
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
#define XGUI_PRE                       KPLIB

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

//// TODO: TBD: we will not waste time redefining these bits, even for internal adaptation
//// TODO: TBD: rather, we will stand on the common grid definitions as conveyed by CBA
//// Based on the CBA commons... which is also based on the core A3 docs.
//#define XKP_GUI_GRID_WAbs               (GUI_GRID_WAbs)
//#define XKP_GUI_GRID_HAbs               (GUI_GRID_HAbs)
//#define XKP_GUI_GRID_W                  (GUI_GRID_W)
//#define XKP_GUI_GRID_H                  (GUI_GRID_H)
//#define XKP_GUI_GRID_X                  (GUI_GRID_X)
//#define XKP_GUI_GRID_Y                  (GUI_GRID_Y)

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
////#define KPX_TITLE_H                     (0.035)
//#define KPX_TITLE_H                     (KPX_SPACING_W * 17.5)
////#define KPX_BUTTON_H                    (0.025)
//#define KPX_BUTTON_H                    (KPX_SPACING_H * 6.25)

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

//#define KP_GETX(XVAL,WVAL,POS,GRID)     safeZoneX + safeZoneW * (XVAL + POS * (WVAL + KP_SPACING_X) / GRID)
//#define KP_GETCX(XVAL,WVAL,POS,GRID)    safeZoneX + safeZoneW * (XVAL + (POS * WVAL + (GRID - POS) * KP_SPACING_X) / GRID)
//#define KP_GETX_CROSS(XVAL)             safeZoneX + safeZoneW * (1 - XVAL - 0.02)







#define KPX_GETXL_VXW(VX,W)         (VX + W)
#define KPX_GETYT_VYH(VY,H)          KPX_GETXL_VXW(VY,H)

#define KPX_GETXR_VXW(VX,VW,W)      (VX + (VW - W))
//#define KPX_GETXC_VXW(VX,VW,W)      (VX + (0.5 * (VW - W)))
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

//#define KPX_GETXC_VXW(VX,VW,W)      (VX + (0.5 * (VW - W)))
//#define KPX_GETXC(W)                KPX_GETXC_VXW(GUI_GRID_X,GUI_GRID_WAbs,W)
//#define KPX_DEFAULT_DIALOG_WC       (0.4 * GUI_GRID_WAbs)
//#define KPX_DEFAULT_DIALOG_XC       KPX_GETXC(KPX_DEFAULT_DIALOG_WC)

//#define KPX_GETYC(H)                KPX_GETXC_VXW(GUI_GRID_Y,GUI_GRID_HAbs,H)
//#define KPX_DEFAULT_DIALOG_HC       (0.4 * GUI_GRID_HAbs)
//#define KPX_DEFAULT_DIALOG_YC       KPX_GETYC_H(KPX_DEFAULT_DIALOG_HC)


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

//#define KPX_DEFAULT_DIALOG_WC       (0.4 * GUI_GRID_CENTER_WAbs)
//#define KPX_DEFAULT_DIALOG_HC       (0.4 * GUI_GRID_CENTER_HAbs)

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

//#define KPX_GETW_WXG(W,X,G)         KPX_GETW_WXGS(W,X,G,KPX_SPACING_W)
//#define KPX_GETH_HYG(H,Y,G)         KPX_GETH_HYGS(H,Y,G,KPX_SPACING_H)

#define KPX_GETWC_CTRLAREA_XG(X,G)  KPX_GETW_WXGS(KPX_DEFAULT_CTRLAREA_WC,X,G,KPX_SPACING_W)
#define KPX_GETHC_CTRLAREA_YG(Y,G)  KPX_GETH_HYGS(KPX_DEFAULT_CTRLAREA_HC,Y,G,KPX_SPACING_H)

// Get L/T aligned X/Y cartesian coordinates within the W/H grid (G) view
#define KPX_GETXL_VXWGS(VX,W,X,G,S)  (VX + KPX_GETW_WXGS(W,X,G,S))
#define KPX_GETYT_VYHGS(VY,H,Y,G,S)  (VY + KPX_GETW_WXGS(H,Y,G,S))



/////////////////////////////////////////////////////////////////////////////////////////
// TODO: TBD: all of these bits are on hold for the moment
/////////////////////////////////////////////////////////////////////////////////////////
/*
    --- Functions ---
 */

// The principle is the same regardless of whether horizontal or vertical dimension.
//#define XKP_GETSZ_DS(SZ,D,S) ((SZ * (D max 0)) + (S * (1 + (D max 0))))
// 1.                                             ^ Spacing (S)
// 2.                                ^                      ^ Dimension (D)
// 3.                          ^^ Size (SZ), number of grid cells to include
// 4.                                            ^^^^^^^^^^^^^^^^^^^^^ Spacing component (S, D)
// 5.                         ^^^^^^^^^^^^^^^^ Grid cells component (SZ, D)

// Gets the reference coordinate centered by the world component.
//#define XKP_GETCOORD_REFC_DW(D,W) ((W - D) / 2)
// 1.                                   ^ Dimension (D), usually the width or height
// 2.                               ^ World component (W), usually in terms of Abs (see above)

/* Gets the refreence coordinate aligned by the world maximum value.
 * Breaking it down a bit, in the horizontal, that means right aligned.
 * Similarly, in the vertical, that means bottom aligned. */
//#define XKP_GETCOORD_REFW_DW(D,W) (W - D)
// 1.                                  ^ Dimension (D), usually the width or height
// 2.                              ^ World component (W), usually in terms of Abs (see above)

/* Note: We do not think there is any need for a macro when you want
 * to specify a top or left aligned view. */

// So... how ever we arrive at the reference world X coordinate, X coordinate calculations should be consistent from there we think.
//#define XKP_GETCOORD_RGDS(RG,G,D,S) (RG + (S * (1 + (G max 0))) + (D * ((G - 1) max 0)))
// 1.                                                ^                   ^ Grid coord (G), the desired coord
// 2.                                                              ^ Grid dimension (D), i.e. number of coord
// 3.                                      ^ Spacing (S)
// 4.                                ^^ Reference (or world) grid coord (RG)
// 5.                                                              ^^^^^^^^^^^^^^^^^^^ Grid layout component
// 6.                                      ^^^^^^^^^^^^^^^^^^^ Spacing component

//
//#define XKP_GET_GRID_CELL_W(G,WAbs) ((WAbs - ((G + 1) * KPX_SPACING_W)) / G)
//#define XKP_GET_GRID_CELL_H(G,HAbs) ((HAbs - ((G + 1) * KPX_SPACING_H)) / G)
// 1. ...
// 2. ...
// 3. ...

/*
    Get width for an element
    Example: KP_GETW(KP_WIDTH_VAL,2)
    KP_WIDTH_VAL -> Width of the whole dialog (KP_X_VAL spacing to the left and to the right)
    2 -> Width for an element which fits 2 times in the content area from left to right (substracted by spacings to other elements left and right)

    GETW is in relation to the content area
    GETWPLAIN is in relation to the whole dialog width (for the buttons below for example)
 */

// TODO: TBD: let's focus on one size for the time being...
// TODO: TBD: we may rinse and repeat for larger or smaller grid gradients further on...
//#define XKP_GETW_DX(DX) (XKP_GETSZ_DS(GUI_GRID_W,DX,KPX_SPACING_W))
// 1.                                                   ^^^^^^^^^^^^^ Default spacing (S)
// 2.                                                ^^ X dimension (DX), i.e. number of X coord
// 3.                                 ^^^^^^^^^^^^^^ Default width (W)

//#define XKP_GETW_WDX(W,DX) (XKP_GETSZ_DS(W,DX,KPX_SPACING_W))

// Allowing for spacing.
//#define XKP_GETW_WDXS(W,DX,S) (XKP_GETSZ_DS(W,DX,S))
// 1.                                            ^ Spacing (S)
// 2.                                         ^^ X dimension (DX), i.e. number of X coord
// 3.                                       ^ Width (W)

/*
    Get height for an element
    Example: KP_GETH(KP_HEIGHT_VAL,10)
    KP_HEIGHT_VAL -> Height of the area between title bar and bottom buttons in the dialog
    10 -> Height for an element which fits 10 times in the content area from top to bottom (substracted by spacings to other elements above and below)
 */

// TODO: TBD: might need/want to include default or zero titles...
// TODO: TBD: i.e. min/max comprehension around it to factor it in/out automatically.
// TODO: TBD: ditto width, same for height...
//#define XKP_GETH_DY(DY) ((KPX_SPACING_H + KPX_TITLE_M_H) + (XKP_GETSZ_DS(GUI_GRID_H,DY,KPX_SPACING_H)))
// 1.                                                                                 ^^ Y dimension (DY), i.e. number of Y coord
// 2.                                                                  ^^^^^^^^^^^^^^ Default height
// 3.                                     ^^^^^^^^^^^ Title height
// 4.                     ^^^^^^^^^^^^^                                                  ^^^^^^^^^^^^^ Default spacing

// Allowing for spacing.
//#define XKP_GETH_HDYS(H,DY,S) ((S + KPX_TITLE_M_H) + (XKP_GETSZ_DS(H,DY,S)))
// 1.                                                              ^^ Y dimension (DY), i.e. number of Y coord
// 2.                                                            ^ Height (H)
// 3.                               ^^^^^^^^^^^ Title height
// 4.                           ^                                     ^ Spacing (S)

/*
    Get X coordinate
    Example: KP_GETCX(KP_X_VAL,KP_WIDTH_VAL,2,4)
    KP_X_VAL -> Left offset of the left dialog side from the edge of the screen
    KP_WIDTH_VAL -> Width of the whole dialog (KP_X_VAL spacing to the left and to the right)
    2 -> Coordinate of the 3rd element position (0,1,2,3,etc.)
    4 -> In relation to a 4 element X grid

    GETX is for a coordinate in relation to the whole dialog width
    GETCX is for a coordinate in relation to the content area (which has an equal spacing to all sides)
 */

// Calculates a center aligned reference coordinate.
//#define XKP_GETX_REFC_W(W) (XKP_GETCOORD_REFC_DW(W,GUI_GRID_WAbs))
// 1.                                              ^^^^^^^^^^^^^^^^^ Default absolute width
// 2.                                            ^ Width being centered (W)

// Calculates a right aligned reference coordinate.
//#define XKP_GETX_REFR_W(W) (XKP_GETCOORD_REFW_DW(W,GUI_GRID_WAbs))
// 1.                                              ^^^^^^^^^^^^^^^^^ Default absolute width
// 2.                                            ^ Width (W)

// So... how ever we arrive at the reference world X coordinate, X coordinate calculations should be consistent from there we think.
//#define XKP_GETX_RXWS(RX,X,W,S) (XKP_GETCOORD_RGDS(RX,X,W,S))
// 1.                                                     ^ Spacing (S)
// 2.                                                   ^ Width (W)
// 3.                                                 ^ The desired X coord (X)
// 4.                                              ^^ Requires prior reference X (RX) coord

// Rinse and repeat with sensible default arguments.
//#define XKP_GETX_RX(RX,X) (XKP_GETCOORD_RGDS(RX,X,GUI_GRID_W,KPX_SPACING_W))
// 1.                                                            ^^^^^^^^^^^^^ Default spacing
// 2.                                             ^^^^^^^^^^^^^^ Default width
// 3.                                           ^ The desired X coord (X)
// 4.                                        ^^ Requires prior reference X (RX) coord

//#define XKP_GETX_CROSS_RXWS(RX,RW,S,XW) (RX + RW - S - XW)
// 1.                                                  ^^ Cross width (XW)
// 2.                                              ^ Spacing (S)
// 3.                                         ^^ Requires prior total width (RW)
// 4.                                    ^^ Requires prior reference X coord (RX)

//#define XKP_GETX_CROSS_RXW(RX,RW) (XKP_GETX_CROSS_RXWS(RX,RW,KPX_SPACING_W,GUI_GRID_W))
// 1.                                                                      ^^^^^^^^^^^^^^ Cross width
// 2.                                                        ^^^^^^^^^^^^^ Spacing
// 3.                                                     ^^ Requires prior total width (RW)
// 4.                                                  ^^ Requires prior reference X (RX) coord


// TODO: TBD: in the same way we align XY coordinates by "grid" blocks...
// TODO: TBD: it would be nice to have a similar mechanism to gauge the WH components of the same.
// TODO: TBD: chiefly because guessing what that is by "how many would fit" is ridiculous...

// TODO: TBD: getting XY requires both POS as well as GRID
// TODO: TBD: we have a good sense of what we need to do...
// TODO: TBD: we have a fairly good handle on calculating HW components...
// TODO: TBD: next is to piece together a sane(r) XY component...
// TODO: TBD: then couple that with some plausible, typical, XYHW component scenarios...








//#define XKP_GETX(XVAL,WVAL,POS,GRID)    ((((XVAL + WVAL) / GRID) * POS) + (KPX_SPACING_W * ((POS - 1) max 0)))
//#define XKP_GETCX(POS,GRID)             (XKP_GETX((GUI_GRID_X),(GUI_GRID_WAbs),POS,GRID))
//#define XKP_GETX_CROSS(XVAL,WVAL)       (XVAL + WVAL - (KPX_SPACING_W - GUI_GRID_H))

//#define KP_GETX(XVAL,WVAL,POS,GRID)     safeZoneX + safeZoneW * (XVAL + POS * (WVAL + KP_SPACING_X) / GRID)
//#define KP_GETCX(XVAL,WVAL,POS,GRID)    safeZoneX + safeZoneW * (XVAL + (POS * WVAL + (GRID - POS) * KP_SPACING_X) / GRID)
//#define KP_GETX_CROSS(XVAL)             safeZoneX + safeZoneW * (1 - XVAL - 0.02)

/*
    Get Y coordinate
    Example: KP_GETCY(KP_Y_VAL,KP_HEIGHT_VAL,3,8)
    KP_Y_VAL -> Top offset of the dialog top from the edge of the screen
    KP_HEIGHT_VAL -> Height of the area between title bar and bottom buttons in the dialog
    3 -> Coordinate of the 4th element position (0,1,2,3,etc.)
    8 -> In relation to a 8 element Y grid

    GETY_AREA is for the Y coordinate of the beginning of the background (which frames the content area)
    GETY_BELOW is for the Y coordinate of the buttons below the background
 */

// Calculates a center aligned reference coordinate.
//#define XKP_GETY_REFC_H(H) (XKP_GETCOORD_REFC_DW(H,GUI_GRID_HAbs))
// 1.                                              ^^^^^^^^^^^^^^^^^ Default absolute height
// 2.                                            ^ Width being centered (H)

// Calculates a bottom aligned reference coordinate.
//#define XKP_GETY_REFB_H(H) (XKP_GETCOORD_REFW_DW(H,GUI_GRID_HAbs))
// 1.                                             ^^^^^^^^^^^^^^^^^ Default absolute height
// 2.                                           ^ Height (H)

/* Vertical calculations are a little different from horizontal in the sense it includes title.
 * For cross purposes, we do not need to know anything about the title since we calculate from
 * the top most reference coordinate (RY). */

//#define XKP_GETY_TITLE(RY) (RY + KPX_SPACING_H)
// 1.                            ^^^^^^^^^^^^^ Default vertical spacing
// 2.                       ^^ Reference Y coord

//#define XKP_GETY_CROSS_RYS(RY,S) (RY + S)
// 1.                                  ^ Spacing (S)
// 2.                             ^^ Requires prior reference Y coord (RY)

//#define XKP_GETY_CROSS_RY(RY) (XKP_GETY_CROSS_RYS(RY,KPX_SPACING_H))
// 1.                                                ^^^^^^^^^^^^^ Default vertical spacing
// 2.                                             ^^ Requires prior reference Y coord (RY)

//#define XKP_GETY_CTRL_RYTHS(RY,TH,S) ((S + TH) + XKP_GETY_CROSS_RY(RY,S))
// 1.                                                              ^^ Requires prior reference Y coord (RY)
// 2.                                      ^^ Title height (TH)
// 3.                                  ^                              ^ Spacing (S)

//#define XKP_GETY_CTRL_RY(RY) (XKP_GETY_CTRL_RYTHS(RY,KPX_TITLE_M_H,KPX_SPACING_H))
// 1.                                                            ^^^^^^^^^^^^^ Default vertical spacing
// 2.                                                ^^^^^^^^^^^ Default title height
// 3.                                             ^^ Requires prior reference Y coord (RY)




//#define KP_GETCY(YVAL,HVAL,POS,GRID)    safeZoneY + safeZoneH * ((YVAL + KP_HEIGHT_TITLE + KP_SPACING_Y) + (POS * HVAL + (GRID - POS) * KP_SPACING_Y) / GRID)
//#define KP_GETY_CROSS(YVAL)             safeZoneY + safeZoneH * (YVAL + 0.005)
//#define KP_GETY_AREA(YVAL)              safeZoneY + safeZoneH * (YVAL + KP_HEIGHT_TITLE + KP_SPACING_Y)
//#define KP_GETY_BELOW(YVAL,HVAL)        safeZoneY + safeZoneH * (YVAL + KP_HEIGHT_TITLE + 2 * KP_SPACING_Y + HVAL)


/*
    --- Standard sized dialog components ---
    (X from 0.25 - 0.75, Y from 0.2 - 0.8)
 */

//#define KP_X_VAL                        0.25
//#define KP_Y_VAL                        0.2

//#define KP_WIDTH_VAL                    (1 - 2 * KP_X_VAL)
//#define KP_HEIGHT_VAL                   (1 - 2 * KP_Y_VAL - KP_HEIGHT_TITLE - KP_HEIGHT_BUTTON - 2 * KP_SPACING_Y)

/*
    --- Large sized dialog components ---
    (X from 0.15 - 0.85, Y from 0.15 - 0.85)
 */

//#define KP_X_VAL_L                      0.15
//#define KP_Y_VAL_L                      0.15

//#define KP_WIDTH_VAL_L                  (1 - 2 * KP_X_VAL_L)
//#define KP_HEIGHT_VAL_L                 (1 - 2 * KP_Y_VAL_L - KP_HEIGHT_TITLE - KP_HEIGHT_BUTTON - 2 * KP_SPACING_Y)

/*
    --- Corner dialog components ---
    (X from 0.035 - 0.235, Y from 0.05 - 0.8)
 */

//#define KP_X_VAL_C                      0.035
//#define KP_Y_VAL_C                      0.05

//#define KP_WIDTH_VAL_C                  0.2
//#define KP_HEIGHT_VAL_C                 (0.75 - KP_HEIGHT_TITLE - KP_HEIGHT_BUTTON - 2 * KP_SPACING_Y)

/*
    --- Left panel dialog components ---
    (X from 0.0025 - 0.2025, Y from 0.0025 - 0.9975)
 */

//#define KP_X_VAL_LP                     0.0025
//#define KP_Y_VAL_LP                     0.0025

//#define KP_WIDTH_VAL_LP                 0.2
//#define KP_HEIGHT_VAL_LP                (1 - 2 * KP_Y_VAL_LP - KP_HEIGHT_TITLE - KP_HEIGHT_BUTTON - 2 * KP_SPACING_Y)

/*
    --- Right panel dialog components ---
    (X from 0.7975 - 0.9975, Y from 0.0025 - 0.9975)
 */

//#define KP_X_VAL_RP                     0.7975
//#define KP_Y_VAL_RP                     0.0025

//#define KP_WIDTH_VAL_RP                 0.2
//#define KP_HEIGHT_VAL_RP                (1 - 2 * KP_Y_VAL_RP - KP_HEIGHT_TITLE - KP_HEIGHT_BUTTON - 2 * KP_SPACING_Y)

/*
    --- Small dialog components ---
    (X from 0.3 - 0.7, Y from 0.15 - 0.85)
 */

// TODO: TBD: so, not XKP_GUI_GRID_WAbs (?) or XKP_GUI_GRID_HAbs (?)
//#define XKP_GUI_DIALOG_WAbs_M               (0.4 * GUI_GRID_WAbs)
//#define XKP_GUI_DIALOG_HAbs_M               (0.4 * GUI_GRID_HAbs)

// Decompose the grid first; serves as the basis for all the other calcs.
//#define XKP_GUI_GRID_DIM_W_M                24
//#define XKP_GUI_GRID_DIM_H_M                (XKP_GUI_GRID_DIM_W_M / 1.2)

//#define XKP_GUI_GRID_CELL_WAbs_M            (XKP_GET_GRID_CELL_W(XKP_GUI_GRID_DIM_W_M,XKP_GUI_DIALOG_WAbs_M))
//#define XKP_GUI_GRID_CELL_HAbs_M            (XKP_GET_GRID_CELL_H(XKP_GUI_GRID_DIM_H_M,XKP_GUI_DIALOG_HAbs_M))


//#define XKP_GUI_GRID_WAbs_WCell_M       (XKP_GET_GRID_CELL_W(XKP_GRIDDEF_DIM_M_G,XKP_GUI_GRID_WAbs_DIALOG_M))


//#define XKP_DIALOG_WIDTH_S_WAbs         (0.9 * XKP_GUI_GRID_DIALOG_WAbs_M)
//#define XKP_DIALOG_WIDTH_L_WAbs         (1.1 * XKP_GUI_GRID_DIALOG_WAbs_M)

// TODO: TBD: and not KPX_TITLE_M_H (?) ...
//#define XKP_DIALOG_HEIGHT_S_HAbs        (0.9 * XKP_DIALOG_HEIGHT_M_HAbs)
//#define XKP_DIALOG_HEIGHT_L_HAbs        (1.1 * XKP_DIALOG_HEIGHT_M_HAbs)

// TODO: TBD: work out the kinds with "medium" first...
//#define XKP_X_DIALOG_COORD_M_WAbs              XKP_GETX_REFC_W(XKP_GUI_GRID_DIALOG_WAbs_M)
//#define XKP_Y_DIALOG_COORD_M_HAbs              XKP_GETY_REFC_H(XKP_DIALOG_HEIGHT_M_HAbs)

//#define XKP_X_DIALOG_CTRLBG_M_WAbs             (XKP_X_DIALOG_COORD_M_WAbs)
//#define XKP_Y_DIALOG_CTRLBG_H_HAbs
//XKP_Y_DIALOG_COORD_M_HAbs + KPX_SPACING_H +

// TODO: TBD: sorting out the finer points of the grid-based calculations...
//#define XKP_X_DIALOG_CTRL_M_WAbs               XKP_X_DIALOG_CTRLBG_M_WAbs + KPX_SPACING_W)
//#define XKP_Y

//#define KP_X_VAL_S                      0.3
//#define KP_Y_VAL_S                      0.15

//#define KP_WIDTH_VAL_S                  0.4
//#define KP_HEIGHT_VAL_S                 (0.7 - KP_HEIGHT_TITLE - KP_HEIGHT_BUTTON - 2 * KP_SPACING_Y)

/*
    --- Small right dialog components ---
    (X from 0.80 - 0.95, Y from 0.15 - 0.85)
 */

//#define KP_X_VAL_SR                      0.80
//#define KP_Y_VAL_SR                      0.15

//#define KP_WIDTH_VAL_SR                  0.15
//#define KP_HEIGHT_VAL_SR                 (0.7 - KP_HEIGHT_TITLE - KP_HEIGHT_BUTTON - 2 * KP_SPACING_Y)
