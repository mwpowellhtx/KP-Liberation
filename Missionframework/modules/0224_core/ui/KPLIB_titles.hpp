// // TODO: TBD: refactored to HUD modules
// #include "..\ui\defines.hpp"
// /*
//     KP Liberation rsc titles defines

//     File: KPLIB_titles.hpp
//     Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
//     Date: 2017-10-28
//     Last Update: 2019-03-31
//     License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

//     Description:
//         The rsc titles, sounds and the player status overlay are defined here.
// */

// class CfgSounds
// {
//     sounds[] = {};
//     class parasound
//     {
//         name = "parasound";
//         sound[] = {"res\c130.ogg", 1.0, 1};
//         titles[] = {};
//     };
// };

// // TODO: TBD: review the legacy bits and cross compare...
// // TODO: TBD: definitely want to consider layers...
// // TODO: TBD: but moreover refactoring from the "core" module to a proper "headsUp" module...
// // TODO: TBD: and then, maybe it is after all that headUpDisplay and hud are the same thing and consolidate...
// class RscTitles
// {
//     class blank
//     {
//         name = "blank";
//         duration = 999999;
//         idd = KPLIB_IDD_CORE_RSCTITLE_BLANK;
//         movingEnable = true;
//         onLoad = "";
//         controls[]={};
//     };

//     class fasttravel
//     {
//         name = "fasttravel";
//         duration = 4;
//         idd = KPLIB_IDD_UNDEFINED;
//         movingEnable = true;

//         controls[]=
//         {
//             OuterBackground,GenericLabel111
//         };
//         class OuterBackground {
//             idc = KPLIB_IDC_UNDEFINED;
//             type =  0;
//             style = 0;
//             colorText[] = COLOR_BLACK;
//             colorBackground[] = COLOR_BLACK;
//             font = "RobotoCondensed";
//             sizeEx = 0.023;
//             x = -3; y = -3;
//             w = 9;  h = 9;
//             text = "";
//         };
//         class GenericLabel111 {
//             idc = KPLIB_IDC_UNDEFINED;
//             type =  0;
//             style = 2;
//             colorText[] = COLOR_WHITE;
//             colorBackground[] = COLOR_NOALPHA;
//             font = "RobotoCondensed";
//             sizeEx = 0.03;
//             x = 0; y = 0.75;
//             w = 1.0;  h = 0.1;
//             text = "$STR_DEPLOY_IN_PROGRESS";
//         };
//     };

// // TODO: TBD: Rework and implementation of the Status Overlay
// /*
//     class statusoverlay
//     {
//         name = "statusoverlay";
//         duration = 999999;
//         idd = KPLIB_IDD_CORE_RSCTITLES_STATUSOVERLAY;
//         movingEnable = true;
//         onLoad = "uiNamespace setVariable ['GUI_OVERLAY', _this select 0];";
//         controls[]= {
//             BGPicture,
//             PictureFOBShadow, PictureFOB, LabelFOB,
//             PictureSuppliesShadow, PictureSupplies, LabelSupplies,
//             PictureAmmoShadow, PictureAmmo, LabelAmmo,
//             PictureFuelShadow, PictureFuel, LabelFuel,
//             PictureCapShadow, PictureCap, LabelCap,
//             PictureHeliShadow, PictureHeli, LabelHeli,
//             PicturePlaneShadow, PicturePlane, LabelPlane,
//             PictureCombatReadinessShadow, PictureCombatReadiness, LabelCombatReadiness,
//             PictureCivRepShadow, PictureCivRep, LabelCivRep,
//             PictureIntelShadow, PictureIntel, LabelIntel,
//             BGPictureActiveSectors, BGPictureSector,
//             CaptureFrame_OPFOR, CaptureFrame_BLUFOR, CaptureFrame,
//             LabelPoint, CentralShadow, CentralLabel,
//             ActiveSectors, AlertBGPicture, AlertLabel, AlertTimer
//         };

//         class BGPicture {
//             idc = 758001;
//             type =  CT_STATIC;
//             style = ST_PICTURE;
//             colorText[] = {0.8,0.8,0.8,0.9};
//             colorBackground[] = COLOR_NOALPHA;
//             font = "puristaMedium";
//             sizeEx = 0.5;
//             x = 0.95 * safezoneW + safezoneX;
//             w = 0.075 * safezoneW;
//             y = 0.395 * safezoneH + safezoneY;
//             h = 0.255 * safezoneH;
//             text = "res\gradient.paa";
//         };
//         class BGPictureSector : BGPicture {
//             idc = 201;
//             x = 0.9 * safezoneW + safezoneX;
//             w = 0.15 * safezoneW;
//             y = 0.33 * safezoneH + safezoneY;
//             h = 0.05 * safezoneH;
//         };

//         class GenericLabel69 {
//             idc = KPLIB_IDC_UNDEFINED;
//             type =  CT_STATIC;
//             style = ST_RIGHT;
//             colorBackground[] = COLOR_NOALPHA;
//             font = "puristaMedium";
//             sizeEx = 0.022 * safezoneH;
//             x = 0.905 * safezoneW + safezoneX;
//             w = 0.08 * safezoneW;
//             y = 0.5225 * safezoneH + safezoneY;
//             h = 0.04 * safezoneH;
//             text = "";
//             shadow = 2;
//         };
//         class CentralLabel : GenericLabel69 {
//             idc = 266;
//             type = CT_STATIC;
//             style = ST_CENTER;
//             colorText[] = {1,1,0,1};
//             sizeEx = 0.03 * safezoneH;
//             x = 0 * safezoneW + safezoneX;
//             w = 1 * safezoneW;
//             y = 0.2 * safezoneH + safezoneY;
//             h = 0.05 * safezoneH;
//             text = "";
//         };
//         class CentralShadow : CentralLabel {
//             idc = 267;
//             shadow = 1;
//         };

//         class GenericPicture69 {
//             idc = KPLIB_IDC_UNDEFINED;
//             type =  CT_STATIC;
//             style = ST_PICTURE;
//             colorText[] = {0.9,0.9,0.9,1};
//             colorBackground[] = COLOR_NOALPHA;
//             font = "puristaMedium";
//             sizeEx = 0.5;
//             x = 0.985 * safezoneW + safezoneX;
//             w = 0.012 * safezoneW;
//             h = 0.0213333333 * safezoneH;
//         };

//         class PictureFOB : GenericPicture69 {
//             idc = 758002;
//             y = (0.4 + ( ICONE_SPACY * 0 ) ) * safezoneH + safezoneY;
//             text = "\A3\ui_f\data\map\markers\handdrawn\flag_CA.paa";
//         };
//         class PictureFOBShadow : PictureFOB {
//             idc = 758003;
//             y = (0.4 + SHADOW_Y + ( ICONE_SPACY * 0 ) ) * safezoneH + safezoneY;
//             x = (0.985 + SHADOW_X) * safezoneW + safezoneX;
//             colorText[] = {0,0,0,0.7};
//         };
//         class LabelFOB : GenericLabel69 {
//             idc = 758004;
//             text = "";
//             y = (0.39 + ( ICONE_SPACY * 0 ) ) * safezoneH + safezoneY;
//             colorText[] = {0.8, 0.8, 0.8, 1};
//         };

//         class PictureSupplies : GenericPicture69 {
//             idc = 758005;
//             y = (0.4 + ( ICONE_SPACY * 1 ) ) * safezoneH + safezoneY;
//             text = "res\ui_manpo.paa";
//         };
//         class PictureSuppliesShadow : PictureSupplies {
//             idc = 758006;
//             y = (0.4 + SHADOW_Y + ( ICONE_SPACY * 1 ) ) * safezoneH + safezoneY;
//             x = (0.985 + SHADOW_X) * safezoneW + safezoneX;
//             colorText[] = {0,0,0,0.7};
//         };
//         class LabelSupplies : GenericLabel69 {
//             idc = 758007;
//             text = "";
//             y = (0.39 + ( ICONE_SPACY * 1 ) ) * safezoneH + safezoneY;
//             colorText[] = {0, 0.75, 0, 1};
//         };

//         class PictureAmmo : GenericPicture69 {
//             idc = 758008;
//             y = (0.4 + ( ICONE_SPACY * 2 ) ) * safezoneH + safezoneY;
//             text = "res\ui_ammo.paa";
//         };
//         class PictureAmmoShadow : PictureAmmo {
//             idc = 758009;
//             y = (0.4 + SHADOW_Y + ( ICONE_SPACY * 2 ) ) * safezoneH + safezoneY;
//             x = (0.985 + SHADOW_X) * safezoneW + safezoneX;
//             colorText[] = {0,0,0,0.7};
//         };
//         class LabelAmmo : GenericLabel69 {
//             idc = 758010;
//             text = "";
//             y = (0.39 + ( ICONE_SPACY * 2 ) ) * safezoneH + safezoneY;
//             colorText[] = {0.75, 0, 0, 1};
//         };

//         class PictureFuel : GenericPicture69 {
//             idc = 758011;
//             y = (0.4 + ( ICONE_SPACY * 3 ) ) * safezoneH + safezoneY;
//             text = "res\ui_fuel.paa";
//         };
//         class PictureFuelShadow : PictureFuel {
//             idc = 758012;
//             y = (0.4 + SHADOW_Y + ( ICONE_SPACY * 3 ) ) * safezoneH + safezoneY;
//             x = (0.985 + SHADOW_X) * safezoneW + safezoneX;
//             colorText[] = {0,0,0,0.7};
//         };
//         class LabelFuel : GenericLabel69 {
//             idc = 758013;
//             text = "";
//             y = (0.39 + ( ICONE_SPACY * 3 ) ) * safezoneH + safezoneY;
//             colorText[] = {0.75, 0.75, 0, 1};
//         };

//         class PictureCap : GenericPicture69 {
//             idc = 758014;
//             y = (0.4 + ( ICONE_SPACY * 4 ) ) * safezoneH + safezoneY;
//             text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
//         };
//         class PictureCapShadow : PictureCap {
//             idc = 758015;
//             y = (0.4 + SHADOW_Y + ( ICONE_SPACY * 4 ) ) * safezoneH + safezoneY;
//             x = (0.985 + SHADOW_X) * safezoneW + safezoneX;
//             colorText[] = {0,0,0,0.7};
//         };
//         class LabelCap : GenericLabel69 {
//             idc = 758016;
//             text = "";
//             y = (0.39 + ( ICONE_SPACY * 4 ) ) * safezoneH + safezoneY;
//             colorText[] = {0.8, 0.8, 0.8, 1};
//         };

//         class PictureHeli : GenericPicture69 {
//             idc = 758017;
//             y = (0.4 + ( ICONE_SPACY * 5 ) ) * safezoneH + safezoneY;
//             text = "\A3\air_f_beta\Heli_Transport_01\Data\UI\Map_Heli_Transport_01_base_CA.paa";
//         };
//         class PictureHeliShadow : PictureHeli {
//             idc = 758018;
//             y = (0.4 + SHADOW_Y + ( ICONE_SPACY * 5 ) ) * safezoneH + safezoneY;
//             x = (0.985 + SHADOW_X) * safezoneW + safezoneX;
//             colorText[] = {0,0,0,0.7};
//         };
//         class LabelHeli : GenericLabel69 {
//             idc = 758019;
//             text = "";
//             y = (0.39 + ( ICONE_SPACY * 5 ) ) * safezoneH + safezoneY;
//             colorText[] = {0.8, 0.8, 0.8, 1};
//         };

//         class PicturePlane : GenericPicture69 {
//             idc = 758020;
//             y = (0.4 + ( ICONE_SPACY * 6 ) ) * safezoneH + safezoneY;
//             text = "\A3\Air_F_EPC\Plane_CAS_01\Data\UI\Map_Plane_CAS_01_CA.paa";
//         };
//         class PicturePlaneShadow : PicturePlane {
//             idc = 758021;
//             y = (0.4 + SHADOW_Y + ( ICONE_SPACY * 6 ) ) * safezoneH + safezoneY;
//             x = (0.985 + SHADOW_X) * safezoneW + safezoneX;
//             colorText[] = {0,0,0,0.7};
//         };
//         class LabelPlane : GenericLabel69 {
//             idc = 758022;
//             text = "";
//             y = (0.39 + ( ICONE_SPACY * 6 ) ) * safezoneH + safezoneY;
//             colorText[] = {0.8, 0.8, 0.8, 1};
//         };

//         class PictureCombatReadiness : GenericPicture69 {
//             idc = 758023;
//             y = (0.4 + ( ICONE_SPACY * 7 ) ) * safezoneH + safezoneY;
//             text = "\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa";
//         };
//         class PictureCombatReadinessShadow : PictureCombatReadiness {
//             idc = 758024;
//             y = (0.4 + SHADOW_Y + ( ICONE_SPACY * 7 ) ) * safezoneH + safezoneY;
//             x = (0.985 + SHADOW_X) * safezoneW + safezoneX;
//             colorText[] = {0,0,0,0.7};
//         };
//         class LabelCombatReadiness : GenericLabel69 {
//             idc = 758025;
//             text = "";
//             y = (0.39 + ( ICONE_SPACY * 7 ) ) * safezoneH + safezoneY;
//             colorText[] = {0.8, 0.8, 0.8, 1};
//         };

//         class PictureCivRep : GenericPicture69 {
//             idc = 758026;
//             y = (0.4 + ( ICONE_SPACY * 8 ) ) * safezoneH + safezoneY;
//             text = "\A3\ui_f\data\map\mapcontrol\tourism_CA.paa";
//         };
//         class PictureCivRepShadow : PictureCivRep {
//             idc = 758027;
//             y = (0.4 + SHADOW_Y + ( ICONE_SPACY * 8 ) ) * safezoneH + safezoneY;
//             x = (0.985 + SHADOW_X) * safezoneW + safezoneX;
//             colorText[] = {0,0,0,0.7};
//         };
//         class LabelCivRep : GenericLabel69 {
//             idc = 758028;
//             text = "";
//             y = (0.39 + ( ICONE_SPACY * 8 ) ) * safezoneH + safezoneY;
//             colorText[] = {0.8, 0.8, 0.8, 1};
//         };

//         class PictureIntel : GenericPicture69 {
//             idc = 758029;
//             colorText[] = {0,0.45,0.95,1};
//             y = (0.4 + ( ICONE_SPACY * 9 ) ) * safezoneH + safezoneY;
//             text = "\A3\Ui_f\data\GUI\Cfg\Ranks\general_gs.paa";
//         };
//         class PictureIntelShadow : PictureIntel {
//             idc = 758030;
//             y = (0.4 + SHADOW_Y + ( ICONE_SPACY * 9 ) ) * safezoneH + safezoneY;
//             x = (0.985 + SHADOW_X) * safezoneW + safezoneX;
//             colorText[] = {0,0,0,0.7};
//         };
//         class LabelIntel : GenericLabel69 {
//             idc = 758031;
//             text = "";
//             y = (0.39 + ( ICONE_SPACY * 9 ) ) * safezoneH + safezoneY;
//             colorText[] = {0, 0.45, 0.95, 1};
//         };

//         class CaptureFrameStandard {
//             idc = KPLIB_IDC_UNDEFINED;
//             type =  CT_STATIC;
//             font = "puristaMedium";
//             sizeEx = 0.023;
//             text = "";
//         };
//         class CaptureFrame : CaptureFrameStandard {
//             idc = 202;
//             style = ST_FRAME;
//             colorText[] = COLOR_BLACK;
//             colorBackground[] = COLOR_OPFOR_NOALPHA;
//             x = 0.9125 * safezoneW + safezoneX;
//             w = 0.085 * safezoneW;
//             y = 0.358 * safezoneH + safezoneY;
//             h = 0.012 * safezoneH;
//         };
//         class CaptureFrame_OPFOR : CaptureFrameStandard{
//             idc = 203;
//             style = ST_TYPE;
//             colorText[] = {0.6, 0, 0, 1};
//             colorBackground[] = {0.6, 0, 0, 1};
//             x = 0.9125 * safezoneW + safezoneX;
//             w = 0.084 * safezoneW;
//             y = 0.358 * safezoneH + safezoneY;
//             h = 0.011 * safezoneH;

//         };
//         class CaptureFrame_BLUFOR : CaptureFrameStandard{
//             idc = 244;
//             style = ST_TYPE;
//             colorText[] = {0, 0.2, 0.6, 1};
//             colorBackground[] = {0, 0.2, 0.6, 1};
//             x = 0.9125 * safezoneW + safezoneX;
//             w = 0.084 * safezoneW;
//             y = 0.358 * safezoneH + safezoneY;
//             h = 0.011 * safezoneH;
//         };

//         class LabelPoint : GenericLabel69 {
//             idc = 205;
//             text = "";
//             style = ST_RIGHT;
//             sizeEx = 0.024 * safezoneH;
//             x = 0.8 * safezoneW + safezoneX;
//             w = 0.2 * safezoneW;
//             y = 0.33 * safezoneH + safezoneY;
//             h = 0.03 * safezoneH;
//             colorText[] = {0.7, 0, 0, 1};
//         };

//         class ActiveSectors	{
//             idc = 516;
//             type = CT_STRUCTURED_TEXT;
//             colorBackground[] = COLOR_NOALPHA;
//             style = ST_RIGHT;
//             x = 0.7 * safezoneW + safezoneX;
//             w = 0.295 * safezoneW;
//             y = 0.8 * safezoneH + safezoneY;
//             h = 0.2 * safezoneH;
//             text= "";
//             size = 0.02 * safezoneH;
//             sizeEx = 0.02 * safezoneH;
//             shadow = 2;
//             font = "puristaMedium";
//             color = "#e0e000";
//             align = "right";
//             valign = "top";
//         };

//         class BGPictureActiveSectors : BGPicture {
//             idc = 517;
//             x = 0.93 * safezoneW + safezoneX;
//             w = 0.1 * safezoneW;
//             y = 0.8 * safezoneH + safezoneY;
//             h = 0.2 * safezoneH;
//         };
//         class AlertBGPicture : BGPicture {
//             idc = 401;
//             x = 0.9 * safezoneW + safezoneX;
//             w = 0.15 * safezoneW;
//             y = 0.27 * safezoneH + safezoneY;
//             h = 0.05 * safezoneH;
//         };

//         class AlertLabel : GenericLabel69 {
//             idc = 402;
//             text = "";
//             style = ST_CENTER;
//             sizeEx = 0.022 * safezoneH;
//             x = 0.9 * safezoneW + safezoneX;
//             w = 0.1 * safezoneW;
//             y = 0.2675 * safezoneH + safezoneY;
//             h = 0.03 * safezoneH;
//             colorText[] = {0.85, 0, 0, 1};
//         };
//         class AlertTimer : GenericLabel69 {
//             idc = 403;
//             text = "";
//             style = ST_CENTER;
//             sizeEx = 0.026 * safezoneH;
//             x = 0.9 * safezoneW + safezoneX;
//             w = 0.1 * safezoneW;
//             y = 0.29 * safezoneH + safezoneY;
//             h = 0.03 * safezoneH;
//             colorText[] = {0.85, 0, 0, 1};
//         };
//     };
// */
// };
