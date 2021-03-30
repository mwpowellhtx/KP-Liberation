
// ...

// // TODO: TBD: whether or not we need an "RscTitles" IDD?
//#define KPLIB_IDD_RSC_TITLES                            90000

#define KPLIB_IDD_HUD_OVERLAY                           90000

#define KPLIB_IDC_HUD_GRPSECTOR                         90100
#define KPLIB_IDC_HUD_GRPSECTOR_LBLMARKERTEXT           90110

#define KPLIB_IDC_HUD_GRPFOB                            90200
#define KPLIB_IDC_HUD_GRPFOB_LBLMARKERTEXT              90210
#define KPLIB_IDC_HUD_GRPFOB_LBLMARKERPICTURE           90220

#define KPLIB_IDC_HUD_LNB_FOB                           90230

#define KPLIB_IDC_HUD_CT_FOB                            90300

/* Which IDC range is MORE than sufficient we think to support FOB REPORT
 * controls, x3 per header/row added, and we expect 11 in all, including
 * the FOB header row itself. */

#define KPLIB_IDC_HUD_CT_FOB_IDC_FIRST                  90301
#define KPLIB_IDC_HUD_CT_FOB_IDC_LAST                   90399

// // TODO: TBD: this may or may not work...
// #define KPLIB_IDD_RSC_TITLES_BLANK (KPLIB_IDD_RSC_TITLES+1)
// #define KPLIB_IDD_HUD_OVERLAY_SITREP_FOB (KPLIB_IDD_RSC_TITLES+100)
// #define KPLIB_IDD_HUD_OVERLAY_SITREP_SECTOR (KPLIB_IDD_RSC_TITLES+200)
// #define KPLIB_IDD_CORE_RSCTITLE_SITREP_HALO (KPLIB_IDD_RSC_TITLES+300)
