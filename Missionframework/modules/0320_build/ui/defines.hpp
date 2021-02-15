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

#define KPLIB_IDC_BUILD_CONFIRM             700301

#define KPLIB_IDC_BUILD_DIALOG_AREA         700401

// All tabs IDCs
#define KPLIB_BUILD_TABS_IDCS_ARRAY         [70100,70101,70102,70103,70104,70105,70106,70107]

// TODO: TBD: this one is a mission artifact
// TODO: TBD: should probably be factored into the overall KPGUI "defines.hpp"
// TODO: TBD: but for now, this is the only known usage...
#define KPLIB_IDC_MISSION_VIGNETTE_MARKER   1202
// TODO: TBD: however, not sure what this marker is all about...
// TODO: TBD: i.e. it happens to refer to a 'KPLIB_eden_airspawn_10', which we think is happy coincidence, possibly mistaken identity
// TODO: TBD: in other words, vignette marker of what? not an airspawn, most likely...
