/*
    KPLIB_fnc_logisticsMgr_lnbConvoy_onLoad

    File: fn_logisticsMgr_lnbConvoy_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-27 15:14:51
    Last Update: 2021-02-27 15:14:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _lnbConvoy - the logistics convoy LISTNBOX control [CONTROL, default: controlNull]
        _config - the config

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/lnbAddRow
        https://community.bistudio.com/wiki/lnbSetPicture
        https://community.bistudio.com/wiki/lnbSetTextRight
 */

params [
    ["_lnbConvoy", controlNull, [controlNull]]
    , "_config"
];

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

private _numberPlaceholder = "";

private _get = { (random [0, 150, 300]) toFixed 0; };

for "_i" from 1 to 20 do {

    private _transportNumber = str _i;

    private _rowIndex = _lnbConvoy lnbAddRow [
        _transportNumber
        , _numberPlaceholder
        , [] call _get
        , _numberPlaceholder
        , [] call _get
        , _numberPlaceholder
        , [] call _get
    ];

    _lnbConvoy lnbSetTextRight [[_rowIndex, 0], _transportNumber];
};

true;
