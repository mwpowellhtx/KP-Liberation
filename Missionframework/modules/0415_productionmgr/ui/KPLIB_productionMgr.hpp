/*
    KP Liberation productionMgr dialog

    File: KPLIB_productionMgr.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 14:19:21
    Last Update: 2021-02-06 14:19:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Opens the module dialog.
*/

#define KPLIB_PRODUCTIONMGR_DIALOG_WC           (0.8 * KPX_DEFAULT_DIALOG_WC)
#define KPLIB_PRODUCTIONMGR_DIALOG_HC           KPX_DEFAULT_DIALOG_HC
#define KPLIB_PRODUCTIONMGR_DIALOG_XC           KPX_GETXC_W(KPLIB_PRODUCTIONMGR_DIALOG_WC)

#define KPLIB_PRODUCTIONMGR_TITLE_WC            KPLIB_PRODUCTIONMGR_DIALOG_WC
#define KPLIB_PRODUCTIONMGR_TITLE_XC            KPLIB_PRODUCTIONMGR_DIALOG_XC
#define KPLIB_PRODUCTIONMGR_CROSS_XC            (KPLIB_PRODUCTIONMGR_TITLE_XC + KPLIB_PRODUCTIONMGR_TITLE_WC - GUI_GRID_W)

#define KPLIB_PRODUCTIONMGR_CTRLAREA_XC         KPX_GETXL_VXW(KPLIB_PRODUCTIONMGR_DIALOG_XC,KPX_SPACING_W)
#define KPLIB_PRODUCTIONMGR_CTRLAREA_YC         KPX_DEFAULT_CTRLAREA_YC

#define KPLIB_PRODUCTIONMGR_LNBSECTORS_H        (KPX_DEFAULT_DIALOG_HC - (3 * (KPX_BUTTON_M_H + KPX_SPACING_H)))
#define KPLIB_PRODUCTIONMGR_LNBSECTORS_W        KPX_GETW_VWGS(KPLIB_PRODUCTIONMGR_DIALOG_WC,8,25,KPX_SPACING_W)

// Four rows, three status rows plus one 'header' row
#define KPLIB_PRODUCTIONMGR_LNBSTATUS_H         (5 * KPX_TEXT_M)
#define KPLIB_PRODUCTIONMGR_LNBSTATUS_W         (KPLIB_PRODUCTIONMGR_DIALOG_WC - KPLIB_PRODUCTIONMGR_LNBSECTORS_W + KPX_SPACING_W)

#define KPLIB_PRODUCTIONMGR_LNBSTATUS_XC        KPX_GETXL_VXW(KPLIB_PRODUCTIONMGR_CTRLAREA_XC,(KPLIB_PRODUCTIONMGR_LNBSECTORS_W + KPX_SPACING_W))
#define KPLIB_PRODUCTIONMGR_LNBSTATUS_YC        KPLIB_PRODUCTIONMGR_CTRLAREA_YC

#define KPLIB_PRODUCTIONMGR_LNBQUEUE_H          (7 * KPX_TEXT_M)
#define KPLIB_PRODUCTIONMGR_LNBQUEUE_W          KPX_GETW_VWGS(KPLIB_PRODUCTIONMGR_DIALOG_WC,6,25,KPX_SPACING_W)

#define KPLIB_PRODUCTIONMGR_LNBQUEUE_XC         KPLIB_PRODUCTIONMGR_LNBSTATUS_XC
#define KPLIB_PRODUCTIONMGR_LNBQUEUE_YC         KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_LNBSTATUS_YC,(KPX_SPACING_H + KPLIB_PRODUCTIONMGR_LNBSTATUS_H))

// Math from the bottom of the dialog up, which simplifies the substitution throughout as well.
#define KPLIB_PRODUCTIONMGR_BTN_GETDELTAH(BY)   (KPX_DEFAULT_DIALOG_HC - ((BY + 1) * KPX_BUTTON_M_H) - (BY * KPX_SPACING_H))

class KPLIB_productionMgr {
    idd = KPLIB_IDD_PRODUCTIONMGR;
    movingEnable = 0;

    onLoad = "_this call KPLIB_fnc_productionMgr_onLoad";

    class controlsBackground {

        //// TODO: TBD: starting slowing to prove this thing out...
        //class KPLIB_DialogTitle : KPGUI_PRE_DialogTitleS {
        class KPLIB_DialogTitle : XGUI_PRE_DialogTitleC {
            x = KPLIB_PRODUCTIONMGR_TITLE_XC;
            w = KPLIB_PRODUCTIONMGR_TITLE_WC;
            text = "$STR_KPLIB_DIALOG_PRODUCTIONMGR_TITLE";
            onLoad = "_this call KPLIB_fnc_productionMgr_ctrlBg_title_onLoad";
        };

        //class KPLIB_DialogArea : KPGUI_PRE_DialogBackgroundS {
        class KPLIB_DialogArea : XGUI_PRE_DialogBackgroundC {
            x = KPLIB_PRODUCTIONMGR_DIALOG_XC;
            w = KPLIB_PRODUCTIONMGR_DIALOG_WC;
        };

        // Tools controlsGroup

        // class KPLIB_GroupTools : KPGUI_PRE_ControlsGroupNoScrollbars {
        //     idc = KPLIB_IDC_CRATEFILLER_GROUPOVERVIEW;
        //     x = safezoneX;
        //     y = safezoneY;
        //     w = safezoneW;
        //     h = safezoneH;

        //     class controls {

        //         class KPLIB_DialogTitleTools: KPGUI_PRE_DialogTitleSR {
        //             text = "$STR_KPLIB_DIALOG_CRATEFILLER_TITLEOVERVIEW";
        //             x = KP_GETX(KP_X_VAL_SR,KP_WIDTH_VAL_SR,0,1) - safezoneX;
        //             y = safeZoneY + safeZoneH * KP_Y_VAL_SR - safezoneY;
        //         };

        //         class KPLIB_DialogAreaTools: KPGUI_PRE_DialogBackgroundSR {
        //             x = KP_GETX(KP_X_VAL_SR,KP_WIDTH_VAL_SR,0,1) - safezoneX;
        //             y = KP_GETY_AREA(KP_Y_VAL_SR) - safezoneY;
        //         };

        //         class KPLIB_ComboGroups: KPGUI_PRE_Combo {
        //             idc = KPLIB_IDC_CRATEFILLER_COMBOGROUPS;
        //             x = KP_GETCX(KP_X_VAL_SR,KP_WIDTH_VAL_SR,0,1) - safezoneX;
        //             y = KP_GETCY(KP_Y_VAL_SR,KP_HEIGHT_VAL_SR,0,48) - safezoneY;
        //             w = KP_GETW(KP_WIDTH_VAL_SR,1);
        //             h = KP_GETH(KP_HEIGHT_VAL_SR,24);
        //             tooltip = "$STR_KPLIB_DIALOG_CRATEFILLER_GROUPS_TT";
        //             onLBSelChanged = "[] call KPLIB_fnc_cratefiller_getPlayers";
        //         };

        //         class KPLIB_ComboPlayers: KPLIB_ComboGroups {
        //             idc = KPLIB_IDC_CRATEFILLER_COMBOPLAYERS;
        //             y = KP_GETCY(KP_Y_VAL_SR,KP_HEIGHT_VAL_SR,2,48) - safezoneY;
        //             tooltip = "$STR_KPLIB_DIALOG_CRATEFILLER_PLAYERS_TT";
        //             onLBSelChanged = "[] call KPLIB_fnc_cratefiller_getPlayerInventory";
        //         };

        //         class KPLIB_MainWeapon: KPGUI_PRE_PictureRatio {
        //             idc = KPLIB_IDC_CRATEFILLER_MAINWEAPON;
        //             text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\PrimaryWeapon_ca.paa";
        //             x = KP_GETCX(KP_X_VAL_SR,KP_WIDTH_VAL_SR,0,1) - safezoneX;
        //             y = KP_GETCY(KP_Y_VAL_SR,KP_HEIGHT_VAL_SR,6,48) - safezoneY;
        //             w = KP_GETW(KP_WIDTH_VAL_SR,1);
        //             h = KP_GETH(KP_HEIGHT_VAL_SR,4);
        //         };

        //         class KPLIB_Handgun: KPLIB_MainWeapon {
        //             idc = KPLIB_IDC_CRATEFILLER_HANDGUN;
        //             text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Handgun_ca.paa";
        //             y = KP_GETCY(KP_Y_VAL_SR,KP_HEIGHT_VAL_SR,21,48) - safezoneY;
        //         };

        //         class KPLIB_SecondaryWeapon: KPLIB_MainWeapon {
        //             idc = KPLIB_IDC_CRATEFILLER_SECONDARYWEAPONS;
        //             text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\SecondaryWeapon_ca.paa";
        //             y = KP_GETCY(KP_Y_VAL_SR,KP_HEIGHT_VAL_SR,36,48) - safezoneY;
        //         };
        //     };
        // };

        // Tools controlsGroup end
    };

    class controls {

        // https://community.bistudio.com/wiki/CT_LISTNBOX
        // https://community.bistudio.com/wiki/CT_LISTNBOX#columns
        class KPLIB_ctrl_lnbSectors : XGUI_PRE_ListNBox {
            default = 0;
            idc = KPLIB_IDC_PRODUCTIONMGR_CTRL_LNBSECTORS;

            x = KPLIB_PRODUCTIONMGR_CTRLAREA_XC;
            y = KPLIB_PRODUCTIONMGR_CTRLAREA_YC;
            w = KPLIB_PRODUCTIONMGR_LNBSECTORS_W;
            h = KPLIB_PRODUCTIONMGR_LNBSECTORS_H;

            sizeEx = KPX_TEXT_S;
            rowHeight = KPX_TITLE_S_H;

            //          {_grid, _markerText}
            columns[] = {-0.01,         0.2};

            onLoad = "_this call KPLIB_fnc_productionMgr_lnbSectors_onLoad";
            onLBSelChanged = "_this call KPLIB_fnc_productionMgr_lnbSectors_onLBSelChanged";
        };

        class KPLIB_ctrl_lnbStatus : XGUI_PRE_ListNBox {
            idc = KPLIB_IDC_PRODUCTIONMGR_CTRL_LNBSTATUS;
            x = KPLIB_PRODUCTIONMGR_LNBSTATUS_XC;
            y = KPLIB_PRODUCTIONMGR_LNBSTATUS_YC;
            w = KPLIB_PRODUCTIONMGR_LNBSTATUS_W;
            h = KPLIB_PRODUCTIONMGR_LNBSTATUS_H;

            sizeEx = KPX_TEXT_S;
            rowHeight = KPX_TITLE_S_H;

            //          { _img, _label, _cap, _prod, _totals, crates}
            columns[] = {-0.01,  0.075,  0.2,  0.35,     0.5,    0.6};

            onLoad = "_this call KPLIB_fnc_productionMgr_lnbStatus_onLoad";
            onLBSelChanged = "_this call KPLIB_fnc_productionMgr_lnbStatus_onLBSelChanged";
            onLBDblClick = "_this call KPLIB_fnc_productionMgr_lnbStatus_onLBDblClick";
        };

        class KPLIB_ctrl_lnbQueue : XGUI_PRE_ListNBox {
            idc = KPLIB_IDC_PRODUCTIONMGR_CTRL_LNBQUEUE;
            x = KPLIB_PRODUCTIONMGR_LNBQUEUE_XC;
            y = KPLIB_PRODUCTIONMGR_LNBQUEUE_YC;
            w = KPLIB_PRODUCTIONMGR_LNBQUEUE_W;
            h = KPLIB_PRODUCTIONMGR_LNBQUEUE_H;

            sizeEx = KPX_TEXT_S;
            rowHeight = KPX_TITLE_S_H;

            //          { _img, _label}
            columns[] = {-0.01,    0.3};

            onLoad = "_this call KPLIB_fnc_productionMgr_lnbQueue_onLoad";
            onLBSelChanged = "_this call KPLIB_fnc_productionMgr_lnbQueue_onLBSelChanged";
            onLBDblClick = "_this call KPLIB_fnc_productionMgr_lnbQueue_onLBDblClick";
        };

        // class KPLIB_ButtonTools: KPGUI_PRE_DialogCrossS {
        //     idc = KPLIB_IDC_CRATEFILLER_BUTTONOVERVIEW;
        //     text = "KPGUI\res\icon_tools.paa";
        //     x = safeZoneX + safeZoneW * (KP_X_VAL_S + KP_WIDTH_VAL_S - 0.04);
        //     tooltip = "$STR_KPLIB_DIALOG_CRATEFILLER_OVERVIEW_TT";
        //     action = "[] call KPLIB_fnc_cratefiller_showOverview";
        // };

        // // Equipment

        // class KPLIB_EquipmentTitle: KPGUI_PRE_InlineTitle {
        //     text = "$STR_KPLIB_DIALOG_CRATEFILLER_TITLEEQUIPMENT";
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,2);
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,0,48);
        //     w = KP_GETW(KP_WIDTH_VAL_S,2);
        //     h = KP_GETH(KP_HEIGHT_VAL_S,16);
        // };

        // class KPLIB_ComboEquipment: KPGUI_PRE_Combo {
        //     idc = KPLIB_IDC_CRATEFILLER_COMBOEQUIPMENT;
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,3,48);
        //     w = KP_GETW(KP_WIDTH_VAL_S,2);
        //     h = KP_GETH(KP_HEIGHT_VAL_S,24);
        //     tooltip = "$STR_KPLIB_DIALOG_CRATEFILLER_CATEGORY_TT";
        //     onLBSelChanged = "[] call KPLIB_fnc_cratefiller_createEquipmentList";
        // };

        // class KPLIB_ComboWeapons: KPLIB_ComboEquipment {
        //     idc = KPLIB_IDC_CRATEFILLER_COMBOWEAPONS;
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,5,48);
        //     w = KP_GETW(KP_WIDTH_VAL_S,3);
        //     tooltip = "$STR_KPLIB_DIALOG_CRATEFILLER_WEAPONSELECTION_TT";
        //     onLBSelChanged = "[] call KPLIB_fnc_cratefiller_createSubList";
        // };

        // class KPLIB_SearchBar: KPGUI_PRE_EditBox {
        //     idc = KPLIB_IDC_CRATEFILLER_SEARCHBAR;
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,1,3);
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,5,48);
        //     w = KP_GETW(KP_WIDTH_VAL_S,6);
        //     h = KP_GETH(KP_HEIGHT_VAL_S,24);
        //     tooltip = "$STR_KPLIB_DIALOG_CRATEFILLER_SEARCH_TT";
        //     onKeyUp = "[] call KPLIB_fnc_cratefiller_search";
        // };

        // class KPLIB_LeftEquipmentListButton: KPGUI_PRE_BUTTON {
        //     idc = KPLIB_IDC_CRATEFILLER_LEFTEQUIPMENTBUTTON;
        //     text = "-";
        //     onButtonClick = "[687413] call KPLIB_fnc_cratefiller_removeEquipment";
        // };

        // class KPLIB_RightEquipmentListButton: KPGUI_PRE_BUTTON {
        //     idc = KPLIB_IDC_CRATEFILLER_RIGHTEQUIPMENTBUTTON;
        //     text = "+";
        //     onButtonClick = "[687413] call KPLIB_fnc_cratefiller_addEquipment";
        // };

        // class KPLIB_EquipmentList: KPGUI_PRE_ListNBox {
        //     idc = KPLIB_IDC_CRATEFILLER_EQUIPMENTLIST;
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,8,48);
        //     w = KP_GETW(KP_WIDTH_VAL_S,2);
        //     h = KP_GETH(KP_HEIGHT_VAL_S,(48/38));

        //     columns[] = {0.05, 0.2};

        //     idcLeft = KPLIB_IDC_CRATEFILLER_LEFTEQUIPMENTBUTTON;
        //     idcRight = KPLIB_IDC_CRATEFILLER_RIGHTEQUIPMENTBUTTON;
        // };

        // // Crates

        // class KPLIB_TransportTitle: KPLIB_EquipmentTitle {
        //     text = "$STR_KPLIB_DIALOG_CRATEFILLER_TITLETRANSPORT";
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,1,2);
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,0,48);
        // };

        // class KPLIB_ComboCargo: KPGUI_PRE_Combo {
        //     idc = KPLIB_IDC_CRATEFILLER_COMBOCARGO;
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,1,2);
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,3,48);
        //     w = KP_GETW(KP_WIDTH_VAL_S,(24/11));
        //     h = KP_GETH(KP_HEIGHT_VAL_S,24);
        //     tooltip = "$STR_KPLIB_DIALOG_CRATEFILLER_INVENTORY_TT";
        //     onLBSelChanged = "[] call KPLIB_fnc_cratefiller_showInventory";
        // };

        // class KPLIB_RefreshCargo: KPGUI_PRE_CloseCross {
        //     text = "KPGUI\res\icon_refresh.paa";
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,23,24);
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,3,48);
        //     w = KP_GETW(KP_WIDTH_VAL_S,24);
        //     h = KP_GETH(KP_HEIGHT_VAL_S,24);
        //     tooltip = "$STR_KPLIB_DIALOG_CRATEFILLER_REFRESH_TT";
        //     action = "[] call KPLIB_fnc_cratefiller_getNearStorages";
        // };

        // // Inventory

        // class KPLIB_InventoryTitle: KPLIB_TransportTitle {
        //     text = "$STR_KPLIB_DIALOG_CRATEFILLER_TITLEINVENTORY";
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,5,48);
        // };

        // class KPLIB_ExportName: KPLIB_SearchBar {
        //     idc = KPLIB_IDC_CRATEFILLER_EXPORTNAME;
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,2,4);
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,8,48);
        //     w = KP_GETW(KP_WIDTH_VAL_S,4);
        //     tooltip = "$STR_KPLIB_DIALOG_CRATEFILLER_EXPORT_TT";
        // };

        // class KPLIB_ImportName: KPGUI_PRE_Combo {
        //     idc = KPLIB_IDC_CRATEFILLER_IMPORTNAME;
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,3,4);
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,8,48);
        //     w = KP_GETW(KP_WIDTH_VAL_S,4);
        //     h = KP_GETH(KP_HEIGHT_VAL_S,24);
        //     tooltip = "$STR_KPLIB_DIALOG_CRATEFILLER_IMPORT_TT";
        // };

        // class KPLIB_ButtonExport: KPGUI_PRE_InlineButton {
        //     text = "Export";
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,2,4);
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,10,48);
        //     w = KP_GETW(KP_WIDTH_VAL_S,4);
        //     h = KP_GETH(KP_HEIGHT_VAL_S,24);
        //     onButtonClick = "[] call KPLIB_fnc_cratefiller_export";
        // };

        // class KPLIB_ButtonImport: KPLIB_ButtonExport {
        //     text = "Import";
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,3,4);
        //     w = KP_GETW(KP_WIDTH_VAL_S,(24/5));
        //     onButtonClick = "[] call KPLIB_fnc_cratefiller_import";
        // };

        // class KPLIB_DeletePreset: KPGUI_PRE_CloseCross {
        //     text = "KPGUI\res\icon_recyclebin.paa";
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,23,24);
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,10,48);
        //     w = KP_GETW(KP_WIDTH_VAL_S,24);
        //     h = KP_GETH(KP_HEIGHT_VAL_S,24);
        //     tooltip = "$STR_KPLIB_DIALOG_CRATEFILLER_DELETE_TT";
        //     action = "[] call KPLIB_fnc_cratefiller_deletePreset";
        // };

        // class KPLIB_LeftInventoryListButton: KPGUI_PRE_BUTTON {
        //     idc = KPLIB_IDC_CRATEFILLER_LEFTINVENTORYBUTTON;
        //     text = "-";
        //     onButtonClick = "[687418] call KPLIB_fnc_cratefiller_removeEquipment";
        // };

        // class KPLIB_RightInventoryListButton: KPGUI_PRE_BUTTON {
        //     idc = KPLIB_IDC_CRATEFILLER_RIGHTINVENTORYBUTTON;
        //     text = "+";
        //     onButtonClick = "[687418] call KPLIB_fnc_cratefiller_addEquipment";
        // };

        // class KPLIB_InventoryList: KPGUI_PRE_ListNBox {
        //     idc = KPLIB_IDC_CRATEFILLER_INVENTORYLIST;
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,1,2);
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,12,48);
        //     w = KP_GETW(KP_WIDTH_VAL_S,2);
        //     h = KP_GETH(KP_HEIGHT_VAL_S,(48/34));

        //     columns[] = {0.05, 0.2, 0.3};

        //     idcLeft = KPLIB_IDC_CRATEFILLER_LEFTINVENTORYBUTTON;
        //     idcRight = KPLIB_IDC_CRATEFILLER_RIGHTINVENTORYBUTTON;
        // };

        // class KPLIB_ProgressBar : KPGUI_PRE_ProgressBar {
        //     idc = KPLIB_IDC_CRATEFILLER_PROGRESSBAR;
        //     x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
        //     y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,46,48);
        //     w = KP_GETW(KP_WIDTH_VAL_S,1);
        //     h = KP_GETH(KP_HEIGHT_VAL_S,24);
        //     tooltip = "$STR_KPLIB_DIALOG_CRATEFILLER_FILLLEVEL_TT";
        // };

        //class KPLIB_DialogCross : KPGUI_PRE_DialogCrossS {
        //};

        class KPLIB_ctrl_btnRefresh : XGUI_PRE_Button {
            x = KPLIB_PRODUCTIONMGR_CTRLAREA_XC;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_CTRLAREA_YC,KPLIB_PRODUCTIONMGR_BTN_GETDELTAH(2));
            w = KPLIB_PRODUCTIONMGR_LNBSECTORS_W;

            // TODO: TBD: refactor to string table...
            text = "Refresh";

            onLoad = "_this call KPLIB_fnc_productionMgr_onLoad_debug";
        };

        class KPLIB_ctrl_btnApply : XGUI_PRE_Button {
            x = KPLIB_PRODUCTIONMGR_CTRLAREA_XC;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_CTRLAREA_YC,KPLIB_PRODUCTIONMGR_BTN_GETDELTAH(1));
            w = KPLIB_PRODUCTIONMGR_LNBSECTORS_W;

            // TODO: TBD: refactor to string table...
            text = "Apply";

            onLoad = "_this call KPLIB_fnc_productionMgr_onLoad_debug";
        };

        class KPLIB_ctrl_btnClose : XGUI_PRE_Button {
            x = KPLIB_PRODUCTIONMGR_CTRLAREA_XC;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_CTRLAREA_YC,KPLIB_PRODUCTIONMGR_BTN_GETDELTAH(0));
            w = KPLIB_PRODUCTIONMGR_LNBSECTORS_W;

            // TODO: TBD: refactor to string table...
            text = "Close";

            onLoad = "_this call KPLIB_fnc_productionMgr_onLoad_debug";
        };

        class KPLIB_DialogCross : XGUI_PRE_DialogCrossC {
            x = KPLIB_PRODUCTIONMGR_CROSS_XC;
        };
    };
};
