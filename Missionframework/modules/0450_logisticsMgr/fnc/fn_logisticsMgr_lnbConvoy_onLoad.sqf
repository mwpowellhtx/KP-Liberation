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
        _lngConvoy - the logistics convoy LISTNBOX control [CONTROL, default: controlNull]
        _config - the config

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_lngConvoy", controlNull, [controlNull]]
    , "_config"
];

lnbClear _lngConvoy;

for "_i" from 0 to 99 do {
    _lngConvoy lnbAddRow [str _i, "This Is A Test"];
};

true;
