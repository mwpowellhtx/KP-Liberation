/*
    KPLIB_fnc_logisticsMgr_lnbConvoy_onClear

    File: fn_logisticsMgr_lnbConvoy_onClear.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 09:57:10
    Last Update: 2021-02-28 09:57:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Clears the CONVOY LISTNBOX and prepares it to receive the convoy transport values.

    Parameters:
        _lnbConvoy - the logistics convoy LISTNBOX control [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/lnbAddRow
        https://community.bistudio.com/wiki/lnbSetPicture
 */

params [
    ["_lnbConvoy", controlNull, [controlNull]]
];

// TODO: TBD: and perhaps some error handling...
if (isNull _lnbConvoy) exitWith {
    false;
};

lnbClear _lnbConvoy;

private _transportPlaceholder = toUpper localize "STR_KPLIB_LOGISTICSMGR_LBL_TRANSPORT";
private _picturePlaceholder = "";

_lnbConvoy lnbAddRow [
    _transportPlaceholder
    , _picturePlaceholder
    , localize "STR_KPLIB_LOGISTICSMGR_LBL_SUP"
    , _picturePlaceholder
    , localize "STR_KPLIB_LOGISTICSMGR_LBL_AMM"
    , _picturePlaceholder
    , localize "STR_KPLIB_LOGISTICSMGR_LBL_FUE"
];

{
    private _resourceColumnIndex = (2 * (_forEachIndex + 1)) - 1;
    private _resourcePath = localize _x;
    private _pos = [0, _resourceColumnIndex];
    _lnbConvoy lnbSetPicture [_pos, _resourcePath];
} forEach [
    "STR_KPLIB_LOGISTICSMGR_IMG_SUP"
    , "STR_KPLIB_LOGISTICSMGR_IMG_AMM"
    , "STR_KPLIB_LOGISTICSMGR_IMG_FUE"
];

true;
