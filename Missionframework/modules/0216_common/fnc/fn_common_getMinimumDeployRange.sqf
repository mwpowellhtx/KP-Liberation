/*
    KPLIB_fnc_common_getMinimumDeployRange

    File: fn_common_getMinimumDeployRange.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-18 21:45:15
    Last Update: 2021-05-26 18:27:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the MINIMUM DEPLOY RANGE between two FOB zones, or an FOB zone and
        the nearest SECTOR. One and a half times FOB range accounting for not only
        1x FOB radius buffer between edges of two FOB zones, but also from the CENTER
        of the new FOB zone, half its radius. Or max of the SECTOR ACTIVATION RANGE,
        whichever is greater, should be plenty of buffer for us.

    Parameter(s):
        NONE

    Returns:
        Returns the MINIMUM DEPLOY RANGE to use when deploying an FOB zone [SCALAR]

    Remarks:
        Because this asks questions of FOBS, EDEN, and SECTORS modules, it is better
        thought of in terms of the COMMON module.

    References:
        https://community.bistudio.com/wiki/selectMax
 */

selectMax [
    1.5 * KPLIB_param_fobs_range
    , KPLIB_param_eden_startbaseRadius
    , KPLIB_param_sectors_actRange
];
