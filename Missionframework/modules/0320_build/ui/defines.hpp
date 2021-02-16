/*
    KP LIBERATION BUILD UI DEFINES

    File: defines.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-07-01
    Last Update: 2018-12-09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Common defines for build module UI elements
*/

// General defines
#define KPLIB_BUILD_TAB_Y_OFFSET            0.02

// IDCs
#define KPLIB_IDC_MOUSEHANDLER              101

#define KPLIB_IDD_BUILD_DIALOG              700000
#define KPLIB_IDC_BUILD_CATEGORY_LIST       700100

#define KPLIB_IDC_BUILD_SEARCH              700101
#define KPLIB_IDC_BUILD_SEARCH_BUTTON       700102

#define KPLIB_IDC_BUILD_TOOLBOX_MODE        700111
#define KPLIB_IDC_BUILD_TOOLBOX_HEADING     700112

#define KPLIB_IDC_BUILD_ITEM_LIST           700202

#define KPLIB_IDC_BUILD_BTNBUILD            700301

#define KPLIB_IDC_BUILD_DIALOG_AREA         700401

// All tabs IDCs (i.e. based on legacy framework...)
// was: #define KPLIB_BUILD_TABS_IDCS_ARRAY         [70100,70101,70102,70103,70104,70105,70106,70107]

/* TODO: TBD: which we use to hide bits...
 *  KPLIB_IDC_BUILD_CATEGORY_LIST   - 700100
 *  KPLIB_IDC_BUILD_SEARCH          - 700100
 *  KPLIB_IDC_BUILD_SEARCH_BUTTON   - 700102
 */
#define KPLIB_BUILD_TABS_IDCS_ARRAY         [700100,700101,700102,700111,700202,700401]

/*
// So... this view offers a clue. More than likely these may be artifacts of the refactory, literally lifting the build UI bits from the legacy framework and transplanting them here...
// TODO: TBD: well, with the advent of the new dialog styles, modes, etc... much of that is conveyed a bit differently now...
// https://github.com/KillahPotatoes/KP-Liberation/blame/Rewrite-icebox/Missionframework/modules/15_build/ui/defines.hpp#L34
// https://github.com/KillahPotatoes/KP-Liberation/commit/4f15f1abeba75bfcad4ec3d609f8309d2c6d7379#diff-47034fd916d4e7b461f3d7521cd55638c9af058ae11a9feb0e8ec46843ba6193
// IDCs
#define KPLIB_IDC_MOUSEHANDLER                101
#define KPLIB_IDC_BUILD_TAB_INFANTRY        70100
#define KPLIB_IDC_BUILD_TAB_LIGHT           70101
#define KPLIB_IDC_BUILD_TAB_HEAVY           70102
#define KPLIB_IDC_BUILD_TAB_AIR             70103
#define KPLIB_IDC_BUILD_TAB_STATIC          70104
#define KPLIB_IDC_BUILD_TAB_BUILDING        70105
#define KPLIB_IDC_BUILD_TAB_SUPPORT         70106
#define KPLIB_IDC_BUILD_TAB_SQUAD           70107

#define KPLIB_IDC_BUILD_CATEGORY_LIST       70100

#define KPLIB_IDC_BUILD_SEARCH              70101
#define KPLIB_IDC_BUILD_SEARCH_BUTTON       70102

#define KPLIB_IDC_BUILD_TOOLBOX_MOVEITEMS   70111
 */

// TODO: TBD: ^^ ^^ ^^ (see above)
// TODO: TBD: investigating which controls are being enabled or disabled entering a "single build mode" ...
// TODO: TBD: in particular not sure what [70103,70104,70105,70106,70107] are/were... even tracing back in the file history, we just do not know...

// TODO: TBD: this one is a mission artifact
// TODO: TBD: should probably be factored into the overall KPGUI "defines.hpp"
// TODO: TBD: but for now, this is the only known usage...
#define KPLIB_IDC_MISSION_VIGNETTE_MARKER   1202
// TODO: TBD: however, not sure what this marker is all about...
// TODO: TBD: i.e. it happens to refer to a 'KPLIB_eden_airspawn_10', which we think is happy coincidence, possibly mistaken identity
// TODO: TBD: in other words, vignette marker of what? not an airspawn, most likely...
