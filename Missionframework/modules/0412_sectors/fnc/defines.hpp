/*
    File: defines.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-13 20:38:31
    Last Update: 2021-06-13 20:38:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...
 */

/* Sub values are expected to be:
 * %1 - Unit|Tank
 * %2 - F|E
 */
#define KPLIB_SECTORS_CAP_DIVIDEND_OFFSET_FORMAT    "KPLIB_param_sectors_cap%1DividendOffset%2"
#define KPLIB_SECTORS_CAP_DIVISOR_OFFSET_FORMAT     "KPLIB_param_sectors_cap%1DivisorOffset%2"
#define KPLIB_SECTORS_CAP_RATIO_BIAS_FORMAT         "KPLIB_param_sectors_cap%1RatioBias%2"
#define KPLIB_SECTORS_CAP_THRESHOLD_FORMAT          "KPLIB_param_sectors_cap%1Threshold%2"
